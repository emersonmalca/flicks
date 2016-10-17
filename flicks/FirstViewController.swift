//
//  FirstViewController.swift
//  flicks
//
//  Created by emersonmalca on 10/16/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit

class FirstViewController: MoviesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func moviesPath() -> APIMoviesPath {
        return .NowPlaying
    }


}
