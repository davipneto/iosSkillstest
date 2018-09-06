//
//  LoggedUserService.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 06/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import RxSwift

class LoggedUserService {
    static let shared = LoggedUserService()
    private let userEmailKey = "user"
    private let defaults = UserDefaults.standard
    var userObservable: Observable<String?>
    
    fileprivate init() {
        userObservable = defaults.rx
            .observe(String.self, userEmailKey)
    }
    
    func getLoggedUserEmail() -> String? {
        return defaults.value(forKey: userEmailKey) as? String
    }
    
    func setLoggedUserEmail(_ email: String) {
        defaults.set(email, forKey: userEmailKey)
    }
}
