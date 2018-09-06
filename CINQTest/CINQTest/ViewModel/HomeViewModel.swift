//
//  HomeViewModel.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import RxSwift
import RealmSwift
import RxRealm

class HomeViewModel: NSObject {
    
    var realm: Realm
    var users: Observable<(AnyRealmCollection<User>, RealmChangeset?)>
    let searchText = Variable<String>("")
    var filteredUsers: Observable<[User]>
    
    override init() {
        realm = try! Realm()
        users = Observable
            .changeset(from: realm.objects(User.self))
            .share()
        filteredUsers = Observable.combineLatest(searchText.asObservable(), users) {
            (text, usersChangeSet) in
            let allUsers = usersChangeSet.0.toArray()
            if text.isEmpty {
                return allUsers
            }
            let t = text.lowercased()
            let filtUsers = allUsers.filter {
                $0.email.lowercased().contains(t) ||
                $0.name.lowercased().contains(t)
            }
            return filtUsers
        }
    }
    
}
