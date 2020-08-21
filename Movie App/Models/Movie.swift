//
//  Movie.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/17/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import Foundation

// Movie Struct to map movie object
 
struct Movies  : Codable {
       let all: [Movie]
    init(_ movies :[Movie]) {
        self.all = movies
    }
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}
   struct Movie : Codable  {
    let thumbnail : String?
    let name : String
    let relaseDate , overview : String?
    init(_ name : String, _ overview : String?, _ relaseDate : String?, _ thumbnail : String?) {
        self.name = name
        self.overview = overview
        self.relaseDate = relaseDate
        self.thumbnail = thumbnail
    }
    enum CodingKeys: String, CodingKey {
           case name = "title"
           case thumbnail = "poster_path"
           case relaseDate = "release_date"
           case overview = "overview"
       }
}
