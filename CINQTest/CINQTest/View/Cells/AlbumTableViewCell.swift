//
//  AlbumTableViewCell.swift
//  CINQTest
//
//  Created by Davi Pereira Neto on 05/09/2018.
//  Copyright © 2018 Davi Pereira Neto. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "AlbumCell"
    var album: Album? {
        didSet {
            titleLabel.text = album!.title
            guard let url = URL(string: album!.picUrl!) else {return}
            picImageView.kf.setImage(with: url)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
