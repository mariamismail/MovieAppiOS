//
//  ViewControllerExtension.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/20/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func createAlretWith(message: String,tiltle:String) -> Void {
    
        let alret = UIAlertController(title: tiltle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alret.addAction(action)
        self.present(alret, animated: false, completion: nil)
    }
}
