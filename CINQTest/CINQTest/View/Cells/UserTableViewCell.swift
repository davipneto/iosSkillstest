//
//  UserTableViewCell.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    static var identifier = "UserCell"
    let editUserSubject = PublishSubject<User>()
    let canNotDeleteAlertSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            emailLabel.text = user?.email
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        bind()
    }
    
    private func bind() {
        editButton.rx.tap
            .bind {
                guard let user = self.user else {return}
                self.editUserSubject.onNext(user)
            }
            .disposed(by: disposeBag)
        
        deleteButton.rx.tap
            .bind {
                self.deleteUser()
            }
            .disposed(by: disposeBag)
    }
    
    private func deleteUser() {
        guard let user = user else {return}
        if user.email == UserDefaults.standard.string(forKey: "user") {
            self.canNotDeleteAlertSubject.onNext("Você não pode deletar seu próprio registro")
            return
        }
        Observable.just(user).asObservable()
            .subscribe(Realm.rx.delete())
            .disposed(by: disposeBag)
    }

}
