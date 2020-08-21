//
//  SearchResultsTableViewController.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/20/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    var savedSearchs = [String]()
    var searchVC : SearchViewController?
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC = self.parent as? SearchViewController
        let screenBounds = UIScreen.main.bounds
        let rect = CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        tableView = UITableView(frame: rect, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        // get data from database
        DatabaseManger().fetchHistory(handler: handleSavedhistory)
        tableView.reloadData()
        
    }
    // MARK: - Handle saved history from database
    func handleSavedhistory(result :Result<[String], Error>) -> Void  {
        switch result {
        case .success (let History):
            
            savedSearchs = History
            tableView.reloadData()
            searchVC!.notifyHistoryChange()
        case .failure (let error):
            print(error)
        }
        
        
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedSearchs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = savedSearchs[indexPath.row]
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        searchVC!.notifyKeyChange(searchkey: savedSearchs[indexPath.row])
        
    }
    
    
    
    
    
    
}
