//
//  ListViewModel.swift
// inter
//
//  Created by Wagner Sales on 29/01/24.
//

import API

final class ListViewModel {
    // MARK: Properties

    private let title = "Países"
    private var api: APIClient
    private var response: GetAllRequest.Response = []
    private var responseFiltered: GetAllRequest.Response = [] {
        didSet {
            rows = responseFiltered.toViewModel
        }
    }

    var viewController: ListOutputProtocol?
    var rows: [ListRowViewModel] = []

    // MARK: Inits

    init(api: APIClient = WASAPI(environment: Environment.production)) {
        self.api = api
    }

    // MARK: Private Methods

    private func requestList() {
        viewController?.startLoading()
        api.send(GetAllRequest()) { [weak self] result in
            switch result {
            case .success(let response):
                let responseSorted = response.sorted {
                    guard let name0 = $0.name?.common, let name1 = $1.name?.common else {
                        return $0.name?.common != nil
                    }
                    return name0 < name1
                }
                self?.response = responseSorted
                self?.responseFiltered = responseSorted

                DispatchQueue.main.async {
                    self?.viewController?.success()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }

    private func resetSearch() {
        requestList()
    }
}

// MARK: - ListInputProtocol

extension ListViewModel: ListInputProtocol {
    func didSelectRow(indexPath: IndexPath) {
        let detail = responseFiltered[indexPath.row]
        let detailViewModel = DetailViewModel(api: api, detail: detail)

        (viewController as? UIViewController)?.navigationController?.pushViewController(
            DetailViewController.create(with: detailViewModel),
            animated: true
        )
    }

    func didTapReload() {
        requestList()
    }

    func didTapCancelSearch() {
        resetSearch()
    }

    func didTapSearch(text: String?) {
        guard let text = text, !text.isEmpty else {
            resetSearch()
            return
        }

        responseFiltered = response.filter {
            guard let name = $0.name?.common else { return false }
            return name.contains(text)
        }

        viewController?.startLoading()
        api.send(GetTranslationRequest(nameStartWith: text)) { [weak self] result in
            switch result {
            case .success(let response):
                let responseSorted = response.sorted {
                    guard let name0 = $0.name?.common, let name1 = $1.name?.common else {
                        return $0.name?.common != nil
                    }
                    return name0 < name1
                }
                self?.response = responseSorted
                self?.responseFiltered = responseSorted

                DispatchQueue.main.async {
                    self?.viewController?.success()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }

    func pullToRefresh() {
        requestList()
    }

    func viewDidLoad() {
        viewController?.setTitle(title)
        requestList()
    }
}

private extension Array where Element == GetAllResponse {
    var toViewModel: [ListRowViewModel] {
        compactMap {
            .init(
                thumbnailURL: $0.flags?.png,
                official: $0.name?.official ?? "",
                common: $0.name?.common ?? "",
                capital: $0.capital?.first ?? ""
            )
        }
    }
}
