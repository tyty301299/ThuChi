//
//  IconColl.swift
//  ThuChi
//
//  Created by Nguyen Ty on 08/10/2021.
//

import UIKit

class IconColl: UICollectionViewCell {

    @IBOutlet weak var viewcontainer: UIView!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var imageicon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewcontainer.layer.masksToBounds = true
        viewcontainer.layer.cornerRadius = 10
        viewcontainer.layer.borderWidth = 1
        viewcontainer.layer.borderColor = UIColor.gray.cgColor
    }
    func selectview() {
        viewcontainer.layer.masksToBounds = true
        viewcontainer.layer.cornerRadius = 10
        viewcontainer.layer.borderWidth = 3
        viewcontainer.layer.borderColor = UIColor.gray.cgColor
    }
    func deselectview() {
        viewcontainer.layer.masksToBounds = true
        viewcontainer.layer.cornerRadius = 10
        viewcontainer.layer.borderWidth = 1
        viewcontainer.layer.borderColor = UIColor.gray.cgColor
    }
}
