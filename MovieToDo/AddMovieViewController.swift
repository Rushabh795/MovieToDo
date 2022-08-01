//
//  AddMovieViewController.swift
//  MovieToDo
//
//  Created by Rushabh Shah on 2022-08-01.
//

import UIKit

class AddMovieViewController: UIViewController ,UITextFieldDelegate {
    @IBOutlet var feild:UITextField!
    var update: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
//to save data when user press save button
        feild.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self , action: #selector(saveMovie))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveMovie()
        return true
    }
    
    @objc func saveMovie()
    {
        guard let text = feild.text , !text.isEmpty else{
            return
        }
        let userDefaults = UserDefaults.standard
        var strings: [String] = userDefaults.object(forKey: "myMovieList") as? [String] ?? []
        strings.append(text)
        userDefaults.set(strings, forKey: "myMovieList")


//
//        guard let count = UserDefaults().value(forKey: "count") as? Int else
//        {
//            return
//        }
//        let newCount = count + 1
//        UserDefaults().set(newCount, forKey: "count")
//        UserDefaults().set(text, forKey: "movie_\(count)")
        //optional
        update?()
        //dismiss controller
        navigationController?.popViewController(animated: true)
    }
}
