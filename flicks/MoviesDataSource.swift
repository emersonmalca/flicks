//
//  MoviesDataSource.swift
//  flicks
//
//  Created by emersonmalca on 10/16/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import Foundation
import UIKit

class MoviesDataSource<T>: NSObject, UICollectionViewDataSource where T: Updatable, T: UICollectionViewCell {

    let reuseIdentifier: String = {
        let full = NSStringFromClass(T.self)
        let range = full.range(of: ".")
        if let range = range {
            return full.substring(from: range.upperBound)
        } else {
            return full
        }
    }()
    
    var movies = [Movie]()
    
    func update(withMovies movies:[Movie]) {
        
        self.movies.removeAll()
        self.movies.append(contentsOf: movies)
    }
    
    
    // UICollectionViewDataSource -----------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = movies[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
        cell.update(withMovie: movie)
        return cell
    }
}


/*
    This gives an error:
    @objc is not supported within extensions of generic classes
    but it works if we don't do it in an extension, so I moved it up
 */
/*
extension MoviesDataSource: UICollectionViewDataSource {
    
}
 */
