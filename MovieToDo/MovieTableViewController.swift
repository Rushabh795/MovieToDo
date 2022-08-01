//
//  MovieTableViewController.swift
//  MovieToDo
//
//  Created by Rushabh Shah on 2022-07-31.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movieList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        tableView.delegate = self
        tableView.dataSource = self
        //setUp
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
 updateMovieList()
    }
    
    func updateMovieList()
    {
        movieList.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {
            return
        }
        //get all the movie by for loop
        for x in 0..<count
        {
            //check its empty or not
            if let movie = UserDefaults().value(forKey: "movie_\(x+1)") as? String{
                movieList.append(movie)
               
           }
        }
        tableView.reloadData()
    }

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movietodo", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = movieList[indexPath.row]
        return cell
    }
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
