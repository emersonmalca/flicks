//
//  MoviesViewController.swift
//  flicks
//
//  Created by emersonmalca on 10/16/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit
import MBProgressHUD

class MoviesViewController: UIViewController {
    
    let api = API()
    let dataSource = MoviesDataSource<MovieCollectionViewCell>()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        // Set refresh control
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        // Get the movies
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        getMovies {
            hud.hide(animated: true)
        }
    }
    
    func didPullToRefresh(sender: UIRefreshControl) {
        getMovies { 
            sender.endRefreshing()
        }
    }
    
    func getMovies(completion: (() -> ())?) {
        // Get the movies now playing
        api.getMovies(moviesPath()) { (movies, error) in
            guard error == nil && movies !=  nil else {
                // Show error
                return
            }
            
            // Update data source
            self.dataSource.update(withMovies: movies!)
            self.collectionView.reloadSections(IndexSet(integer: 0))
            
            // Call completion if any
            if let callback = completion {
                callback()
            }
        }
    }
    
    func moviesPath() -> APIMoviesPath {
        return .NowPlaying
    }
    
    func movieDetailViewModel(from movie: Movie) -> MovieDetailViewModel {
        let fm = DateFormatter()
        fm.dateFormat = "yyyy-mm-dd"
        let date = fm.date(from: movie.date)
        fm.dateFormat = "MMMM dd, yyyy"
        let dateString = fm.string(from: date!)
        
        let ratingsString = String(Int(movie.ratings*10.0)) + "%"
        
        let viewModel = MovieDetailViewModel(title: movie.title, date: dateString, rating: ratingsString, duration: "", summary: movie.summary, posterURL: movie.posterURL)
        
        return viewModel
    }

}

extension MoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            
            // Get the thumbnail if possible
            if let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell {
                vc.tempImage = cell.imageView.image
            }
            
            // Get the movie and set it
            let movie = dataSource.movie(at: indexPath.item)
            vc.movie = movieDetailViewModel(from: movie)
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

