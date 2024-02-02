//
//  DetailViewModel.swift
// inter
//
//  Created by Wagner Sales on 29/01/24.
//

import API

final class DetailViewModel {
    // MARK: Properties

    private var api: APIClient
    private var detail: GetAllResponse

    var viewController: DetailOutputProtocol?
    var sections: [DetailSectionViewModel] = []

    // MARK: Inits

    init(api: APIClient, detail: GetAllResponse) {
        self.api = api
        self.detail = detail
    }

    // MARK: Private Methods

    private func requestDetail() {
        guard let name = detail.name?.common else {
            viewController?.failure()
            return
        }

        viewController?.startLoading()
        api.send(GetByNameRequest(name: name)) { [weak self] result in
            switch result {
            case .success(let response):
                guard let detail = response.first else {
                    self?.viewController?.failure()
                    return
                }

                self?.detail = detail
                self?.buildSection()

            case .failure:
                DispatchQueue.main.async {
                    self?.viewController?.failure()
                }
            }
        }
    }

    private func buildSection() {
        var continents = ""
        detail.continents?.forEach { continents += continents.isEmpty ? $0 : ", \($0)" }

        var languages = ""
        detail.languages?.forEach({ _, value in
            languages += languages.isEmpty ? value : ", \(value)"
        })

        let sections = [DetailSectionViewModel(thumbnailURL: detail.flags?.png, rows: [
            .init(text: "Common name: \(detail.name?.common ?? "-")"),
            .init(text: "Official name: \(detail.name?.official ?? "-")"),
            .init(text: "Area: \(detail.area ?? 0)"),
            .init(text: "Population: \(detail.population ?? 0)"),
            .init(text: "Continent(s): \(continents)"),
            .init(text: "Language(s): \(languages)")
        ])]



        // TODO: continents

        self.sections = sections

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.success()
        }
    }
}

// MARK: - DetailsInputProtocol

extension DetailViewModel: DetailInputProtocol {
    func didTapReloadButton() {
        requestDetail()
    }

    func pullToRefresh() {
        requestDetail()
    }
    
    func viewDidLoad() {
        defer {
            buildSection()
        }

        guard let name = detail.name?.common else {
            return
        }

        viewController?.setTitle(name)
    }
}
