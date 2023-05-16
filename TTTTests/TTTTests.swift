//
//  TTTTests.swift
//  TTTTests
//
//  Created by Hasan on 15/05/23.
//

import XCTest
@testable import TTT

final class TTTTests: XCTestCase {

    func test_feedLoad_doesNotRequestOnViewDidLoad() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadFeedCallCount, 0)
    }
    
    func test_whenViewLoaded_IBOutletsAreConnected() throws {
        let (sut, _) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        let _ = try? XCTUnwrap(sut.webView, "The webview WKWebView is not connected")
        let _ = try? XCTUnwrap(sut.textField, "The UITextField is not connected")
        let _ = try? XCTUnwrap(sut.button, "The UIButton is not connected")
    }
    
    func test_requestFeedFromLoader_whenDidEndEditingTyping() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        
        sut.textField.sendActions(for: UIControl.Event.editingDidEnd)
        
        XCTAssertEqual(loader.loadFeedCallCount, 1)
    }
    
    func test_loadFeedCompletion_shouldRequestOnSuccess() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        
        sut.textField.sendActions(for: UIControl.Event.editingDidEnd)
        XCTAssertEqual(loader.loadFeedCallCount, 1)
        
        loader.completeFeedLoadingSuccessfully()
        XCTAssertNotNil(sut.webView.url)
    }
    
    func test_loadFeedCompletion_shouldNotRequestOnFailure() {
        let (sut, loader) = makeSUT()
        sut.loadViewIfNeeded()
        
        sut.textField.sendActions(for: UIControl.Event.editingDidEnd)
        XCTAssertEqual(loader.loadFeedCallCount, 1)
        
        loader.completeFeedLoadingWithError(at: 0)
        XCTAssertNil(sut.webView.url)
    }
    
    // MARK: Helper
    
    private class FeedStoreSpy: FeedStore {
        func insert(_ feed: String, completion: @escaping InsertionCompletion) {}
        func retrieve(completion: @escaping RetrievalCompletion) {}
    }

    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let store = FeedStoreSpy()
        let sut = FeedUIComposer.feedComposedWith(feedLoader: loader, feedStore: store)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
}
