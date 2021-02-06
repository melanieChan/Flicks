//
//  MoviesViewController.swift
//  Flix
//
//  Created by Melanie Chan on 2/5/21.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // store data from API in view controller to be accessed by program
    var movies = [[String: Any]]() // array of dictionaries
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        print("movies")
        
        // network request to get data from API
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            //print(dataDictionary)
            
            // get data from dictionary and store into class variable
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
