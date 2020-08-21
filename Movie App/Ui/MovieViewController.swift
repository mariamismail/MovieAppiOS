//
//  MovieViewController.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/18/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import UIKit

// Protocol od Movies Array Updater
protocol MoviesUpdater {
    
    func updateMovies(movies : [Movie])
    func showError(error :String)
    
}
class MovieViewController: UIViewController,MoviesUpdater {

    var presenter : MoviesPresenter?
    var movies = [Movie]()
    var page = 1
    var searchKey = ""
    var oldSearchKey = ""
    

    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var moviesTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Register the movie cell xib file to tabel
        moviesTbl.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        moviesTbl.dataSource = self
        moviesTbl.rowHeight = 200
        presenter = MoviesPresenter(vc : self)
        getMovies()
    }
 
   // MARK: - MoviesUpdater functions
   func showError(error: String) {
       self.createAlretWith(message: error, tiltle: "Alret")
   }

   func updateMovies(movies: [Movie]) {
       if searchKey == "" || oldSearchKey == searchKey {
         self.movies += movies
       }
       else {self.movies = movies}
       self.moviesTbl.reloadData()
       if let parent = (self.parent as? SearchViewController){
           parent.notifyMoviesChange()
       }
   }
   
   func getMovies()  {
       oldSearchKey = presenter!.searchKey
       presenter!.getData(searchKeys: searchKey, page: String(page))
       
   }
}
// MARK: - MovieTabel DataSource
extension MovieViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.movies.count - 1 {
             page += page
             getMovies()
           }
        let cell = moviesTbl.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(for: movies[indexPath.row])

        return cell
    }
    
    
}

