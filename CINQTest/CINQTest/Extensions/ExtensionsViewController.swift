//
//  ExtensionsViewController.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 04/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, desc: String) {
        let alert = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
