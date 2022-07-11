//
//  Model.swift
//  Domain
//
//  Created by Vitor Trimer on 11/07/22.
//

import Foundation

public protocol Model: Encodable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
