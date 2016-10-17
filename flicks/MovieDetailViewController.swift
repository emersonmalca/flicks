//
//  MovieDetailViewController.swift
//  flicks
//
//  Created by emersonmalca on 10/16/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: MovieDetailViewModel!
    var tempImage: UIImage?
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var detailsContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var detailsContainerWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // update UI
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {

        detailsContainerWidthConstraint.constant = view.bounds.size.width - 60.0
        detailsContainer.layoutIfNeeded()
        scrollView.contentInset = UIEdgeInsetsMake(view.bounds.size.height*0.6, 0.0, 80.0, 0.0)
        scrollView.contentSize = CGSize(width: scrollView.bounds.size.width, height: detailsContainer.bounds.size.height)
    }

    func updateUI() {
        
        // Get high res poster
        backgroundImageView.setImageWith(movie.posterURL, placeholderImage: tempImage)
        
        // Set the other details
        titleLabel.text = movie.title
        dateLabel.text = movie.date
        ratingsLabel.text = movie.rating
        summaryLabel.text = movie.summary
        
    }
}
