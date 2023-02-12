//
//  Service.swift
//  NotesApp
//
//  Created by Viktoriia Sharukhina on 12.02.2023.
//

import Foundation
import RealmSwift

class Service {
    
    let realm = try! Realm()
    
    //create folder
    func createFolder(_ name: String) {
        
        let folder = Folder()
        folder.name = name
        
        try! realm.write({
            realm.add(folder)
        })
        
    }
    
    //create note
    func createNote(_ folderId: ObjectId, _ note: Note) {
        
        guard let folder = realm.object(ofType: Folder.self, forPrimaryKey: folderId) else { return }
        try! realm.write({
            folder.notes.append(note)
        })
        
    }
    
    //remove folder
    func removeFolder(_ folder: Folder) {
        
        //remove notes in folder
        for note in folder.notes {
            try! realm.write({
                realm.delete(note)
            })
        }
        
        //remove folder
        try! realm.write({
            realm.delete(folder)
        })
        
    }
    
    //remove note
    func removeNote(_ note: Note) {
        
        try! realm.write({
            realm.delete(note)
        })
        
    }
    
    //update note
    func updateNote(_ note: Note, _ newNote: Note) {
        try! realm.write({
            note.noteTitle = newNote.noteTitle
            note.noteContent = newNote.noteContent
        })
    }
    
}
