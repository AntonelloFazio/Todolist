//
//  ViewController.swift
//  Todolist
//
//  Created by Antonello Fazio on 01/01/21.
//

import UIKit

class TodolistViewController: UITableViewController {

    var todoArray = ["Eggs", "Milk", "Bread", "Meat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .red
        
        title = "To do list"
        
        
    }

    
    //MARK: - Table View Data source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = todoArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - Table View Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .some(.checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
  
}


