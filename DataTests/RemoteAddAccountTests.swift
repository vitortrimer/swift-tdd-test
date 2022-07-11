//
//  DataTests.swift
//  DataTests
//
//  Created by Vitor Trimer on 08/07/22.
//

import XCTest
@testable import Domain

class RemoteAddAccount {
    private let url: URL
    private let httpClient: HttpPostClient
    
    init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func add(account: AddAccountModel) {
        httpClient.post(to: self.url, with: account.toData())
    }
}

protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}

class RemoteAddAccountTests: XCTestCase {
    let mockAccountModel = AddAccountModel(name: "name", email: "unit@test.com", password: "password", passwordConfirmation: "password")
    
    // MARK: - Usual Behaviors
    
    func test_add_shouldCallHttpClientWith_correct_url() throws {
        // GIVEN
        let url = URL(string: "https://any-url.com")!
        let (sut, httpClientSpy) = makeSut()
        
        // WHEN
        sut.add(account: mockAccountModel)
        
        // THEN
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    func test_add_shouldCallHttpClientWith_correct_data() throws {
        // GIVEN
        let (sut, httpClientSpy) = makeSut()
        
        // WHEN
        sut.add(account: mockAccountModel)
        
        // THEN
        XCTAssertEqual(httpClientSpy.data, mockAccountModel.toData())
    }

    // MARK: - Unusual Behaviors
    func test_add_shouldCallHttpClientWith_incorrect_url() throws {
        // GIVEN
        let url = URL(string: "https://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: URL(string: "https://any-url-incorrect.com")!, httpClient: httpClientSpy)
        
        // WHEN
        sut.add(account: mockAccountModel)
        
        // THEN
        XCTAssertNotEqual(httpClientSpy.url, url)
    }
    
    func test_add_shouldCallHttpClientWith_diff_data() throws {
        // GIVEN
        let (sut, httpClientSpy) = makeSut()
        let wrongMock = AddAccountModel(name: "wrong", email: "wrong@wrong.com", password: "wrong", passwordConfirmation: "wrong")
        
        // WHEN
        sut.add(account: wrongMock)
        
        // THEN
        XCTAssertNotEqual(httpClientSpy.data, mockAccountModel.toData())
    }
    
}

extension RemoteAddAccountTests {
    func makeSut(url: URL = URL(string: "https://any-url.com")!) -> (sut: RemoteAddAccount, httpCleintSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        return (sut, httpClientSpy)
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "name", email: "unit@test.com", password: "password", passwordConfirmation: "password")
    }
    
    class HttpClientSpy: HttpPostClient {
        var url: URL?
        var data: Data?
        
        func post(to url: URL, with data: Data?) {
            self.url = url
            self.data = data
        }
    }
    
}
