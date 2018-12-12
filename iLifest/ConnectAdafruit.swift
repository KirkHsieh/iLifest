//
//  ConnectAdafruit.swift
//  iLifest
//
//  Created by Kirk Hsieh on 2018/12/5.
//  Copyright © 2018 KirkHsieh. All rights reserved.
//

import UIKit
class ConnectAdafruit {
    func updatedFeedsData(location: String, feeds_key: String, value: String) {
        print("----updatedFeedsData----")
        //connect to api
        let serviceUrl = "https://io.adafruit.com/api/v2/pucsie2019/groups/default/feeds/\(feeds_key)/data?X-AIO-Key=448b9ff8e1a146429b36aa06a3b3303d"
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "POST"
        
        //add request
        let postParameters = "value=\(value)"
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //send request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print("error in getUserData : \(error)")
                return
            }
            //parse json data
            let decoder = JSONDecoder()
            guard let jsondata = data else{
                print("Error: did not receive data")
                return
            }
            do {
                let feedData = try decoder.decode(FeedData.self, from: jsondata)
                switch location {
                    case "livingroom_light":
                        livingroomFeedsData = feedData
                        break
                    case "livingroom_television":
                        tvFeedsData = feedData
                        break
                    case "dinningroom_light":
                        dinningroomFeedsData = feedData
                        break
                    case "dinningroom_airconditionor":
                        airconditionerFeedsData = feedData
                        break
                    case "kitchen_light":
                        kitchenFeedsData = feedData
                        break
                    case "kitchen_refrigerator":
                        refrigeratorFeedsData = feedData
                        break
                    case "bedroom_light":
                        bedroomFeedsData = feedData
                        break
                    case "bedroom_fan":
                        fanFeedsData = feedData
                        break
                    case "bathroom_light":
                        toiletFeedsData = feedData
                        break
                    case "bathroom_fan":
                        toiletfanFeedsData = feedData
                        break
                    default:
                        print(feedData)
                }
            } catch {
                print("Error:  \(error.localizedDescription)")
                //return
            }
        }.resume()
    }
    
    func getFeedsData(location: String, feeds_key: String) {
        print("----getFeedsData----")
        //connect to api
        let serviceUrl = "https://io.adafruit.com/api/v2/pucsie2019/feeds/\(feeds_key)/data/last?X-AIO-Key=448b9ff8e1a146429b36aa06a3b3303d"
        print(serviceUrl)
        let request = NSMutableURLRequest(url: NSURL(string : serviceUrl)! as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil{
                print("error in getUserData : \(error)")
                return
            }

            let decoder = JSONDecoder()
            guard let jsondata = data else{
                print("Error: did not receive data")
                return
            }
            do {
                let feedData = try decoder.decode(FeedData.self, from: jsondata)
                switch location {
                    case "livingroom_light":
                        livingroomFeedsData = feedData
                        break
                    case "livingroom_television":
                        tvFeedsData = feedData
                        break
                    case "dinningroom_light":
                        dinningroomFeedsData = feedData
                        break
                    case "dinningroom_airconditioner":
                        airconditionerFeedsData = feedData
                        break
                    case "kitchen_light":
                        kitchenFeedsData = feedData
                        break
                    case "kitchen_refrigerator":
                        refrigeratorFeedsData = feedData
                        break
                    case "bedroom_light":
                        bedroomFeedsData = feedData
                        break
                    case "bedroom_fan":
                        fanFeedsData = feedData
                        break
                    case "bathroom_light":
                        toiletFeedsData = feedData
                        break
                    case "bathroom_fan":
                        toiletfanFeedsData = feedData
                        break
                    default:
                        print(feedData)
                }
            } catch {
                print("Error:  \(error.localizedDescription)")
                //return
            }
        }.resume()
    }
}
