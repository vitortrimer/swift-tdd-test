//
//  RemoteAddAccount.swift
//  Data
//
//  Created by Vitor Trimer on 11/07/22.
//

import Foundation
import Domain

public final class RemoteAddAccount {
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
