//
//  CollColor.swift
//  ThuChi
//
//  Created by Nguyen Ty on 11/10/2021.
//

import UIKit

class CollColor: UICollectionViewCell {

    @IBOutlet weak var viewcolor: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewcolor.layer.masksToBounds = true
        viewcolor.layer.cornerRadius = 10
        viewcolor.layer.borderWidth = 1
        viewcolor.layer.borderColor = UIColor.gray.cgColor
    }
    func selectview() {
        viewcolor.layer.masksToBounds = true
        viewcolor.layer.cornerRadius = 10
        viewcolor.layer.borderWidth = 3
        viewcolor.layer.borderColor = UIColor.gray.cgColor
    }
    func deselectview() {
        viewcolor.layer.masksToBounds = true
        viewcolor.layer.cornerRadius = 10
        viewcolor.layer.borderWidth = 1
        viewcolor.layer.borderColor = UIColor.gray.cgColor
    }

}
