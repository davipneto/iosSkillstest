//
//  RealmService.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 06/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    var realm: Realm?
    
    fileprivate init() {
        realm = try? Realm()
    }
    
    func addUser(user: User) -> Error? {
        do {
            try realm?.write {
                realm?.add(user)
            }
        } catch let error {
            return error
        }
        return nil
    }
    
    func getUsersChangeset() -> Results<User>? {
        return realm?.objects(User.self)
    }
    
    func getUsers() -> [User] {
        return getUsersChangeset()?.toArray() ?? []
    }
    
    func getUser(email: String?) -> User? {
        return realm?.object(ofType: User.self, forPrimaryKey: email)
    }
    
    func updateUser(user: User, name: String, password: String) -> Error? {
        do {
            try realm?.write {
                user.name = name
                user.password = password
            }
        } catch let error {
            return error
        }
        return nil
    }
    
}
