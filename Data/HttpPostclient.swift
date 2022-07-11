//
//  HttpPostclient.swift
//  Data
//
//  Created by Vitor Trimer on 11/07/22.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
