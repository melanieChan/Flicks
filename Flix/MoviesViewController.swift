//
//  MoviesViewController.swift
//  Flix
//
//  Created by Melanie Chan on 2/5/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // store data from API in view controller to be accessed by program
    var movies = [[String: Any]]() // array of dictionaries
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

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

//            print(dataDictionary)
            
            // get data from dictionary and store into class variable
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            
            self.tableView.reloadData() // calls table view functions
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of rows
        return movies.count
    }
    
    // each row for each movie
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        // get movie (dictionary)
        let movie = movies[indexPath.row]
        
        // get movie title from dictionary (key - title, value - movie's title)
        let title = movie["title"] as! String
        
        let synopsis = movie["overview"] as! String
        
        // set outlets to display data
        cell.titleLabel.text = title
        
        cell.synopsisLabel.text = synopsis
        
        // poster
        let baseUrl = "https://image.tmdb.org/t/p/w185" // base url of images from this API
        let posterPath = movie["poster_path"] as! String    // string of url that leads to specific poster
        let posterUrl = URL(string: baseUrl + posterPath)   // combines base url & poster path into complete url
        
        // set image
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
//        print("loading movie details")
        
        // get the movie that was selected
        let cell = sender as! UITableViewCell   // selected movie is sender
        let indexPath = tableView.indexPath(for: cell)!  // get index of selected cell
        let movie = movies[indexPath.row]   // get movie from API data using movie info's index
        
        // pass selected movie to movie details view controller
        // to display details of selected movie
        
        // get view controller that will be shown
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        // give that view controller info about movie in order to display info
        detailsViewController.movie = movie
        
        // deselects cell after going back to movies main page from movie details screen
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
