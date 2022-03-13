//
//  ViewController.swift
//  ThuChi
//
//  Created by Nguyen Ty on 06/10/2021.
//

import UIKit

class ViewController: CustomVC {

    @IBOutlet weak var pickerdate: UIDatePicker!
    
    @IBOutlet weak var btnnhap: UIButton!
    @IBOutlet weak var collview: UICollectionView!
    @IBOutlet weak var lbdanhmuc: UILabel!
    @IBOutlet weak var tftien: UITextField!
    @IBOutlet weak var lbd: UILabel!
    @IBOutlet weak var lbtien: UILabel!
    @IBOutlet weak var tfghichu: UITextField!
    @IBOutlet weak var lbghichu: UILabel!
    @IBOutlet weak var tfday: UITextField!
    @IBOutlet weak var btnnext: UIButton!
    @IBOutlet weak var btnprve: UIButton!
    @IBOutlet weak var lbngay: UILabel!
    @IBOutlet weak var btnadd: UIBarButtonItem!
    var date = Date()
    var segmentThuChi = UISegmentedControl()
    var dataiconcoll = IconDS(image: UIImage(systemName: "minus")!, name: "Khong", colors: UIColor.systemGray2)
    var arricon1 = SessionDataIconC.share.IconData
    var arricon = SessionDataIconT.share.IconData
    var check = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentThuChi
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        setupsegmentThuChi()
        setuptextfiled()
        pickerdate.isHidden = true
        setuppickerview()
//       setupfakedataicon()
        setupcoll()
        btnnhap.setTitleColor(.white, for: .normal)
        btnnhap.setTitle("Nhập khoản chi", for: .normal)
        btnnhap.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        roundCorner(views: [btnnhap], radius: 30, color: UIColor.orange)
        setuplb(lb: [lbdanhmuc,lbtien,lbngay,lbghichu,lbd], size: 20, color: UIColor.gray)
        setuptf(tf: [tfday,tftien], size: 20, color: .gray)
        setuptf(tf: [tfghichu], size: 20, color: .gray)
       
            }
    
    @IBAction func actionprev(_ sender: Any) {
        date = date.addingTimeInterval(-86400)
        tfday.text = formatDate(date: date)
    }
    
    @IBAction func actionext(_ sender: Any) {
        date = date.addingTimeInterval(86400)
        tfday.text = formatDate(date: date)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        pickerdate.isHidden = true
        btnnhap.isHidden = false
    }
    func setupcoll() {
        collview.delegate = self
        collview.dataSource = self
        let vc = UINib(nibName: "IconColl", bundle: nil)
        collview.register(vc, forCellWithReuseIdentifier: "iconcoll")
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
    func setuppickerview() {
       
        pickerdate.datePickerMode = .date
       
        tfday.text = formatDate(date: date)
        pickerdate.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        tfday.inputView = pickerdate
    }
    @objc func dateChange(datePicker: UIDatePicker) {
        tfday.text = formatDate(date: datePicker.date)
        date = datePicker.date
    }
    func setuptextfiled() {
        tfday.delegate = self
        tftien.delegate = self
        tfghichu.delegate = self
    }
    @IBAction func actionsavedata(_ sender: Any) {
        if tftien.text == "" {
            print("tien")
        }
        else if tfghichu.text == "" {
          print("ghi chu")
        }
        else {
            var num:Double = (Double)(tftien.text ?? "0")!
            if segmentThuChi.selectedSegmentIndex == 0 {
                var data = DataIcon(checkTC: false, date: date, ghichu: tfghichu.text!, money: num, icon: dataiconcoll)
                print("segment == 0")
                SessionDataTC.share.DataTC.append(data)
                dataiconcoll = IconDS(image: UIImage(systemName: "minus")!, name: "Khong", colors: UIColor.systemGray2)
                print(SessionDataTC.share.DataTC.count)
                
            }
            else {
                var data = DataIcon(checkTC: true, date: date, ghichu: tfghichu.text!, money: num, icon: dataiconcoll)
                print("segment == 1")
                SessionDataTC.share.DataTC.append(data)
                dataiconcoll = IconDS(image: UIImage(systemName: "minus")!, name: "Khong", colors: UIColor.systemGray2)
                print(SessionDataTC.share.DataTC.count)
            }
        }
       
    }
    
    func setupsegmentThuChi() {
        segmentThuChi.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        segmentThuChi.insertSegment(withTitle: "Thu Tien", at: 0, animated: true)
        segmentThuChi.insertSegment(withTitle: "Thu ", at: 1, animated: false)
        segmentThuChi.selectedSegmentTintColor = .orange
        segmentThuChi.selectedSegmentIndex = 0
        segmentThuChi.tintColor = .white
        segmentThuChi.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], for: .normal)
        let titletext = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titletext1 = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        segmentThuChi.setTitleTextAttributes(titletext, for: .selected)
        segmentThuChi.setTitleTextAttributes(titletext1, for: .normal)
        segmentThuChi.addTarget(self, action: #selector(actionsegment), for: .valueChanged)
        
    }
    @IBAction func actionadd(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = vc.instantiateViewController(withIdentifier: "addcoll") as! AddCollVC
        vc1.check = check
        vc1.delegate = self
        navigationController?.pushViewController(vc1, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func actionsegment() {
        if segmentThuChi.selectedSegmentIndex == 0 {
            check = false
            collview.reloadData()
            btnnhap.setTitle("Nhập khoản chi", for: .normal)
            lbtien.text = "Tiền chi"
        }
        else {
            check = true
            collview.reloadData()
            btnnhap.setTitle("Nhập khoản thu", for: .normal)
            lbtien.text = "Tiền thu"
        }
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentThuChi.selectedSegmentIndex == 0 {
            print("arricon")
            return arricon1.count
            
        }
        else {
            print("arricon1")
            return arricon.count
           
        }
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconcoll", for: indexPath) as! IconColl
        if segmentThuChi.selectedSegmentIndex == 0 {
           
            let data = arricon1[indexPath.item]
            cell.imageicon.image = data.image
            cell.lbname.text = data.name
            
            cell.imageicon.tintColor = data.colors
        }
        else {
           
            let data = arricon[indexPath.item]
            cell.imageicon.image = data.image
            cell.lbname.text = data.name
            
            cell.imageicon.tintColor = data.colors
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (view.frame.width - (20+10+10)) / 3
        return CGSize(width: w, height: w*3/4)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? IconColl {
            dataiconcoll.image = cell.imageicon.image!
            dataiconcoll.colors = cell.imageicon.tintColor
            dataiconcoll.name = cell.lbname.text!
            
            print(dataiconcoll)
            cell.selectview()
           
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? IconColl {
            cell.deselectview()
        }
    }

}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfday {
           
            pickerdate.isHidden = false
            btnnhap.isHidden = true
            view.endEditing(true)
           
            return false
        }
        else if textField == tfghichu {
            pickerdate.isHidden = true
            btnnhap.isHidden = false
            return true
        }
        else if textField == tftien {
            pickerdate.isHidden = true
            btnnhap.isHidden = false
            return true
        }
        pickerdate.isHidden = true
        btnnhap.isHidden = false
            return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfday {
           print("text day")
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfday {
            print(tfday.text!)
        }
    }
   
}
extension ViewController: GetDataDeletage {
    func GetDataICon(user: [IconDS], cheksegment: Bool) {
   
            arricon = SessionDataIconT.share.IconData

            arricon1 = SessionDataIconC.share.IconData
            collview.reloadData()
        
    }
}
