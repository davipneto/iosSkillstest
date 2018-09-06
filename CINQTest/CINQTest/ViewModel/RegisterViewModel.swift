//
//  RegisterViewModel.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import RxSwift
import RealmSwift
import RxRealm

class RegisterViewModel: NSObject {
    
    let name = Variable<String>("")
    let email = Variable<String>("")
    let password = Variable<String>("")
    let errorResultSubject = PublishSubject<String>()
    let registerResultSubject = PublishSubject<User>()
    let registerDidTapSubject = PublishSubject<Void>()
    private var credentialsObs: Observable<RegisterCredentials> {
        return Observable.combineLatest(email.asObservable(), password.asObservable(), name.asObservable()) {
            (email, pass, name) in
            return RegisterCredentials(email: email, password: pass, name: name)
        }
    }
    var user: User?
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        registerDidTapSubject
            .withLatestFrom(credentialsObs)
            .map { (credentials) -> String? in
                self.verifyCredentials(credentials: credentials)
            }
            .subscribe(onNext: { (error) in
                if let err = error {
                    self.errorResultSubject.onNext(err)
                } else {
                    self.errorResultSubject.onCompleted()
                    self.registerResultSubject.onNext(self.user!)
                    self.registerResultSubject.onCompleted()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getLoggedUser() -> String? {
        return LoggedUserService.shared.getLoggedUserEmail()
    }
    
    func setLoggedUser(_ email: String) {
        LoggedUserService.shared.setLoggedUserEmail(email)
    }
    
    func verifyCredentials(credentials: RegisterCredentials) -> String? {
        if credentials.email.isEmpty || credentials.name.isEmpty || credentials.password.isEmpty {
            return Constants.Errors.allFieldsRequired
        }
        let realm = RealmService.shared
        if let u = self.user {
            return realm.updateUser(user: u, name: credentials.name, password: credentials.password)?.localizedDescription
        }
        if realm.getUser(email: credentials.email) != nil {
            return Constants.Errors.emailAlreadyUsed
        }
        let user = User()
        user.name = credentials.name
        user.email = credentials.email
        user.password = credentials.password
        self.user = user
        return realm.addUser(user: user)?.localizedDescription
    }
}

struct RegisterCredentials {
    var email: String
    var password: String
    var name: String
}
