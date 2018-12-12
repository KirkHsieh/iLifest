//
//  LivingRoomViewController.swift
//  iLifest
//
//  Created by Kirk Hsieh on 2018/11/19.
//  Copyright © 2018 KirkHsieh. All rights reserved.
//

import UIKit
import Foundation

class LivingRoomViewController: UIViewController {
    
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
    @IBOutlet weak var televisionView: UIView!
    @IBOutlet weak var televisionImage: UIImageView!
    @IBOutlet weak var televisionLabel: UILabel!
    
    var status: String?
    let connectAdafruit = ConnectAdafruit()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionNameLabel?.text = "客廳"
        regionLabel?.text = "Livingroom"
        regionChangeView.backgroundColor = #colorLiteral(red: 1, green: 0.9206290841, blue: 0.5360296369, alpha: 1)
        controlLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        controlLabel.layer.borderWidth = 3
        controlOnOffLabel?.text = "開關"
        controlNotificationLabel?.text = "通知"
        lightLabel?.text = "電燈"
        televisionLabel?.text = "電視"
        lightView.backgroundColor = #colorLiteral(red: 0.6375312209, green: 0.9960485101, blue: 0.8683366179, alpha: 1)
        televisionView.backgroundColor = #colorLiteral(red: 1, green: 0.9206290841, blue: 0.5360296369, alpha: 1)
        status = "light"
        let setChangeToLight = UITapGestureRecognizer(target: self, action: #selector(changeToLight));
        let setChangeToTv = UITapGestureRecognizer(target: self, action: #selector(changeToTv));
        self.lightView.addGestureRecognizer(setChangeToLight)
        self.televisionView.addGestureRecognizer(setChangeToTv)
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
        connectAdafruit.getFeedsData(location: "livingroom_light", feeds_key: "livingroomonoff")
        if livingroomFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
            lightImage?.image = UIImage(named: "電燈")
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
            lightImage?.image = UIImage(named: "電燈關")
        }
        connectAdafruit.getFeedsData(location: "livingroom_television", feeds_key: "tvonoff")
    }
    
    @IBAction func controlOnOff(_ sender: UISwitch) {
        switch status{
            case "light":
                if sender.isOn == true {    // 判斷使用者選擇是開還是關
                    connectAdafruit.updatedFeedsData(location: "livingroom_light", feeds_key: "livingroomonoff", value: "ON")
                    lightImage?.image = UIImage(named: "電燈")
                }else {
                    connectAdafruit.updatedFeedsData(location: "livingroom_light", feeds_key: "livingroomonoff", value: "OFF")
                    lightImage?.image = UIImage(named: "電燈關")
                }
                break
            case "television":
                if sender.isOn == true {    // 判斷使用者選擇是開還是關
                    connectAdafruit.updatedFeedsData(location: "livingroom_television", feeds_key: "tvonoff", value: "ON")
                }
                else {
                    connectAdafruit.updatedFeedsData(location: "livingroom_television", feeds_key: "tvonoff", value: "OFF")
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
    @objc func changeToLight(sender: UITapGestureRecognizer) {
        status = "light"
        controlLabel?.text = "電燈狀態"
        connectAdafruit.getFeedsData(location: "livingroom_light", feeds_key: "livingroomonoff")
        if livingroomFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
        }
        connectAdafruit.getFeedsData(location: "livingroom_light", feeds_key: "livingroomonoff")//更改後要把目前adafruit的狀態顯示在Switch上
    }
    @objc func changeToTv(sender: UITapGestureRecognizer) {
        status = "television"
        controlLabel?.text = "電視狀態"
        connectAdafruit.getFeedsData(location: "livingroom_television", feeds_key: "tvonoff")
        if tvFeedsData?.value == "ON" {
            controlOnOffSwitch.setOn(true, animated: true)
        }
        else {
            controlOnOffSwitch.setOn(false, animated: true)
        }
        connectAdafruit.getFeedsData(location: "livingroom_television", feeds_key: "tvonoff")//更改後要把目前adafruit的狀態顯示在Switch上
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        if swipe.direction ==  UISwipeGestureRecognizer.Direction.left {
            performSegue(withIdentifier: "livingroom2dinningroom", sender: self)
        }
        else {
            performSegue(withIdentifier: "livingroom2toilet", sender: self)
        }
    }
}
