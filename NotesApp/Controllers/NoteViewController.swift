//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Viktoriia Sharukhina on 12.02.2023.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteContent: UITextView!
    
    var folder: ObjectId?
    
    var note: Note?
    
    let service = Service()
    
    @IBAction func saveNote(_ sender: Any) {
        let newNote = Note()
        newNote.noteTitle = noteTitle.text ?? ""
        newNote.noteContent = noteContent.text ?? ""
        
        if note == nil {
            //add note
            service.createNote(folder!, newNote)
        } else {
            //update note
            service.updateNote(note!, newNote)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if note != nil {
            noteTitle.text = note?.noteTitle
            noteContent.text = note?.noteTitle
        }
        
    }
    


}
