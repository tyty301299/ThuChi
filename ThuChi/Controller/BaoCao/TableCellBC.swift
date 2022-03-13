//
//  TableCellBC.swift
//  ThuChi
//
//  Created by Nguyen Ty on 14/10/2021.
//

import UIKit

class TableCellBC: UITableViewCell {

    @IBOutlet weak var lbtram: UILabel!
    @IBOutlet weak var lbmoney: UILabel!
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
