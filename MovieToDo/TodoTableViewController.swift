//
//  TodoTableViewController.swift
//  tableTest
//
//  Created by Cambrian on 2022-07-05.
//

import UIKit

class TodoTableViewController: UITableViewController {

    var todos = [TodoState:[Todo]]()
    var randTitleList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        for state in TodoState.allCases{
            todos[state] = [Todo]()
        }
        
        randTitleList = ["do homework", "grade assignments", "dishs", "shopping", "walk the dog"]
        
        let randDescList = ["need to catch up in Chemistry", "people are waiting for their feedback", "the dishes are piling up and its getting stinky", "need some new cloths", "my hyper active dog needs to be walked daily"]
        
        for _ in 1...60{
            let newTodo = Todo(title: randTitleList[Int.random(in: 0..<randTitleList.count)], description: randDescList[Int.random(in: 0..<randDescList.count)])
            if Int.random(in: 0...10) == 10{
                newTodo.state = .complete
                todos[.complete]!.append(newTodo)
            } else {
                todos[.pending]!.append(newTodo)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var state: TodoState
        
        switch section {
        case 0:
            state = .pending
        case 1:
            state = .complete
        default:
            preconditionFailure("number of sections is greater then 2")
        }
        
        return todos[state]!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)

        var state: TodoState
        switch indexPath.section {
        case 0:
            state = .pending
        case 1:
            state = .complete
        default:
            preconditionFailure("number of sections is greater then 2")
        }
        
        // Configure the cell...
        cell.textLabel!.text = todos[state]![indexPath.row].title
        cell.detailTextLabel!.text = todos[state]![indexPath.row].state.rawValue

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String
        switch section {
        case 0:
            title = "Pending"
        case 1:
            title = "Completed"
        default:
            preconditionFailure("more then 2 sections")
        }
        return title
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


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard
            let indexPath = tableView.indexPathForSelectedRow
        else{preconditionFailure("no row was selected but segue was initiated")}
        
        let state: TodoState
        
        switch indexPath.section {
        case 0:
            state = .pending
        case 1:
            state = .complete
        default:
            preconditionFailure("more then 2 sections")
        }
        
        let todo = todos[state]?[indexPath.row]
        
        let dst = segue.destination as! DetailedViewController
        dst.todo = todo
        
    }

}
