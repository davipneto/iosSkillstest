//
//  User.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import RealmSwift

class User: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    
    override static func primaryKey() -> String? {
        return "email"
    }
}
