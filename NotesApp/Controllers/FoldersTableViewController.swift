//
//  FoldersTableViewController.swift
//  NotesApp
//
//  Created by Viktoriia Sharukhina on 12.02.2023.
//

import UIKit
import RealmSwift

class FoldersTableViewController: UITableViewController {

    
    var alert = UIAlertController()
    let realm = try! Realm()
    var folders: [Folder]?
    let service = Service()
    
    @IBAction func addFolder(_ sender: Any) {
        alertAction()
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllFolders()
        
    }
    
    private func getAllFolders() {
        self.folders = Array(realm.objects(Folder.self))
        tableView.reloadData()
    }

    
    private func alertAction() {
    
        alert = UIAlertController(title: "Add folder", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name folder"
        }
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { action in
            if let text = self.alert.textFields?[0].text {
                self.service.createFolder(text)
                self.tableView.reloadData()
            }
        }
        alert.addAction(alertAction)
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return folders?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folder", for: indexPath)
        cell.textLabel?.text = folders?[indexPath.row].name
        cell.detailTextLabel?.text = "\(folders?[indexPath.row].notes.count)"
        
        return cell
    }
    


}
