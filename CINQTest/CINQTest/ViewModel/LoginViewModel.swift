//
//  LoginViewModel.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 05/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import RxSwift
import RealmSwift

class LoginViewModel: NSObject {
    
    let email = Variable<String>("")
    let password = Variable<String>("")
    let errorResultSubject = PublishSubject<String>()
    let loginResultSubject = PublishSubject<Void>()
    let logInDidTapSubject = PublishSubject<Void>()
    private var credentialsObs: Observable<LoginCredentials> {
        return Observable.combineLatest(email.asObservable(), password.asObservable()) {
            (email, pass) in
            return LoginCredentials(email: email, password: pass)
        }
    }
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        logInDidTapSubject
            .withLatestFrom(credentialsObs)
            .map({ (credentials) in
                self.verifyCredentials(credentials: credentials)
            })
            .subscribe(onNext: { (error) in
                if let err = error {
                    self.errorResultSubject.onNext(err)
                } else {
                    self.errorResultSubject.onCompleted()
                    self.loginResultSubject.onCompleted()
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func verifyCredentials(credentials: LoginCredentials) -> String? {
        if credentials.email.isEmpty {
            return "Digite um e-mail"
        }
        let realm = try! Realm()
        let user = realm.object(ofType: User.self, forPrimaryKey: credentials.email)
        guard let us = user else {
            return "Usuário não existe"
        }
        if us.password == credentials.password {
            UserDefaults.standard.set(us.email, forKey: "user")
            return nil
        } else {
            return "Senha inválida"
        }
    }
    
}

struct LoginCredentials {
    var email: String
    var password: String
}
