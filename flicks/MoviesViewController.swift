//
//  MoviesViewController.swift
//  flicks
//
//  Created by emersonmalca on 10/16/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    let api = API()
    let dataSource = MoviesDataSource<MovieCollectionViewCell>()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        // Get the movies now playing
        api.getMovies(moviesPath()) { (movies, error) in
            guard error == nil && movies !=  nil else {
                // Show error
                return
            }
            
            // Update data source
            self.dataSource.update(withMovies: movies!)
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moviesPath() -> APIMoviesPath {
        return .NowPlaying
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Show detail view controller
    }
}

