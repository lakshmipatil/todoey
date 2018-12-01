//
//  ViewController.swift
//  todoey
//
//  Created by Basavaraj Soppannavar on 11/21/18.
//  Copyright © 2018 Lakshmi B S. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
   // let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
      
        loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
//
        // Do any additional setup after loading the view, typically from a nib.
    }
    // Mark table view methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
       
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // ternary operator ==>
        // value = condition ? valueTrue : valueFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
   
    }
    //mark - tableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark // only check mark
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
//
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else
//        {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
       // tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        }
    // mark - add more items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
       let alert = UIAlertController(title: "Add New Items to Todoey", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what happens when user clicks add item button
        
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            //print(alertTextField.text!) triggers only in this clousure doesn't take the method field
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    // Model manupulation methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array,\(error)")
        }
        
        // self.defaults.set(self.itemArray, forKey: "TodoListArray")
        self.tableView.reloadData()   // to show items in table
        
    
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding item array, \(error)")
        }
    }
}
}

