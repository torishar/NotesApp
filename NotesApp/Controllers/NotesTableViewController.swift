//
//  NotesTableViewController.swift
//  NotesApp
//
//  Created by Viktoriia Sharukhina on 12.02.2023.
//

import UIKit
import RealmSwift

class NotesTableViewController: UITableViewController {

    let realm = try! Realm()
    var folderId: ObjectId?
    var notes: [Note]?
    var servise = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getNotes()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        getNotes()
    }
    
    @IBAction func addNote(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addNote") as? NoteViewController {
            vc.folder = folderId
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func getNotes() {
        if let folder = realm.object(ofType: Folder.self, forPrimaryKey: folderId) {
            self.notes = Array(folder.notes)
            tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note", for: indexPath)

        cell.textLabel?.text = notes?[indexPath.row].noteTitle
        cell.detailTextLabel?.text = "\(notes?[indexPath.row].date.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted(date: .abbreviated, time: .omitted))"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
  
            if let note = notes?[indexPath.row] {
                servise.removeNote(note)
                notes?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addNote") as? NoteViewController {
            vc.folder = folderId
            vc.note = notes?[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
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
