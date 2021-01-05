//
//  ViewController.swift
//  Todolist
//
//  Created by Antonello Fazio on 01/01/21.
//

import UIKit

class TodolistViewController: UITableViewController {

    var todoArray = [Item]()
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 250/255, blue: 154/255, alpha: 1)
        
        title = "To do list"
        
        load()
        
    }

    
    //MARK: - Table View Data source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        
        cell.textLabel?.text = todoArray[indexPath.row].title
        
        cell.accessoryType = todoArray[indexPath.row].isChecked ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Table View Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        todoArray[indexPath.row].isChecked = !todoArray[indexPath.row].isChecked
        
        save()
            
        tableView.reloadData()
    }
    
    @IBAction func addNewItemButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        textField.keyboardAppearance = .light
        textField.autocapitalizationType = .words
        
        let ac = UIAlertController(title: "Add New Item", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (addNewItem) in
            
            let item = Item()
            item.title = textField.text!
            
            self.todoArray.append(item)
            
            self.save()
            
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
    
   
    //MARK: - SAVE AND LOAD DATA
    
    func save() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.todoArray)
            try data.write(to: filePath!)
        } catch {
            print("Error encoding the items attay: \(error)")
        }
    }

    func load() {
        if let data = try? Data(contentsOf: filePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                todoArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decpoding the items attay: \(error)")
            }
        }
    }
    
}


