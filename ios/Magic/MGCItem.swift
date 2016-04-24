//
//  MGCItem.swift
//  Magic
//
//  Created by Jason Scharff on 4/23/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

import Foundation
import CoreLocation
import CoreGraphics
import SwiftyJSON

@objc class MGCItem: NSObject {
  
  var location : CLLocation
  var itemName : String
  var itemDescription : String
  var itemBuyURL : NSURL
  var itemBuyImageURL : NSURL
  var itemPrice : Float
  var locationName : String
  var coverImageURL : NSURL
  var addressString : String
  
  init?(json:JSON) {
    if(json == nil) {
      return nil
    }
    self.location = CLLocation(latitude: Double(json["_geoloc"]["lat"].floatValue), longitude: Double(json["_geoloc"]["lng"].floatValue))
    self.itemName = (json["item_name"].string)!
    self.itemDescription = json["item_description"].string!
    self.itemBuyURL = NSURL(string:json["buy_url"].string!)!
    self.itemPrice = json["item_price"].floatValue
    self.locationName = json["place_name"].string!
    self.coverImageURL = NSURL(string:json["cover_image"].string!)!
    self.itemBuyImageURL = NSURL(string:json["buy_image"].string!)!
    self.addressString = json["printable_address"].string!
  }
  
}
