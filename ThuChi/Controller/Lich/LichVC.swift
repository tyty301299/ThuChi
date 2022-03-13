//
//  LichVC.swift
//  ThuChi
//
//  Created by Nguyen Ty on 12/10/2021.
//

import UIKit
import FSCalendar
class LichVC: CustomVC {
    var datafake = [DataIcon]()
    var datatest = [DataIcon]()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lbSum: UILabel!
    @IBOutlet weak var lbCT: UILabel!
    @IBOutlet weak var lbTN: UILabel!
    @IBOutlet weak var tfday: UITextField!
    @IBOutlet weak var viewCalendar: UIView!
//    var calendar:FSCalendar!
    @IBOutlet weak var calendar: FSCalendar!
    var formatter = DateFormatter()
    var date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.title = "Lịch"
        tfday.delegate = self
        sumlb()
        setupCalendar()
        fakedata()
        checkvaluecalendar(date: date)
        setupdatatest(datetz: tfday.text!)
        setuptableview()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        print("lich")
        setupload()
        viewDidLoad()


    }
    func setupload() {
        fakedata()
        checkvaluecalendar(date: date)
        setupdatatest(datetz: tfday.text!)
        tableview.reloadData()
    }
    @IBAction func actionprev(_ sender: Any) {
        date = date.addingTimeInterval(-86400)
        tfday.text = formatDate(date: date)
    }
    @IBAction func actionnext(_ sender: Any) {
        date = date.addingTimeInterval(86400)
        tfday.text = formatDate(date: date)
    }
    func fakedata() {
//        let p1 = DataIcon(checkTC: false, date: Date(), ghichu: "test", money: 12232, icon: IconDS(image: UIImage(systemName: "house.fill")! , name: "Nha", colors: .systemPink))
//        let p2 = DataIcon(checkTC: true, date: setupdate(day: 13, moth: 10, year: 2021) , ghichu: "test", money: 12232, icon: IconDS(image: UIImage(systemName: "sun.max.fill")! , name: "Nha", colors: .systemPink))
//        datafake.append(p1)
//        datafake.append(p2)
//        datafake.append(SessionDataTC.share.DataTC)
        datafake = SessionDataTC.share.DataTC
        
    }
    func setupdatatest(datetz:String) {
        datatest.removeAll()
        print(datafake.count)
        for test in datafake {
            if datetz == formatDate(date: test.date) {
                datatest.append(test)
            }
        }
    }
    func setuptableview() {
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "TableCellData", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "tablecelldata")
        tableview.tableFooterView = UIView()
    }
    func sumlb() {
        setuplb(lb: [lbTN,lbSum], size: 20, color: .systemBlue)
        setuplb(lb: [lbCT], size: 20, color: .systemRed)
    }
    func checkvaluecalendar(date: Date) {
        var TN:Double = 0
        var TC:Double = 0
        var Sum:Double = 0
        for text in datafake {
            if formatDate(date: text.date) == formatDate(date: date) {
                if(text.checkTC) {
                    TN += text.money
                }
                else {
                    TC += text.money
                }
            }
        }
        Sum = TN - TC
        lbTN.text = (String)(TN) + "đ"
        lbCT.text = (String)(TC) + "đ"
        if Sum < 0 {
            lbSum.textColor = .systemRed
        }
        else {
            lbSum.textColor = .systemBlue
        }
        lbSum.text = (String)(Sum) + "đ"
    }
    func setupCalendar() {
        let now = Date()
        formatter.dateFormat = "dd/MM/yyyy"
       
        tfday.text = formatter.string(from: now)
//        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: self.viewCalendar.frame.width, height: self.viewCalendar.frame.height))
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.todayColor = .systemPink
        calendar.appearance.selectionColor = .orange
        calendar.appearance.headerTitleColor = .systemBlue
        calendar.layer.borderWidth = 1
        calendar.layer.masksToBounds = true
        calendar.layer.borderColor = UIColor.gray.cgColor
        calendar.scope = .month
        
        calendar.locale = Locale(identifier: "vi")
//        viewCalendar.addSubview(calendar)
//        self.calendar = calendar
    }
    

   

}
extension LichVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datatest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "tablecelldata") as! TableCellData
        let data = datatest[indexPath.row]
       
        let test = formatDate(date: data.date)
        print("check")
        if test == tfday.text {
            print(tfday.text)
            cell.imageicon.image = data.icon.image
            cell.imageicon.tintColor = data.icon.colors
            cell.lbname.text = data.icon.name
            cell.lbghichu.text = "(" + data.ghichu + ")"
            cell.lbtien.text = (String)(data.money) + "đ"
            if data.checkTC {
                cell.lbtien.textColor = .systemBlue
            }
            else {
                cell.lbtien.textColor = .systemRed
            }
           return cell
        }
        else {
            return cell
        }
    
       
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let head = UIView()
        head.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 25)
        head.backgroundColor = .systemGray5
        let lbheader = UILabel()
        let lbmoney = UILabel()
        head.addSubview(lbheader)
        lbheader.translatesAutoresizingMaskIntoConstraints = false
        lbheader.leadingAnchor.constraint(equalTo: head.leadingAnchor, constant: 10).isActive = true
        lbheader.trailingAnchor.constraint(equalTo: head.trailingAnchor, constant: -100).isActive = true
        lbheader.centerYAnchor.constraint(equalTo: head.centerYAnchor).isActive = true
        lbheader.text = tfday.text

        lbheader.addSubview(lbmoney)
        lbmoney.translatesAutoresizingMaskIntoConstraints = false

        lbmoney.trailingAnchor.constraint(equalTo: head.trailingAnchor, constant: -10).isActive = true
        lbmoney.centerYAnchor.constraint(equalTo: head.centerYAnchor).isActive = true

        
       return head
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
extension LichVC: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd/MM/yyyy"
//        print(date)
//        print("\(formatter.string(from: date))")
        tfday.text = formatter.string(from: date)
        setupdatatest(datetz: tfday.text!)
        tableview.reloadData()
        checkvaluecalendar(date: date)
       
    }
}
extension LichVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfday {
            return false
            
        }
        return true
      
    }
}
