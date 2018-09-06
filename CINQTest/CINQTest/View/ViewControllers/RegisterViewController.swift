//
//  RegisterViewController.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    ///VARIABLES
    let vm = RegisterViewModel()
    let disposeBag = DisposeBag()
    
    ///OUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    ///SUPER METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyIfIsEditing()
        bind()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///METHODS
    
    private func verifyIfIsEditing() {
        if let user = vm.user {
            self.navigationItem.title = "Editar Usuário"
            self.nameTextField.text = user.name
            self.emailTextField.text = user.email
            self.emailTextField.isEnabled = false
            self.emailTextField.alpha = 0.5
            self.passwordTextField.placeholder = "Nova Senha"
            self.registerButton.setTitle("Salvar", for: .normal)
        }
    }
    
    private func bind() {
        self.nameTextField.rx.text
            .orEmpty
            .bind(to: vm.name)
            .disposed(by: disposeBag)
        
        self.emailTextField.rx.text
            .orEmpty
            .bind(to: vm.email)
            .disposed(by: disposeBag)
        
        self.passwordTextField.rx.text
            .orEmpty
            .bind(to: vm.password)
            .disposed(by: disposeBag)
        
        self.registerButton.rx.tap
            .subscribe(vm.registerDidTapSubject)
            .disposed(by: disposeBag)
        
        self.cancelButton.rx.tap
            .bind {
                self.dismissAnimated()
            }
            .disposed(by: disposeBag)
        
        vm.registerResultSubject
            .asObservable()
            .subscribe(onNext: { (user) in
                if self.vm.getLoggedUser() != nil {
                    self.dismissAnimated()
                } else {
                    self.vm.setLoggedUser(user.email)
                    let sb = UIStoryboard(name: "Home", bundle: nil)
                    guard let vc = sb.instantiateInitialViewController() else {return}
                    self.present(vc, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        vm.errorResultSubject
            .asObservable()
            .subscribe(onNext: { (error) in
                self.showAlert(title: "Erro", desc: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func dismissAnimated() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
