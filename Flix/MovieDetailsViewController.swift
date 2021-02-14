//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Melanie Chan on 2/12/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!

    // movie whose details will be displayed
    var movie: [String: Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movie["title"])
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        // Images
        let baseUrl = "https://image.tmdb.org/t/p/w185" // base url of images from this API
        
        // poster
        let posterPath = movie["poster_path"] as! String    // string of url that leads to specific poster
        let posterUrl = URL(string: baseUrl + posterPath)   // combines base url & poster path into complete url
        posterImage.af_setImage(withURL: posterUrl!)    // set image

        // backdrop
        let backdropPath = movie["backdrop_path"] as! String    // string of url that leads to specific poster
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)   // combines base url & poster path into complete url
        backdropImage.af_setImage(withURL: backdropUrl!)    // set image

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
