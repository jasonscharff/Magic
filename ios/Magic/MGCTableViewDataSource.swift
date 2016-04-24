//
//  MGCTableViewDataSource.swift
//  Magic
//
//  Created by Jason Scharff on 4/23/16.
//  Copyright © 2016 Jason Scharff. All rights reserved.
//

import UIKit

import AlgoliaSearch
import SwiftyJSON

let reuseIdentifier = "com.magic.searchtableviewcell"

@objc class MGCTableViewDataSource : NSObject, UITableViewDataSource {
  

  let algoliaClient : Client
  let index : Index
  var searchResults : [MGCItem] = [];
  var tableView : UITableView;
  
  init(tableView:UITableView) {
    self.tableView = tableView
    self.tableView.registerClass(MGCSearchTableViewCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
    algoliaClient = AlgoliaSearch.Client(appID: kMGCAlgoliaApplicationID, apiKey: kMGCAlgoliaAPIKey)
    index = algoliaClient.getIndex(kMGCAlgoliaIndexName)
  }
  
  
  @objc func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let tableViewCell = MGCSearchTableViewCell(style: .Default, reuseIdentifier: reuseIdentifier)
    tableViewCell.item = searchResults[indexPath.row]
    return tableViewCell
    
  }
  
  @objc func tableView(tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
      return searchResults.count
  }
  
  @objc func executeSearch (string : String) {
    let query = Query(query:string)
    
    index.search(query) { (content, error) in
      var results : Array<MGCItem> = []
      let resultsJSON = JSON(content!)
      let hits : JSON = resultsJSON["hits"]
      for item in hits {
        print(item)
          if let object = MGCItem(json: item.1) {
            results.append(object)
          }
        }
        self.searchResults = results
        self.tableView.reloadData()
      
      }
    }
  }
