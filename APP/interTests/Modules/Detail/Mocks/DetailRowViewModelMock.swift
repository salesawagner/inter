//
//  DetailRowViewModelMock.swift
//  interTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import inter

extension DetailRowViewModel {
    static var mock: DetailRowViewModel {
        .init(text: "")
    }
}

extension Array where Element == DetailRowViewModel {
    static var mock: [DetailRowViewModel] {
        [.mock]
    }
}
