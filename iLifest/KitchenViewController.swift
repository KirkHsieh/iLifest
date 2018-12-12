//
//  KitchenViewController.swift
//  iLifest
//
//  Created by Kirk Hsieh on 2018/11/29.
//  Copyright © 2018 KirkHsieh. All rights reserved.
//

import UIKit
import Foundation

class KitchenViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var regionPictureImageView: UIImageView!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionChangeView: UIView!
    @IBOutlet weak var controlChangeView: UIView!
    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var controlOnOffLabel: UILabel!
    @IBOutlet weak var controlNotificationLabel: UILabel!
    @IBOutlet weak var controlOnOffSwitch: UISwitch!
    @IBOutlet weak var controlNotificationSwitch: UISwitch!
    @IBOutlet weak var lightView: UIView!
    @IBOutlet weak var lightImage: UIImageView!
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var refrigeratorView: UIView!
    @IBOutlet weak var refrigeratorImage: UIImageView!
    @IBOutlet weak var refrigeratorLabel: UILabel!
    
    var status: String?
    let connectAdafruit = ConnectAdafruit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionNameLabel?.text = "Kitchen"
        regionLabel?.text = "飯廳<--                       廚房                       -->臥室"
        regionChangeView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        controlLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        controlLabel.layer.borderWidth = 3
        controlOnOffLabel?.text = "開關"
        controlNotificationLabel?.text = "通知"
        lightLabel?.text = "電燈"
        refrigeratorLabel?.text = "冰箱"
        lightView.backgroundColor = #colorLiteral(red: 0.6375312209, green: 0.9960485101, blue: 0.8683366179, alpha: 1)
        refrigeratorView.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        // Do any additional setup after loading the view.
        status = "light"
        let setChangeToLight = UITapGestureRecognizer(target: self, action: #selector(changeToLight));
        let setChangeToRefrigerator = UITapGestureRecognizer(target: self, action: #selector(changeToRefrigerator));
        self.lightView.addGestureRecognizer(setChangeToLight)
        self.refrigeratorView.addGestureRecognizer(setChangeToRefrigerator)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lightImage.contentMode = UIView.ContentMode.scaleAspectFit
        controlLabel?.text = "電燈狀態"
        connectAdafruit.getFeedsData(location: "kitchen_light", feeds_key: "kitchenonoff")
        if kitchenFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
            lightImage?.image = UIImage(named: "電燈")
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
            lightImage?.image = UIImage(named: "電燈關")
        }
        connectAdafruit.getFeedsData(location: "kitchen_refrigerator", feeds_key: "socketonoff")
    }
    
    @IBAction func controlOnOff(_ sender: UISwitch) {
        switch status {
            case "light":
                if sender.isOn == true {    // 判斷使用者選擇是開還是關
                    connectAdafruit.updatedFeedsData(location: "kitchen_light", feeds_key: "kitchenonoff", value: "ON")
                    lightImage?.image = UIImage(named: "電燈")
                }else {
                    connectAdafruit.updatedFeedsData(location: "kitchen_light", feeds_key: "kitchenonoff", value: "OFF")
                    lightImage?.image = UIImage(named: "電燈關")
                }
                break
            case "refrigerator":
                if sender.isOn == true {    // 判斷使用者選擇是開還是關
                    connectAdafruit.updatedFeedsData(location: "kitchen_refrigerator", feeds_key: "socketonoff", value: "ON")
                }
                else {
                    connectAdafruit.updatedFeedsData(location: "kitchen_refrigerator", feeds_key: "socketonoff", value: "OFF")
                }
                break
            default:
                print("switch_error")
                break
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func changeToLight(sender:UITapGestureRecognizer) {
        status = "light"
        controlLabel?.text = "電燈狀態"
        connectAdafruit.getFeedsData(location: "kitchen_light", feeds_key: "kitchenonoff")
        if kitchenFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
        }
        connectAdafruit.getFeedsData(location: "kitchen_light", feeds_key: "kitchenonoff")//更改後要把目前adafruit的狀態顯示在Switch上
    }
    @objc func changeToRefrigerator(sender:UITapGestureRecognizer) {
        status = "refrigerator"
        controlLabel?.text = "冰箱狀態"
        connectAdafruit.getFeedsData(location: "kitchen_refrigerator", feeds_key: "socketonoff")
        if refrigeratorFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
        }
        connectAdafruit.getFeedsData(location: "kitchen_refrigerator", feeds_key: "socketonoff")//更改後要把目前adafruit的狀態顯示在Switch上
    }
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        if swipe.direction ==  UISwipeGestureRecognizer.Direction.left {
            performSegue(withIdentifier: "kitchen2bedroom", sender: self)
        }
        else {
            performSegue(withIdentifier: "kitchen2dinningroom", sender: self)
        }
    }
}
