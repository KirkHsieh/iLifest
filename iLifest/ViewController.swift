//
//  ViewController.swift
//  iLifest
//
//  Created by Kirk Hsieh on 2018/11/8.
//  Copyright © 2018 KirkHsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let imageList: [UIImage] = [#imageLiteral(resourceName: "客廳"), #imageLiteral(resourceName: "飯廳"), #imageLiteral(resourceName: "廚房"), #imageLiteral(resourceName: "臥室"), #imageLiteral(resourceName: "廁所")]
    let labelList: [String] = ["  客廳    Livingroom", "  飯廳    Dinningroom", "  廚房   Kitchen", "  臥室   Bedroom", "  廁所   Bathroom"]
    let labelBackgroundColor: [CGColor] = [#colorLiteral(red: 1, green: 0.9206290841, blue: 0.5360296369, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "allRegionCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AllRegionCollectionViewCell
        cell.allRegionImage?.image = imageList[indexPath.row]
        cell.allRegionLabel?.text = labelList[indexPath.row]
        cell.allRegionLabel?.layer.backgroundColor = labelBackgroundColor[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
             self.performSegue(withIdentifier: "menu2livingroom", sender: self)
        }
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "menu2dinningroom", sender: self)
        }
        if indexPath.row == 2 {
            self.performSegue(withIdentifier: "menu2kitchen", sender: self)
        }
        if indexPath.row == 3 {
            self.performSegue(withIdentifier: "menu2bedroom", sender: self)
        }
        if indexPath.row == 4 {
            self.performSegue(withIdentifier: "menu2toilet", sender: self)
        }
    }

    @IBOutlet weak var allRegionCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let connectAdafruit = ConnectAdafruit()
        connectAdafruit.getFeedsData(location: "livingroom_light", feeds_key: "livingroomonoff")
        connectAdafruit.getFeedsData(location: "livingroom_television", feeds_key: "tvonoff")
        connectAdafruit.getFeedsData(location: "dinningroom_light", feeds_key: "dinningroomonoff")
        connectAdafruit.getFeedsData(location: "dinningroom_airconditioner", feeds_key: "airconditioneronoff")
       
        connectAdafruit.getFeedsData(location: "kitchen_light", feeds_key: "kitchenonoff")
        connectAdafruit.getFeedsData(location: "kitchen_refrigerator", feeds_key: "socketonoff")
        connectAdafruit.getFeedsData(location: "bedroom_light", feeds_key: "bedroomonoff")
        connectAdafruit.getFeedsData(location: "bedroom_fan", feeds_key: "fanonoff")
        connectAdafruit.getFeedsData(location: "bathroom_light", feeds_key: "tolietonoff")
        connectAdafruit.getFeedsData(location: "bathroom_fan", feeds_key: "fanonoff")
    }
}

