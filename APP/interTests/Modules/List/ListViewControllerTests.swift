//
//  ListViewControllerTests.swift
//  interTests
//
//  Created by Wagner Sales on 30/01/24.
//

import XCTest
@testable import inter

final class ListViewControllerTests: XCTestCase {
    private func makeSUT(expectation: XCTestExpectation? = nil) -> (
        sut: ListViewController,
        viewModel: ListViewModelSpy
    ) {
        let viewModelSpy = ListViewModelSpy(expectation: expectation)
        let sut = ListViewController.create(with: viewModelSpy)
        return (sut, viewModelSpy)
    }

    private func loadView(sut: ListViewController) {
        let window = UIWindow()
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

    func test_viewDidLoad_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        loadView(sut: sut)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.viewDidLoad])
    }

    func test_didSelectRow_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.tableView(UITableView(), didSelectRowAt: .init(row: 0, section: 0))
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didSelecteRow))
    }

    func test_didTapReloadButton_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.didTapReloadButton()
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didTapReload))
    }

    func test_pullToRefresh_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.pullToRefresh()
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.pullToRefresh))
    }

    func test_didTapSearch_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.searchBarSearchButtonClicked(UISearchBar())
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didTapSearch))
    }

    func test_didTapCancelSearch_shouldReceiveCorrectMessages() {
        let (sut, viewModelSpy) = makeSUT()
        viewModelSpy.rows = .mock
        loadView(sut: sut)

        sut.searchBarCancelButtonClicked(UISearchBar())
        XCTAssertTrue(viewModelSpy.receivedMessages.contains(.didTapCancelSearch))
    }

    func test_failure_shouldReceiveCorrectMessages() {
        let (sut, _) = makeSUT()
        loadView(sut: sut)

        sut.failure()
        XCTAssertNotNil(sut.errorView)
    }
}

