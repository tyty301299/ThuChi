//
//  TableCellData.swift
//  ThuChi
//
//  Created by Nguyen Ty on 12/10/2021.
//

import UIKit

class TableCellData: UITableViewCell {

    @IBOutlet weak var lbtien: UILabel!
    @IBOutlet weak var lbghichu: UILabel!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var imageicon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       setuplb(lbname: lbtien , size: 20)
       setuplb(lbname: lbname, size: 20)
    }
    func setuplb(lbname:UILabel,size:CGFloat) {
        lbname.font = .boldSystemFont(ofSize: size)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
