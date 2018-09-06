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
    
    var users: Observable<(AnyRealmCollection<User>, RealmChangeset?)> = Observable.never()
    let searchText = Variable<String>("")
    var filteredUsers: Observable<[User]> = Observable.never()
    var loggedEmailObserver: Observable<String> = Observable.never()
    
    override init() {
        let realm = RealmService.shared
        guard let usersChangeset = realm.getUsersChangeset() else {return}
        users = Observable
            .changeset(from: usersChangeset)
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
        loggedEmailObserver = LoggedUserService.shared.userObservable
            .map {
                if $0 == nil {
                    return ""
                }
                let user = realm.getUser(email: $0)
                let name = user?.name ?? ""
                return "Olá, " + name
            }        
    }
    
}
