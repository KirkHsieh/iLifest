//
//  DiningRoomViewController.swift
//  iLifest
//
//  Created by Kirk Hsieh on 2018/11/19.
//  Copyright © 2018 KirkHsieh. All rights reserved.
//

import UIKit
import Foundation

class DiningRoomViewController: UIViewController {
    
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
    @IBOutlet weak var airconditionerView: UIView!
    @IBOutlet weak var airconditionerImage: UIImageView!
    @IBOutlet weak var airconditionerLabel: UILabel!
    
    var status: String?
    let connectAdafruit = ConnectAdafruit()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionNameLabel?.text = "Dinningroom"
        regionLabel?.text = "客廳<--                       飯廳                       -->廚房"
        regionChangeView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        controlLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        controlLabel.layer.borderWidth = 3
        controlOnOffLabel?.text = "開關"
        controlNotificationLabel?.text = "通知"
        lightLabel?.text = "電燈"
        airconditionerLabel?.text = "冷氣"
        lightView.backgroundColor = #colorLiteral(red: 0.6375312209, green: 0.9960485101, blue: 0.8683366179, alpha: 1)
        airconditionerView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        // Do any additional setup after loading the view.
        status = "light"
        let setChangeToLight = UITapGestureRecognizer(target: self, action: #selector(changeToLight));
        let setChangeToAirConditioner = UITapGestureRecognizer(target: self, action: #selector(changeToAirConditioner));
        self.lightView.addGestureRecognizer(setChangeToLight)
        self.airconditionerView.addGestureRecognizer(setChangeToAirConditioner)
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
        connectAdafruit.getFeedsData(location: "dinningroom_light", feeds_key: "dinningroomonoff")
        if dinningroomFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
            lightImage?.image = UIImage(named: "電燈")
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
            lightImage?.image = UIImage(named: "電燈關")
        }
        connectAdafruit.getFeedsData(location: "dinningroom_airconditioner", feeds_key: "airconditioneronoff")
    }
    
    @IBAction func controlOnOff(_ sender: UISwitch) {
        switch status{
            case "light":
                if sender.isOn == true {    // 判斷使用者選擇是開還是關
                    connectAdafruit.updatedFeedsData(location: "dinningroom_light", feeds_key: "dinningroomonoff", value: "ON")
                    lightImage?.image = UIImage(named: "電燈")
                }else {
                    connectAdafruit.updatedFeedsData(location: "dinningroom_light", feeds_key: "dinningroomonoff", value: "OFF")
                    lightImage?.image = UIImage(named: "電燈關")
                }
                break
            case "airconditioner":
                if sender.isOn == true {    // 判斷使用者選擇是開還是關
                    connectAdafruit.updatedFeedsData(location: "dinningroom_airconditioner", feeds_key: "airconditioneronoff", value: "ON")
                }
                else {
                    connectAdafruit.updatedFeedsData(location: "dinningroom_airconditioner", feeds_key: "airconditioneronoff", value: "OFF")
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
        connectAdafruit.getFeedsData(location: "dinningroom_light", feeds_key: "dinningroomonoff")
        if dinningroomFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
        }
        connectAdafruit.getFeedsData(location: "dinningroom_light", feeds_key: "dinningroomonoff")//更改後要把目前adafruit的狀態顯示在Switch上
    }
    @objc func changeToAirConditioner(sender:UITapGestureRecognizer) {
        status = "airconditioner"
        controlLabel?.text = "冷氣狀態"
        connectAdafruit.getFeedsData(location: "dinningroom_airconditioner", feeds_key: "airconditioneronoff")
        if airconditionerFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
        }
        connectAdafruit.getFeedsData(location: "dinningroom_airconditioner", feeds_key: "airconditioneronoff")//更改後要把目前adafruit的狀態顯示在Switch上
    }
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        if swipe.direction ==  UISwipeGestureRecognizer.Direction.left {
            performSegue(withIdentifier: "dinningroom2kitchen", sender: self)
        }
        else {
            performSegue(withIdentifier: "dinningroom2livingroom", sender: self)
        }
    }
}
