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
    
    func verifyCredentials(credentials: RegisterCredentials) -> String? {
        if credentials.email.isEmpty || credentials.name.isEmpty || credentials.password.isEmpty {
            return "Todos os campos são obrigatórios!"
        }
        let realm = try! Realm()
        if let u = self.user {
            do {
                try realm.write {
                    u.name = credentials.name
                    u.password = credentials.password
                }
            } catch let error {
                return error.localizedDescription
            }
            return nil
        }
        if realm.object(ofType: User.self, forPrimaryKey: credentials.email) != nil {
            return "Esse e-mail já está cadastrado no sistema"
        }
        let user = User()
        user.name = credentials.name
        user.email = credentials.email
        user.password = credentials.password
        do {
            try realm.write {
                realm.add(user)
            }
            self.user = user
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
}

struct RegisterCredentials {
    var email: String
    var password: String
    var name: String
}
