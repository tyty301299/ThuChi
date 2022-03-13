//
//  CustomVC.swift
//  ThuChi
//
//  Created by Nguyen Ty on 06/10/2021.
//

import UIKit

class CustomVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    func roundCorner(views: [UIView], radius: CGFloat, color: UIColor){
        views.forEach { v in
            v.layer.cornerRadius = radius
            v.backgroundColor = color
            v.layer.masksToBounds = true
            
        }
    }
    func setuplb(lb :[UILabel], size:CGFloat, color: UIColor) {
        lb.forEach { lbl in
            lbl.font = UIFont.boldSystemFont(ofSize: size)
            lbl.textColor = color
            
        }
       
    }
    func setuptf(tf :[UITextField], size:CGFloat, color: UIColor) {
        tf.forEach { tf1 in
            tf1.font = UIFont.boldSystemFont(ofSize: size)
            tf1.textColor = color
            
        }
    }
    func formatDate(date: Date)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    func formatDateMoth(date: Date)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        return formatter.string(from: date)
    }
    func formatDateYear(date: Date)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
  
    func setupdate(day:Int,moth:Int,year:Int) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = day
        components.month = moth
        components.year = year
        let newDate = calendar.date(from: components)
       return newDate!
    }
}
