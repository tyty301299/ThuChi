//
//  DataIcon.swift
//  ThuChi
//
//  Created by Nguyen Ty on 12/10/2021.
//

import Foundation
import UIKit
class DataIcon {
    var checkTC:Bool
    var date:Date
    var ghichu = ""
    var money:Double = 0
    var icon: IconDS
    init(checkTC:Bool,date:Date,ghichu:String,money:Double,icon:IconDS) {
        self.checkTC = checkTC
        self.date = date
        self.ghichu = ghichu
        self.money = money
        self.icon = icon
    }
}
