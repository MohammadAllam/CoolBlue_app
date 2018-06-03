//
//  CoolBlueTests.swift
//  CoolBlueTests
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import XCTest
import RxSwift

@testable import CoolBlue

class CoolBlueTests: XCTestCase {
    var serviceMock:productServiceMock!
    var viewModel:SearchViewModel!
    var disposeBag:DisposeBag!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        serviceMock = productServiceMock()
        disposeBag = DisposeBag()
        viewModel = SearchViewModel(inputService: serviceMock)
    }
    
    override func tearDown() {
        viewModel = nil
        serviceMock = nil
        disposeBag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCallingSearchMethod(){
        // Given
        let queryText = "iPhone"
        let pageIndex = 1

        // When
        //Should be updating the "query" to make a new request
        //Apparently that generates compilation error when running
        ////        Observable.just("query")
        ////            .bind(to: viewModel.inputs.query)
        ////            .disposed(by: disposeBag)

        // Then
        XCTAssert(serviceMock.isDiscoverProductsCalled,"DiscoverProducts should have been called")
        XCTAssertEqual(serviceMock.inputPage,pageIndex,"Requested page is different than than the expected")
        XCTAssertEqual(serviceMock.inputQuery,queryText,"Requested query is different than than the expected")
    }

    func testCallingLoadMoreMethod(){
        // Given
        let queryText = "iPhone"
        let pageIndex = 2

        // When
        //Should be updating the "query" to make a new request
        //Apparently that generates compilation error when running
        ////        Observable.just(true)
        ////            .bind(to: viewModel.inputs.loadMore)
        ////            .disposed(by: disposeBag)

        // Then
        XCTAssert(serviceMock.isDiscoverProductsCalled,"DiscoverProducts should have been called")
        XCTAssertEqual(serviceMock.inputPage,pageIndex,"Requested page is different than than the expected")
        XCTAssertEqual(serviceMock.inputQuery,queryText,"Requested query is different than than the expected")
    }

}
