//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Melanie Chan on 2/13/21.
//

import UIKit

class MovieGridViewController: UIViewController {
    
    // store data from API
    var movies = [[String: Any]]() // array of dictionaries

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get superhero movies
        // network request to get data from API
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

//            print(dataDictionary)
            
            // get data from dictionary and store into class variable
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
//            print(self.movies)

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
