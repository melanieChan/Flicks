//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Melanie Chan on 2/13/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // store data from API
    var movies = [[String: Any]]() // array of dictionaries

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        // width of one cell
        // width of screen not including white space in between columns, divided by 3 columns
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 1.5)

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

            
            // get data from dictionary and store into class variable
            self.movies = dataDictionary["results"] as! [[String:Any]]
            
            self.collectionView.reloadData()
//            print(self.movies)

           }
        }
        task.resume()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // every cell will display poster
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
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
        
        // get the movie that was selected
        let cell = sender as! UICollectionViewCell   // selected movie is sender
        let indexPath = collectionView.indexPath(for: cell)!  // get index of selected cell
        let movie = movies[indexPath.item]   // get movie from API data using movie info's index
        
        // pass selected movie to movie details view controller
        // to display details of selected movie
        
        // get view controller that will be shown
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        // give that view controller info about movie in order to display info
        detailsViewController.movie = movie

    }
    

}
