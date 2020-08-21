//
//  SearchViewController.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/18/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchResultsUpdating {
    
    @IBOutlet weak var contanierView: UIView!
    var savedSearchs = [String]()
    var searchKey = ""
    var presenter : MoviesPresenter?
    var page = "1"
    let searchController = UISearchController(searchResultsController: nil)
    let st = UIStoryboard(name: "Main", bundle: Bundle.main)
    var movieviewController : MovieViewController?
    var searchResultviewController : SearchResultsTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Search Movies"
        movieviewController = st.instantiateViewController(withIdentifier: "Moviesvc") as? MovieViewController
        searchResultviewController = st.instantiateViewController(withIdentifier: "SearchResultsTableViewController") as? SearchResultsTableViewController
        //self.addChild(movieviewController!)
        
        
        // Do any additional setup after loading the view.
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        // Add child vc
        self.addChild(searchResultviewController!)
        contanierView.addSubview(searchResultviewController!.view)
        searchResultviewController!.didMove(toParent: self)
        
    }
    
    // MARK: - SearchResult Updater Functions
    func updateSearchResults(for searchController: UISearchController) {
        searchKey = searchController.searchBar.text!
        print("updated")
        searchController.searchResultsController?.view.isHidden = false
        guard !searchKey.isEmpty  else {return}
        
        
        movieviewController!.searchKey = searchKey
        contanierView.addSubview(movieviewController!.view)
        movieviewController!.getMovies()
        
        //contanierView.addSubview(movieviewController!.view)
        
        
    }
    
    
    
    // MARK: - Parent Functions
    func notifyKeyChange(searchkey : String)  {
        movieviewController!.searchKey = searchkey
        contanierView.addSubview(movieviewController!.view)
        movieviewController!.getMovies()
    }
    func notifyMoviesChange()  {
        self.addChild(movieviewController!)
        contanierView.addSubview(movieviewController!.view)
        movieviewController!.didMove(toParent: self)
    }
    func notifyHistoryChange()  {
        //self.addChild(searchResultviewController!)
        contanierView.addSubview(searchResultviewController!.view)
        searchResultviewController!.didMove(toParent: self)
    }
    
    
    
}



