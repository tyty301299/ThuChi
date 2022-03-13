//
//  Icon.swift
//  ThuChi
//
//  Created by Nguyen Ty on 08/10/2021.
//

import Foundation
import UIKit
class IconDS {
    var image:UIImage
    var name:String = ""
    var colors:UIColor
    init(image:UIImage,name:String,colors:UIColor) {
        self.image = image
        self.name = name
        self.colors = colors
    }
}
