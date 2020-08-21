//
//  NetworkManger.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/18/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import Foundation

import Alamofire

// MARK:
enum ApiConstants {

static let BaseURL = "https://api.themoviedb.org/4"
static let ApiPath = "/4"
static let DiscoverURL = "/discover/movie"
static let SearchUrl = "/search/movie"
static let HeaderTokenKey = "Bearer "
static let HeaderTokenValue = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNTZjZDg2NzgyOWY1ZDU2ZmJlNjY2Mjc4Y2EzODZiNyIsInN1YiI6IjU4MDlkYWExOTI1MTQxNzc3ZjAwMGZkNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.erwCx0Xfhr2zL492r137hC2uhizqRFrnpGriQWpLnV8"
static let Headers : HTTPHeaders = [
    "Authorization" : ApiConstants.HeaderTokenKey + ApiConstants.HeaderTokenValue
]
    
}

class ApiClient {
    
 
    func getMovies(searchKeys : String,page : String ,handler : @escaping (Result<Movies, Error>) -> Void) {
        
        var urlParameters = URLComponents(string: ApiConstants.BaseURL)!
        urlParameters.path = ApiConstants.ApiPath
        // check to use discover or search mode
        if searchKeys != ""{   // search mode
            
            urlParameters.path += ApiConstants.SearchUrl
                   
                    urlParameters.queryItems = [
                                   URLQueryItem(name: "query", value: searchKeys),
                                  URLQueryItem(name: "page", value: page),
                               ]
        }
        
        else {
            urlParameters.path += ApiConstants.DiscoverURL
                            
            urlParameters.queryItems = [
                                            
                                           URLQueryItem(name: "page", value: page),
                                        ]
        }
        let url =  urlParameters.url!
        
        AlamaofireClient().requestGETURL(strURL: url, handler: handler)
    }
    

}




class AlamaofireClient{
    
    func requestGETURL(strURL: URL,handler: @escaping (Result<Movies, Error>) -> Void) {
   
        
        AF.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ApiConstants.Headers, interceptor: nil, requestModifier: nil).responseDecodable(of:Movies.self) {(response) in
            
            print(response)
            if response.error == nil {
                let films = response.value
                handler(.success(films!))
                print(response)
               
            }
            else {
                let error: NSError = response.error! as NSError
                handler(.failure (error))
            }
            
        }
    }
}
