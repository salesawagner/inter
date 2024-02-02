//
//  DetailectionViewModelMock.swift
//  interTests
//
//  Created by Wagner Sales on 10/12/23.
//

import Foundation
@testable import inter

extension DetailSectionViewModel {
    static var mock: DetailSectionViewModel {
        .init(thumbnailURL: "", rows: [])
    }
}

extension Array where Element == DetailSectionViewModel {
    static var mock: [DetailSectionViewModel] {
        [.mock]
    }
}
