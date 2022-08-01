//
//  MovieViewController.swift
//  MovieToDo
//
//  Created by Rushabh Shah on 2022-08-01.
//

import UIKit

class MovieViewController: UIViewController {
    @IBOutlet var moviename: UILabel!
    var update: (() -> Void)?
    var movie: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        moviename.text = movie
        // Do any additional setup after loading the view.
      
    }

}
