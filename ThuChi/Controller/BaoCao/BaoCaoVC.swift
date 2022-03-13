//
//  BaoCaoVC.swift
//  ThuChi
//
//  Created by Nguyen Ty on 12/10/2021.
//

import UIKit
import Charts
class BaoCaoVC: CustomVC, UIGestureRecognizerDelegate {
    @IBOutlet weak var viewTC: UIView!
   
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var piechartData: PieChartView!
    @IBOutlet weak var lbnameCT: UILabel!
    @IBOutlet weak var lbnameTN: UILabel!
    @IBOutlet weak var lbnameTC: UILabel!
    
    @IBOutlet weak var btnprev: UIButton!
    @IBOutlet weak var btnnext: UIButton!
    
    
    @IBOutlet weak var lbdataTC: UILabel!
    @IBOutlet weak var lbdataTN: UILabel!
    @IBOutlet weak var lbdataCT: UILabel!
    
    @IBOutlet weak var viewchartCT: UIView!
    @IBOutlet weak var viewchartTN: UIView!
    
    @IBOutlet weak var lbchartCT: UILabel!
    @IBOutlet weak var lbchartTN: UILabel!
    var check = false
    var checkMY = false
    @IBOutlet weak var viewTCcon: UIView!
    @IBOutlet weak var viewT: UIView!
    @IBOutlet weak var viewC: UIView!
    var datafake = [DataIcon]()
    var datafakeyear = [DataIcon]()
    var datafakemoth = [DataIcon]()
    var datafakemothCT = [DataIcon]()
    var datafakemothTN = [DataIcon]()
    var datafakeyearCT = [DataIcon]()
    var datafakeyearTN = [DataIcon]()
    var numrow = [PieChartDataEntry]()
    var colorchart = [UIColor]()
    @IBOutlet weak var segmentMothYear: UISegmentedControl!
//    var segmentMothYear = UISegmentedControl()
    @IBOutlet weak var tftime: UITextField!
    var datemoth = Date()
    var dataCT:Double = 0
    var dataTN:Double = 0
    var dataTC:Double = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.titleView = segmentMothYear
//       self.navigationController?.navigationBar.tintColor = UIColor.orange
        tftime.delegate = self
        fakedata()
        setuplbdata()
        setupdatalb(date: datemoth)
        setupsegmentTN()
       
        setuptime()
        
       
        
        roundCornercon(views: [viewTCcon,viewT,viewC], radius: 10, color: .systemGray2)
        setchartview(viewchart: viewchartCT, lbname: lbchartCT, color: .orange)
        setchartview(viewchart: viewchartTN, lbname: lbchartTN, color: .systemGray4)

        setuptaponviewchartCT()
        setuptaponviewchartTN()
       
        setupdatachart(check: check)


       

        setuptableview()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("lich")
        self.viewDidAppear(true)
        setupload()
        viewDidLoad()


    }
    func setupload() {
        fakedata()
        setupdatalb(date: datemoth)
        setuptaponviewchartCT()
        setuptaponviewchartTN()
        setupdatachart(check: check)
      
        tableview.reloadData()
        
    }
    @IBAction func actionnext(_ sender: Any) {
        if checkMY {
           datemoth = datemoth.addingTimeInterval(86400*365)
            tftime.text = formatDateYear(date: datemoth)
        }
        else {
            datemoth = datemoth.addingTimeInterval(86400*30)
            tftime.text = formatDateMoth(date: datemoth)
        }
        print("next")
        print(datemoth)
        setupdatalb(date: datemoth)
        setuptaponviewchartCT()
        setuptaponviewchartTN()
        tableview.reloadData()
        setupdatachart(check: check)
        
    }
    
    @IBAction func actionprev(_ sender: Any) {
        if checkMY {
            datemoth = datemoth.addingTimeInterval(-86400*365)
            tftime.text = formatDateYear(date: datemoth)
            
          
        }
        else {
            datemoth = datemoth.addingTimeInterval(-86400*30)
            tftime.text = formatDateMoth(date: datemoth)
           
        }
        print("prev")
        print(datemoth)
        setupdatalb(date: datemoth)
        setuptaponviewchartCT()
        setuptaponviewchartTN()
        tableview.reloadData()
        setupdatachart(check: check)
       
    }
    func setupsegmentTN() {
//        segmentMothYear.removeAllSegments()
//        segmentMothYear.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
//        segmentMothYear.insertSegment(withTitle: "Tháng", at: 0, animated: true)
//        segmentMothYear.insertSegment(withTitle: "Năm", at: 1, animated: false)
        segmentMothYear.selectedSegmentTintColor = .orange
        segmentMothYear.selectedSegmentIndex = 0
        segmentMothYear.tintColor = .white
        segmentMothYear.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], for: .normal)
        let titletext = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titletext1 = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        segmentMothYear.setTitleTextAttributes(titletext, for: .selected)
        segmentMothYear.setTitleTextAttributes(titletext1, for: .normal)
        segmentMothYear.addTarget(self, action: #selector(actionsegment), for: .valueChanged)
        
    }
    @objc func actionsegment() {
        setuptime()
        if segmentMothYear.selectedSegmentIndex == 0 {
            checkMY = false
            print(checkMY)
//            setupdatalb(date: datemoth)
            setupdatalb(date: datemoth)
            setuptaponviewchartCT()
            setuptaponviewchartTN()
            setupdatachart(check: check)
            tableview.reloadData()
          
            
        }
        else {
            checkMY = true
            print(checkMY)
//            setupdatalb(date: datemoth)
            setupdatalb(date: datemoth)
            setuptaponviewchartCT()
            setuptaponviewchartTN()
            setupdatachart(check: check)
            tableview.reloadData()
        }
    }
    
    
    
    
    func setupdatalb(date:Date) {
        datafakemoth.removeAll()
        datafakeyear.removeAll()
        datafakemothTN.removeAll()
        datafakemothCT.removeAll()
        datafakeyearTN.removeAll()
        datafakeyearCT.removeAll()
        if checkMY == false {
            var lb1:Double = 0
            var lb2:Double = 0
            for test in datafake{
                if formatDateMoth(date: test.date) == formatDateMoth(date: date) {
                    print(formatDate(date: test.date))
                    if test.checkTC {
                        lb2 += test.money
                        datafakemothTN.append(test)
                    }
                    else {
                        lb1 += test.money
                        datafakemothCT.append(test)
                    }
                    datafakemoth.append(test)
                }
            }
            dataCT = lb1
            dataTN = lb2
            dataTC = lb2 - lb1
            lbdataTN.text = (String)(lb2) + "đ"
            lbdataCT.text = (String)(lb1) + "đ"
            lbdataTC.text = (String)(lb2 - lb1) + "đ"
            print("data moth CT " + " \(datafakemothCT.count)")
            print("data moth TN " + " \(datafakemothTN.count)")
//            for test in datafakemothCT {
//                print(test.icon.name)
//            }
        }
        else {
            var lb1:Double = 0
            var lb2:Double = 0
            for test in datafake{
                if formatDateYear(date: test.date) == formatDateYear(date: date) {
                    if test.checkTC {
                        lb2 += test.money
                        datafakeyearTN.append(test)
                    }
                    else {
                        
                        datafakeyearCT.append(test)
                        lb1 += test.money
                    }
                    datafakeyear.append(test)
                }
            }
            dataCT = lb1
            dataTN = lb2
            dataTC = lb2 - lb1
            lbdataTN.text = (String)(lb2) + "đ"
            lbdataCT.text = (String)(lb1) + "đ"
            lbdataTC.text = (String)(lb2 - lb1) + "đ"
            print("data year CT " + " \(datafakeyearCT.count)")
            print("data year TN " + " \(datafakeyearTN.count)")
        }
    }
    
    func setuptaponviewchartCT() {
//        print("tap 1")
        let tap = UITapGestureRecognizer(target: self, action: #selector(taponviewchartCT1))
        viewchartCT.isUserInteractionEnabled = true
        viewchartCT.addGestureRecognizer(tap)
    }
        @objc func taponviewchartCT1() {

            check = false
            print(check)
                
//            piechartData.clear()
//            piechartData.data?.setDrawValues(true)
            setupdatachart(check: check)
            tableview.reloadData()
            
            setchartview(viewchart: viewchartCT, lbname: lbchartCT, color: .orange)
            setchartview(viewchart: viewchartTN, lbname: lbchartTN, color: .systemGray4)
        }
    func setuptaponviewchartTN() {
//        print("tap 2")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(taponviewchartCT2))
        viewchartTN.isUserInteractionEnabled = true
   
        viewchartTN.addGestureRecognizer(tap)
    }
    @objc func taponviewchartCT2() {

        check = true
        print(check)
//          piechartData.data?.setDrawValues(true)
//        print(datafakeyearTN.count)
//        print(datafakeyearCT.count)
          setupdatachart(check: check)
          tableview.reloadData()
        
        setchartview(viewchart: viewchartCT, lbname: lbchartCT, color: .systemGray4)
        setchartview(viewchart: viewchartTN, lbname: lbchartTN, color: .orange)
        
    }
    func setuptableview() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        let nib = UINib(nibName: "TableCellBC", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "tablecellBC")
    }
    func setupdatachart(check:Bool) {
        numrow.removeAll()
        colorchart.removeAll()
        if checkMY == false {
            if check == false {
              
                    for test in datafakemothCT {
                        let datachart = PieChartDataEntry(value: 0)
                             datachart.value = test.money
                             datachart.label = test.icon.name
                             numrow.append(datachart)
                             colorchart.append(test.icon.colors)
                         }
                
               
                     let chartDataset = PieChartDataSet(entries: numrow, label: nil)
                     let chartdata = PieChartData(dataSet: chartDataset)
                     chartDataset.colors = colorchart
                    piechartData.legend.enabled = false
                     piechartData.data = chartdata
            }
            else {
                for test in datafakemothTN {
                    let datachart = PieChartDataEntry(value: 0)
                         datachart.value = test.money
                         datachart.label = test.icon.name
                         numrow.append(datachart)
                         colorchart.append(test.icon.colors)
                     }
                     let chartDataset = PieChartDataSet(entries: numrow, label: nil)
                     let chartdata = PieChartData(dataSet: chartDataset)
                     chartDataset.colors = colorchart
                     piechartData.legend.enabled = false
                     piechartData.data = chartdata

            }
        }
        else {
            if check == false {
                for test in datafakeyearCT {
                    let datachart = PieChartDataEntry(value: 0)
                               datachart.value = test.money
                               datachart.label = test.icon.name
                               numrow.append(datachart)
                               colorchart.append(test.icon.colors)
                           }
                           let chartDataset = PieChartDataSet(entries: numrow, label: nil)
                           let chartdata = PieChartData(dataSet: chartDataset)
                           chartDataset.colors = colorchart
                           piechartData.legend.enabled = false
                           piechartData.data = chartdata
            }
            else {
                for test in datafakeyearTN {
                    let datachart = PieChartDataEntry(value: 0)
                               datachart.value = test.money
                               datachart.label = test.icon.name
                               numrow.append(datachart)
                               colorchart.append(test.icon.colors)
                           }
                           let chartDataset = PieChartDataSet(entries: numrow, label: nil)
                           let chartdata = PieChartData(dataSet: chartDataset)
                           chartDataset.colors = colorchart
                           piechartData.legend.enabled = false
                           piechartData.data = chartdata
            }
        }
    }
    func fakedata() {
        
//        let p1 = DataIcon(checkTC: false, date: Date(), ghichu: "test", money: 2, icon: IconDS(image: UIImage(systemName: "house.fill")! , name: "Nha", colors: .systemPink))
//        let p2 = DataIcon(checkTC: true, date: setupdate(day: 13, moth: 10, year: 2021) , ghichu: "test", money: 2, icon: IconDS(image: UIImage(systemName: "sun.max.fill")! , name: "Nha", colors: .systemBlue))
//        let p3 = DataIcon(checkTC: false, date: setupdate(day: 12, moth: 11, year: 2021), ghichu: "test", money: 2, icon: IconDS(image: UIImage(systemName: "house.fill")! , name: "Nha", colors: .systemPink))
//        datafake.append(p1)
//        datafake.append(p2)
//        datafake.append(p1)
//        datafake.append(p2)
//        datafake.append(p3)
        datafake = SessionDataTC.share.DataTC
        
    }

    func setchartview(viewchart:UIView,lbname:UILabel,color: UIColor) {
        lbname.textColor = color
        setupviewboder(name: viewchart, color: color)
       
    }
    func setuplbdata() {
        setuplb(lb: [lbdataCT], size: 25, color: .systemRed)
        setuplb(lb: [lbdataTN], size: 25, color: .systemBlue)
        setuplb(lb: [lbdataTC], size: 30, color: .black)
    }
    func setupviewboder(name : UIView,color:UIColor){
        let boder = CALayer()
        boder.backgroundColor = color.cgColor
       
        boder.frame = CGRect(x: 0, y: name.frame.height, width: name.frame.width, height: 2)
        name.layer.addSublayer(boder)
      
    }
    func roundCornercon(views: [UIView], radius: CGFloat, color: UIColor){
        views.forEach { v in
            v.layer.cornerRadius = radius
          
            v.layer.borderWidth = 1
            v.layer.borderColor = color.cgColor
            v.layer.masksToBounds = true
            
        }
    }
    func setuptime() {
        if segmentMothYear.selectedSegmentIndex == 0 {
            tftime.text = formatDateMoth(date: datemoth)
        }
        else {
            tftime.text = formatDateYear(date: datemoth)
        }
    }
   
   
   


}
extension BaoCaoVC:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
extension BaoCaoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkMY == false {
            if check == false {
                return datafakemothCT.count
            }
            else {
                return datafakemothTN.count
            }
        }
        else {
            if check == false {
                return datafakeyearCT.count
            }
            else {
                return datafakeyearTN.count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "tablecellBC") as! TableCellBC
        if checkMY == false {
            if check == false {
                let data = datafakemothCT[indexPath.row]
                cell.imageicon.image = data.icon.image
                cell.imageicon.tintColor = data.icon.colors
                cell.lbname.text = data.icon.name
                cell.lbmoney.text = (String)(data.money) + " đ"
                cell.lbtram.text = (String)(data.money/dataCT * 100) + " %"
            }
            else {
                let data =  datafakemothTN[indexPath.row]
                cell.imageicon.image = data.icon.image
                cell.imageicon.tintColor = data.icon.colors
                cell.lbname.text = data.icon.name
                cell.lbmoney.text = (String)(data.money) + " đ"
                cell.lbtram.text = (String)(data.money/dataTN * 100) + " %"
            }
        }
        else {
       
                if check == false {
                    let data = datafakeyearCT[indexPath.row]
                    cell.imageicon.image = data.icon.image
                    cell.imageicon.tintColor = data.icon.colors
                    cell.lbname.text = data.icon.name
                    cell.lbmoney.text = (String)(data.money) + " đ"
                    cell.lbtram.text = (String)(data.money/dataCT * 100) + " %"
                }
                else {
                    let data =  datafakeyearTN[indexPath.row]
                    cell.imageicon.image = data.icon.image
                    cell.imageicon.tintColor = data.icon.colors
                    cell.lbname.text = data.icon.name
                    cell.lbmoney.text = (String)(data.money) + " đ"
                    cell.lbtram.text = (String)(data.money/dataTN * 100) + " %"
                }
        }
        
        
    
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
