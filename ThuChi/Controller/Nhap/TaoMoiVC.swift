//
//  TaoMoiVC.swift
//  ThuChi
//
//  Created by Nguyen Ty on 11/10/2021.
//

import UIKit
protocol AddIconDelegate {
    func addIcon(user: IconDS,checksegment:Bool)
}
class TaoMoiVC: CustomVC {
    var delegate:AddIconDelegate?
    var check = false
    @IBOutlet weak var btnluu: UIButton!
    @IBOutlet weak var collcolor: UICollectionView!
    @IBOutlet weak var collicon: UICollectionView!
    @IBOutlet weak var tfname: UITextField!
    var colortext = UIColor.gray
    var colorarr = [UIColor]()
    var iconarr = [UIImage]()
    var name = ""
    var icon1 = UIImage()
    var coloricon = UIColor()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle()
        setupcolor()
        setupicon()
        tfname.text  = "\(check)"
        // Do any additional setup after loading the view.
        btnluu.setTitleColor(.white, for: .normal)
        btnluu.setTitle("Lưu", for: .normal)
        btnluu.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        roundCorner(views: [btnluu], radius: 30, color: .orange)
        setupcollcolor()
        setupcollicon()
    }
    func setupcolor() {
        colorarr.append(UIColor.red)
        colorarr.append(UIColor.black)
        colorarr.append(UIColor.white)
        colorarr.append(UIColor.brown)
        colorarr.append(UIColor.yellow)
        colorarr.append(UIColor.orange)
        colorarr.append(UIColor.systemRed)
        colorarr.append(UIColor.systemBlue)
        colorarr.append(UIColor.systemPink)
        colorarr.append(UIColor.systemTeal)
        colorarr.append(UIColor.systemGreen)
        colorarr.append(UIColor.systemGray2)
        colorarr.append(UIColor.systemGray3)
        colorarr.append(UIColor.systemGray4)
        colorarr.append(UIColor.systemGray5)
        colorarr.append(UIColor.systemPurple)
        colorarr.append(UIColor.systemIndigo)
    }
    func setupicon() {
        
        iconarr.append(UIImage(systemName: "square.and.arrow.up")!)
        iconarr.append(UIImage(systemName: "square.and.arrow.down")!)
       
        iconarr.append(UIImage(systemName: "sun.max.fill")!)
        iconarr.append(UIImage(systemName: "network")!)
        iconarr.append(UIImage(systemName: "moon.fill")!)
        iconarr.append(UIImage(systemName: "smoke.fill")!)
        iconarr.append(UIImage(systemName: "mic.fill")!)
        iconarr.append(UIImage(systemName: "heart.fill")!)
        iconarr.append(UIImage(systemName: "message.fill")!)
        iconarr.append(UIImage(systemName: "phone.fill")!)
        iconarr.append(UIImage(systemName: "video.fill")!)
        iconarr.append(UIImage(systemName: "house.fill")!)
        iconarr.append(UIImage(systemName: "gamecontroller.fill")!)
        iconarr.append(UIImage(systemName: "airplane")!)
        iconarr.append(UIImage(systemName: "car.fill")!)
        iconarr.append(UIImage(systemName: "bus")!)

        iconarr.append(UIImage(systemName: "bicycle")!)
        
        iconarr.append(UIImage(systemName: "figure.walk")!)
        iconarr.append(UIImage(systemName: "person.fill")!)
        iconarr.append(UIImage(systemName: "network")!)
   
        iconarr.append(UIImage(systemName: "flame.fill")!)
        iconarr.append(UIImage(systemName: "drop.fill")!)
        iconarr.append(UIImage(systemName: "bag.fill")!)
        iconarr.append(UIImage(systemName: "cart.fill")!)
        iconarr.append(UIImage(systemName: "clock.fill")!)
        iconarr.append(UIImage(systemName: "heart.fill")!)
    }
    func navigationTitle() {
        self.navigationItem.title = "Tạo mới"
    }
    
    func setupcollicon() {
        collicon.delegate = self
        collicon.dataSource = self
        let vc = UINib(nibName: "CollIcon", bundle: nil)
        collicon.register(vc, forCellWithReuseIdentifier: "collicon")
    }
    func setupcollcolor() {
        collcolor.delegate = self
        collcolor.dataSource = self
        let vc = UINib(nibName: "CollColor", bundle: nil)
        collcolor.register(vc, forCellWithReuseIdentifier: "collcolor")
    }
    
    @IBAction func actionluu(_ sender: Any) {
        if tfname.text == "" {
            print("tf ronmg")
        }
        else {
            let dataicon = IconDS(image: icon1, name: tfname.text!, colors: coloricon)
            delegate?.addIcon(user: dataicon,checksegment: check)
            navigationController?.popViewController(animated: true)
            print("thanh cong")
        }
    }
}
extension TaoMoiVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collcolor {
            return colorarr.count
        }
        else {
            return iconarr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collcolor {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collcolor", for: indexPath) as! CollColor
            cell.viewcolor.backgroundColor = colorarr[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collicon", for: indexPath) as! CollIcon
            cell.imageicon.image = iconarr[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collcolor {
            let w = (view.frame.width - (20+10+10)) / 5
            return CGSize(width: w, height: w*2/3)
        }
        else {
            let w = (view.frame.width - (20+10+10)) / 4
            return CGSize(width: w, height: w*2/3)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collcolor {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollColor {
                cell.selectview()
                colortext = cell.viewcolor.backgroundColor ?? UIColor.gray
                coloricon = colortext
                print(cell.viewcolor.backgroundColor as Any)
            }
        }
        else {
            if let cell = collectionView.cellForItem(at: indexPath) as?  CollIcon {
                cell.selectview() 
                print(cell.imageicon.image as Any)
                cell.imageicon.tintColor = colortext
                icon1 = cell.imageicon.image!
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == collcolor {
            if let cell = collectionView.cellForItem(at: indexPath) as? CollColor {
                cell.deselectview()
            }
        }
        else {
            if let cell = collectionView.cellForItem(at: indexPath) as?  CollIcon {
                cell.deselectview()
                
            }
        }
    }
    
}
