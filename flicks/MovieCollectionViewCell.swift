//
//  MovieCollectionViewCell.swift
//  flicks
//
//  Created by emersonmalca on 10/16/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit
import AFNetworking

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var currentMovieID: String! // We will always have one, if we don't we should crash
}

extension MovieCollectionViewCell: Updatable {
    
    func update(withMovie movie: Movie) {
        
        // Save the current movie representation id
        currentMovieID = movie.id
        
        // Update with the movie model
        titleLabel.text = movie.title
        summaryLabel.text = movie.summary
        imageView.image = nil
        imageView.alpha = 0.0
        let request = URLRequest(url: movie.thumbnailURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        imageView.setImageWith(request, placeholderImage: nil, success: { (request, response, image) in
            // Success
            // Before setting the image we want to check if we're still showing the right movie
            guard self.currentMovieID == movie.id else {
                return
            }
            
            self.imageView.image = image
            UIView.animate(withDuration: 0.3, animations: { 
                self.imageView.alpha = 1.0
            })
            
            }, failure: { request, response, error in
                // failure, do nothing
        })
    }
}
