//
//  Model.swift
//  iLifest
//
//  Created by Kirk Hsieh on 2018/12/5.
//  Copyright © 2018 KirkHsieh. All rights reserved.
//

struct FeedData: Codable {
    var id: String?
    var value: String?
    var feed_id: Int?
    var group_id: Int?
    var expiration: String?
    var lat: Int?
    var lon: Int?
    var ele: Int?
    var completed_at: String?
    var created_at: String?
    var updated_at: String?
    var created_epoch: Int?
}
var livingroomFeedsData: FeedData?
var tvFeedsData: FeedData?
var dinningroomFeedsData: FeedData?
var airconditionerFeedsData: FeedData?
var kitchenFeedsData: FeedData?
var refrigeratorFeedsData: FeedData?
var bedroomFeedsData: FeedData?
var fanFeedsData: FeedData?
var toiletFeedsData: FeedData?
var toiletfanFeedsData  : FeedData?

