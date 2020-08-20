//
//  DatabaseManger.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/18/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseManger {
    
    func saveHistory(his : String)  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "History", in: managedContext)!
         
        let f = NSManagedObject(entity: entity, insertInto: managedContext)
              f.setValue(his, forKeyPath: "name")
        do {
          try managedContext.save()
          print ("saved")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
          
    }
    
    func fetchHistory (handler : @escaping (Result<[String], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                 return
               }

               let managedContext = appDelegate.persistentContainer.viewContext
               let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "History")
        do {
              let historydata = try managedContext.fetch(fetchRequest)
            
              var historyArry = [String]()
            
                for history in historydata {
                 let name =  history.value(forKey: "name") as! String
                    historyArry.append(name)
                   
                }
                
                handler(.success(historyArry))
             } catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
             }

    }
    
    
//    func save(films: [Movie]) {
//      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//        return
//      }
//
//      let managedContext = appDelegate.persistentContainer.viewContext
//      let entity = NSEntityDescription.entity(forEntityName: "Film", in: managedContext)!
//        for film in films {
//      let f = NSManagedObject(entity: entity, insertInto: managedContext)
//            f.setValue(film.name, forKeyPath: "name")
//            f.setValue(film.overview, forKeyPath: "overview")
//            f.setValue(film.relaseDate, forKeyPath: "relaseDate")
//            f.setValue(film.thumbnail, forKeyPath: "thumbnail")
//      do {
//        try managedContext.save()
//        print ("saved")
//      } catch let error as NSError {
//        print("Could not save. \(error), \(error.userInfo)")
//      }
//        }
//    }
//
//    func fetch (handler : @escaping (Result<Movies, Error>) -> Void){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//           return
//         }
//
//         let managedContext = appDelegate.persistentContainer.viewContext
//         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Film")
//
//         do {
//          let films = try managedContext.fetch(fetchRequest)
//          var movies = [Movie]()
//            for film in films {
//
//                let movie = Movie(film.value(forKeyPath: "name") as! String,
//                                  film.value(forKeyPath: "overview") as! String,
//                                  film.value(forKeyPath: "relaseDate") as! String,
//                                  film.value(forKeyPath: "thumbnail") as! String)
//                movies.append(movie)
//
//            }
//
//            handler(.success(Movies(movies)))
//         } catch let error as NSError {
//           print("Could not fetch. \(error), \(error.userInfo)")
//         }
//    }
}
