//
//  PersonListTableViewController.swift
//  Pair_IOS13
//
//  Created by Bradley GIlmore on 6/30/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if PersonController.shared.people.count % 2 == 0 {
            return PersonController.shared.people.count / 2 // Keeps same groups if there are no more then two people per group
        } else {
            return (PersonController.shared.people.count + 1) / 2 // Adds a new group if more then two people are already in one
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.pairs[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = PersonController.shared.pairs[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = person.fullName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Capstone Group \([section + 1][0])" // Creates the "Sections"
    }
    
    //MARK: - IBActions
    
    @IBAction func randomizeButtonTapped(_ sender: Any) {
        
        PersonController.shared.saveRandom()
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Enter Full Name", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Full Name"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            guard let textFields = alert.textFields,
                let nameTextField = textFields.first,
                let fullName = nameTextField.text, !fullName.isEmpty else { return }
            
            PersonController.shared.createPerson(fullName: fullName)
            
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
