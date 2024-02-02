//
//  ListProtocols.swift
// inter
//
//  Created by Wagner Sales on 29/01/24.
//

import Foundation

protocol ListInputProtocol {
    var viewController: ListOutputProtocol? { get set }
    var rows: [ListRowViewModel] { get }
    func didSelectRow(indexPath: IndexPath)
    func didTapReload()
    func didTapCancelSearch()
    func didTapSearch(text: String?)
    func pullToRefresh()
    func viewDidLoad()
}

protocol ListOutputProtocol {
    func setTitle(_ title: String)
    func startLoading()
    func success()
    func failure()
}
