//
//  AddAccount.swift
//  Domain
//
//  Created by Vitor Trimer on 08/07/22.
//

import Foundation

protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping(Result<AccountModel, Error>) -> Void)
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}
