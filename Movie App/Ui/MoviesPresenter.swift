//
//  MoviesPresenter.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/18/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import Foundation

//protocol MoviesPresenter {
//    func getMovies(senderTag : Int)
//    func presentMovies(movies :[Movie])
//    func saveMovies()
//}

class MoviesPresenter {
    
    var viewController : MoviesUpdater?
    var connected = true
    var isSearch = true
    var searchKey = ""
    
    init(vc : MoviesUpdater) {
        self.viewController = vc
    }
    
    func getData(searchKeys: String, page: String)  {
        searchKey = searchKeys
        connected = Reachability.isConnectedToNetwork()
        isSearch = (searchKeys == "") ?  !isSearch  : isSearch
        if connected {
            ApiClient().getMovies(searchKeys: searchKeys, page: page, handler: handleData)}
        else {
            viewController?.showError(error: "Please connect to network")
        }
    }
    
    func handleData(result :Result<Movies, Error>) -> Void {
        switch result {
        case .success (let movies):
            print("ok")
            viewController!.updateMovies(movies: movies.all)
            if isSearch{
                isSearch = false
                //DatabaseManger().save(films: movies.all)
                DatabaseManger().saveHistory(his:searchKey )
            }
        case .failure (let error):
            print(error)
            viewController?.showError(error: error.localizedDescription)
        }
    }
}
