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
let numRowsToLazyLoad = 4;

@objc class MGCTableViewDataSource : NSObject, UITableViewDataSource {
  

  let algoliaClient : Client
  let index : Index
  var searchResults : [MGCItem] = [];
  var tableView : UITableView;
  
  var pageNumber = 0
  var query : String?
  var hasLoadedAll = false
  
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
    
    if(indexPath.row >= searchResults.count - numRowsToLazyLoad) {
      pageNumber += 1
      if query != nil {
        executeSearch(query!, pageNumber: pageNumber)
      }
      
    }
    
    return tableViewCell
    
  }
  
  func reloadTableView() {
    self.tableView.reloadData()
  }
  
  @objc func tableView(tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
      return searchResults.count
  }
  
  func executeSearch(query : String, pageNumber : Int) {
    let query = Query(query:query)
    query.page = pageNumber
    var results : Array<MGCItem>
    if(query.page == 0) {
      results = []
    }
    else {
      results = self.searchResults
    }
    index.search(query) { (content, error) in
      let resultsJSON = JSON(content!)
      let hits : JSON = resultsJSON["hits"]
      if hits.count == 0 {
        self.hasLoadedAll = true
      }
      else {
        self.hasLoadedAll = false
      }
      for item in hits {
        if let object = MGCItem(json: item.1) {
          results.append(object)
        }
      }
      self.searchResults = results
      self.reloadTableView()
      
    }
  }

  @objc func executeSearch (query : String) {
    pageNumber = 0
    self.query = query
    executeSearch(query, pageNumber: 0);
  }
  
  @objc func getItemForIndexPath(path:NSIndexPath) -> MGCItem {
    return self.searchResults[path.row];
  }
}
