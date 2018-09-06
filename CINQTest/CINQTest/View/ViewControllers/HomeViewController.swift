//
//  HomeViewController.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import RxRealm
import RxRealmDataSources

class HomeViewController: UIViewController {
    
    ///VARIABLES
    let disposeBag = DisposeBag()
    let vm = HomeViewModel()
    let searchBar = UISearchBar()
    
    ///OUTLETS
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var addUserButton: UIBarButtonItem!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    ///SUPER METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///METHODS
    
    private func configureTableView() {
        let nib = UINib(nibName: UserTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: UserTableViewCell.identifier)
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        tableView.tableHeaderView = searchBar
        tableView.rowHeight = 100
        tableView.allowsSelection = false
    }
    
    private func bind() {
        bindTableView()
        bindClicks()
        bindUserLabel()
        bindSearchBar()
    }
    
    private func bindTableView() {
        vm.filteredUsers
            .bind(to: tableView.rx.items(cellIdentifier: UserTableViewCell.identifier, cellType: UserTableViewCell.self)) {
                row, user, cell in
                cell.user = user
                self.bindCellTaps(cell: cell)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindClicks() {
        addUserButton.rx.tap
            .bind {
                let sb = UIStoryboard(name: "Login", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "RegisterVC")
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        logOutButton.rx.tap
            .bind {
                UserDefaults.standard.setValue(nil, forKey: "user")
                let sb = UIStoryboard(name: "Login", bundle: nil)
                guard let vc = sb.instantiateInitialViewController() else {return}
                self.present(vc, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func bindUserLabel() {
        vm.loggedEmailObserver
            .bind(to: self.userLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindSearchBar() {
        searchBar.rx.text
            .orEmpty
            .bind(to: vm.searchText)
            .disposed(by: disposeBag)
    }
    
    private func bindCellTaps(cell: UserTableViewCell) {
        cell.canNotDeleteAlertSubject
            .subscribe(onNext: { (error) in
                self.showAlert(title: "Erro", desc: error)
            })
            .disposed(by: self.disposeBag)
        
        cell.editUserSubject
            .subscribe(onNext: { (user) in
                let sb = UIStoryboard(name: "Login", bundle: nil)
                guard let nvc = sb.instantiateViewController(withIdentifier: "RegisterVC") as? UINavigationController, let vc = nvc.viewControllers.first as? RegisterViewController else {return}
                vc.vm.user = user
                self.present(nvc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

}
