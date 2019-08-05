//
//  JordanTests.swift
//  RecipleaseTests
//
//  Created by Jordan MOREAU on 05/08/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import XCTest
@testable import Reciplease
class EdamamServiceTests: XCTestCase {

    func testGetEdamamRecipesShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipeList(ingredients: "lemon") { success, recipeList in
            XCTAssertFalse(success)
            XCTAssertNil(recipeList)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetEdamamRecipesShouldPostFailedCallbacIfNoDatak() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipeList(ingredients: "lemon") { success, recipeList in
            XCTAssertFalse(success)
            XCTAssertNil(recipeList)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetEdamamRecipesShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipeList(ingredients: "lemon") { success, recipeList in
            XCTAssertFalse(success)
            XCTAssertNil(recipeList)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetEdamamRecipesShouldPostFailedCallbackIfResponseCorrectAndNilData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipeList(ingredients: "lemon") { success, recipeList in
            XCTAssertFalse(success)
            XCTAssertNil(recipeList)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetEdamamRecipesShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipeList(ingredients: "lemon") { success, recipeList in
            XCTAssertFalse(success)
            XCTAssertNil(recipeList)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetEdamamRecipesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let edamamSessionFake = EdamamSessionFake(fakeResponse: fakeResponse)
        let edamamService = EdamamService(edamamSession: edamamSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        edamamService.getRecipeList(ingredients: "lemon") { success, recipeList in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipeList)
            XCTAssertEqual(recipeList?.hits[0].recipe.label, "Lemon Sorbet")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }


}
