//
//  ListRowViewModelMock.swift
//  interTests
//
//  Created by Wagner Sales on 30/01/24.
//

@testable import inter

extension ListRowViewModel {
    static var mock: ListRowViewModel {
        .init(thumbnailURL: "", official: "", common: "", capital: "")
    }
}

extension Array where Element == ListRowViewModel {
    static var mock: [ListRowViewModel] {
        [.mock]
    }
}

