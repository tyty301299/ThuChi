//
//  AddCollVC.swift
//  ThuChi
//
//  Created by Nguyen Ty on 09/10/2021.
//

import UIKit
protocol GetDataDeletage {
    func GetDataICon(user: [IconDS],cheksegment:Bool)
    
    
}
class AddCollVC: CustomVC {
    var delegate:GetDataDeletage?
    @IBOutlet weak var tableview: UITableView!
    var segmentTC = UISegmentedControl()
    var arricon1 = SessionDataIconC.share.IconData
    var arricon = SessionDataIconT.share.IconData
    var check = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(taponadd))
       navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(taponback))
        setupsegment()
      setuptableview()
//        setupfakedataicon()
    }
    
    func setuptableview(){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        let nib = UINib(nibName: "TableCellIcon", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "tablecellicon")
    }
    func setupfakedataicon() {
        let imagetest = UIImage(systemName: "pencil")
        let icon2 = IconDS(image: imagetest!, name: "Chỉnh sửa", colors: UIColor.gray)
        let icon1 = IconDS(image:imagetest!, name: "My pham", colors: UIColor.red)
        
        arricon.append(icon1)
        arricon.append(icon1)
        arricon.append(icon1)
        arricon.append(icon1)
        arricon.append(icon1)
        arricon.append(icon2)
       
        arricon1.append(icon1)
        arricon1.append(icon2)
    }
    func setupsegment(){
        segmentTC.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        segmentTC.insertSegment(withTitle: "Thu Tien", at: 0, animated: true)
        segmentTC.insertSegment(withTitle: "Thu ", at: 1, animated: false)
        segmentTC.selectedSegmentTintColor = .orange
        if check {
            segmentTC.selectedSegmentIndex = 1
        }
        else {
            segmentTC.selectedSegmentIndex = 0
        }
        
        segmentTC.tintColor = .white
        segmentTC.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], for: .normal)
        let titletext = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titletext1 = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        segmentTC.setTitleTextAttributes(titletext, for: .selected)
        segmentTC.setTitleTextAttributes(titletext1, for: .normal)
        navigationItem.titleView = segmentTC
        segmentTC.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    @objc func segmentedControlValueChanged() {
        if segmentTC.selectedSegmentIndex == 0 {
           check = false
            tableview.reloadData()
        }
        else {
           check = true
            tableview.reloadData()
        }
    }
//    @objc func taponback() {
//        print("back")
//
//        self.navigationController?.popViewController(animated: true)
//    }
    @objc func taponadd() {
        print("tap on add")
        let vc = TaoMoiVC(nibName: "TaoMoiVC", bundle: nil)
        vc.delegate = self
        vc.check = check
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func taponback() {
        print("tap back")
        if check {
            delegate?.GetDataICon(user: arricon,cheksegment: check)
        }
        else {
            delegate?.GetDataICon(user: arricon1,cheksegment: check)
        }
       
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
 
}
extension AddCollVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentTC.selectedSegmentIndex == 0 {
            print("arricon")
            return arricon1.count
            
        }
        else {
            print("arricon1")
            return arricon.count
           
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecellicon")as! TableCellIcon
      
        if segmentTC.selectedSegmentIndex == 0 {
           
            let data = arricon1[indexPath.row]
            cell.imageicon.image = data.image
            cell.lbname.text = data.name
            
            cell.imageicon.tintColor = data.colors
        }
        else {
           
            let data = arricon[indexPath.row]
            cell.imageicon.image = data.image
            cell.lbname.text = data.name
            
            cell.imageicon.tintColor = data.colors
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
extension AddCollVC: AddIconDelegate {
    func addIcon(user: IconDS, checksegment: Bool) {
        if checksegment {
//            arricon.append(user)
//            arricon = SessionDataIconT.share.IconData
            SessionDataIconT.share.IconData.append(user)
            arricon = SessionDataIconT.share.IconData
            tableview.reloadData()
        }
        else {
//            arricon1.append(user)
//            arricon1 = SessionDataIconT.share.IconData
            SessionDataIconC.share.IconData.append(user)
            arricon1 = SessionDataIconC.share.IconData
            tableview.reloadData()
        }
    }
}
