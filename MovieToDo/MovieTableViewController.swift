//
//  MovieTableViewController.swift
//  MovieToDo
//
//  Created by Rushabh Shah on 2022-07-31.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movieList:[String] = ["Eternals","Dune","No Time To Die","Last Night in Soho","Ron’s Done Wrong","Halloween Kills","Venom","Antlers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.isEditing = true
        //setUp
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(movieList, forKey: "myMovieList")
        updateMovieList()
    }
    
    func updateMovieList()
    {
        movieList.removeAll()
        let userDefaults = UserDefaults.standard
        let strMovieArr: [String] = userDefaults.object(forKey: "myMovieList") as? [String] ?? []
        movieList.append(contentsOf: strMovieArr)
        tableView.reloadData()
    }
    //Add new movie button click
    @IBAction func didTapAdd()
    {
        let addvc = storyboard?.instantiateViewController(withIdentifier: "add") as! AddMovieViewController
        addvc.title = "Add Movie"
        addvc.update = {
            DispatchQueue.main.async{
                self.updateMovieList()
            }
            
        }
        navigationController?.pushViewController(addvc, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //total number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieList.count
    }
    //cell click event
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addvc = storyboard?.instantiateViewController(withIdentifier: "view") as! MovieViewController
        addvc.title = "View Movie"
        addvc.movie = movieList[indexPath.row]
        navigationController?.pushViewController(addvc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movietodo", for: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = movieList[indexPath.row]
        return cell
    }
    //editing style
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //move cell
    override func tableView(_ tableView: UITableView, moveRowAt indexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let userDefaults = UserDefaults.standard
        var strMovieArr: [String] = userDefaults.object(forKey: "myMovieList") as? [String] ?? []
        let movedObject = strMovieArr[indexPath.row]
        strMovieArr.remove(at: indexPath.row)
        strMovieArr.insert(movedObject, at: destinationIndexPath.row)
        userDefaults.set(strMovieArr, forKey: "myMovieList")
    }


    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    //delete cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            movieList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let userDefaults = UserDefaults.standard
            var strMovieArr: [String] = userDefaults.object(forKey: "myMovieList") as? [String] ?? []
            strMovieArr.remove(at: indexPath.row)
            userDefaults.set(strMovieArr, forKey: "myMovieList")
        }
    }
}
 
