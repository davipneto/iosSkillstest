//
//  AlbumsViewController.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumsViewController: UIViewController {
    
    let vm = AlbumsViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: AlbumTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        tableView.rowHeight = 150
        tableView.allowsSelection = false
    }
    
    private func bind() {
        vm.albumsObs
            .bind(to: tableView.rx.items(cellIdentifier: AlbumTableViewCell.identifier, cellType: AlbumTableViewCell.self)) {
                row, album, cell in
                cell.album = album
            }
            .disposed(by: disposeBag)
    }

}
