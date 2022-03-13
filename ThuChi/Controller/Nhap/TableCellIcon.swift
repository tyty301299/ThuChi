//
//  TableCellIcon.swift
//  ThuChi
//
//  Created by Nguyen Ty on 11/10/2021.
//

import UIKit

class TableCellIcon: UITableViewCell {

    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var imageicon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
