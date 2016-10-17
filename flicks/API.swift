//
//  API.swift
//  flicks
//
//  Created by emersonmalca on 10/16/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit
import AFNetworking

enum APIMoviesPath: String {
    case NowPlaying = "/3/movie/now_playing"
    case TopRated = "/3/movie/top_rated"
}

class API: NSObject {
    
    let manager = AFHTTPSessionManager(baseURL: URL(string: "https://api.themoviedb.org"))
    let apiKey = "e4248711c374686a1d9ac7c965468654"

    func getMovies(_ path: APIMoviesPath, withCompletion completion:@escaping (([Movie]?, Error?) -> Void)) {
        
        // Get now playing
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.get(path.rawValue, parameters: ["api_key": apiKey], progress: nil, success: { task, response in
            // Success
            print(response)
            if let topDict = response as? Dictionary<String, Any> {
                if let results = topDict["results"] as? [Dictionary<String, Any>] {
                    
                    var movies = [Movie]()
                    
                    for res in results {
                        
                        let id = String(res["id"] as! Int)
                        let title = res["title"] as! String
                        let summary = res["overview"] as! String
                        // we only want the movies with posters
                        if let relPath = res["poster_path"] as? String {
                            let posterPath = "https://image.tmdb.org/t/p/w500" + relPath
                            let posterURL = URL(string: posterPath)!
                            
                            let movie = Movie(id: id, title: title, summary: summary, posterURL: posterURL)
                            movies.append(movie)
                        }
                    }
                    
                    // Call success completion
                    completion(movies, nil)
                    return
                }
            }
            
            // Something didn't parse
            completion(nil, nil)
            
            }, failure: { task, error in
                //Error
                print(error)
                completion(nil, nil)
            })
    }
}
