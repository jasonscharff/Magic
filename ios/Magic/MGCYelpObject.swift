//
//  MGCYelpObject.swift
//  Magic
//
//  Created by Jason Scharff on 4/24/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

import Foundation
import SwiftyJSON

class MGCYelpObject : NSObject {
  
  var starRating : Int
  var imageURL : NSURL
  var yelpURL : NSURL
  
  init(json: JSON) {
    self.starRating = json["rating"].intValue
    self.yelpURL = NSURL(string:json["url"].string!)!
    self.imageURL = NSURL(string:json["rating_img"].string!)!
  }
  
  
}