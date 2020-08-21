//
//  MovieCell.swift
//  Movie App
//
//  Created by Mariam Elsayed Ismail on 8/17/20.
//  Copyright © 2020 Mariam Ismail. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var thumbnilView: UIImageView!
   
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var relaseLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(for movie: Movie) {
       nameLbl.text = movie.name
       overviewLbl.text = movie.overview
        relaseLbl.text = movie.relaseDate
        thumbnilView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)

       if let thumbnail = movie.thumbnail   {
             var url = URL(string:"http://image.tmdb.org/t/p/w92//")!
                   url.appendPathComponent(thumbnail)
                   thumbnilView.af.setImage(withURL : url )
        }
       
        
    }
    override func prepareForReuse() {
       super.prepareForReuse()

      thumbnilView.af.cancelImageRequest()
      thumbnilView.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
