//
//  AddMovieViewController.swift
//  MovieToDo
//
//  Created by Rushabh Shah on 2022-08-01.
//

import UIKit

class AddMovieViewController: UIViewController ,UITextFieldDelegate {
    @IBOutlet var feild:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//to save data when user press save button
        feild.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveMovie()
        return true
    }
    
    @IBAction func saveMovie()
    {
        
    }
}
