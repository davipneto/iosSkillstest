//
//  LoginViewController.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 05/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    ///VARIABLES
    let disposeBag = DisposeBag()
    let vm = LoginViewModel()

    ///OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    ///SUPER METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    ///METHODS
    
    private func bind() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: vm.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: vm.password)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe(vm.logInDidTapSubject)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap
            .bind {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") else {return}
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        vm.loginResultSubject
            .asObservable()
            .subscribe(onCompleted: {
                let sb = UIStoryboard(name: "Home", bundle: nil)
                guard let vc = sb.instantiateInitialViewController() else {return}
                self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        vm.errorResultSubject
            .asObservable()
            .subscribe(onNext: { (error) in
                self.showAlert(title: "Erro", desc: error)
            })
            .disposed(by: disposeBag)
    }

}
