//
//  ViewController.swift
//  Todolist
//
//  Created by Antonello Fazio on 01/01/21.
//

import UIKit

class TodolistViewController: UITableViewController {

    var todoArray = ["Eggs", "Milk", "Bread", "Meat"]
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 250/255, blue: 154/255, alpha: 1)
        
        title = "To do list"
        
        if let savedItems = userDefault.array(forKey: "TodoList") as? [String] {
            todoArray = savedItems
        }
        
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
    
    @IBAction func addNewItemButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (addNewItem) in
            
            self.todoArray.append(textField.text!)
            
            self.userDefault.setValue(self.todoArray, forKey: "TodoList")
            
            self.tableView.reloadData()
        }
        
        ac.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        ac.addAction(addAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
   
}


