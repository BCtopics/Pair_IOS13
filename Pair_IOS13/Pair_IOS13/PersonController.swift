//
//  PersonController.swift
//  Pair_IOS13
//
//  Created by Bradley GIlmore on 6/30/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    //MARK: - Shared Instances
    
    static let shared = PersonController()
    
    //MARK: - Initializers
    
    init() {
        //FIXMR: - Fetch Stuff here..
    }
    
    //MARK: - Create, Save, Randomize, Fetch, Group
    
    func createPerson(fullName: String) {
        
        let person = Person(fullName: fullName)
        people.append(person)
        //FIXME: - Save
    }
    
    func saveToPersistentStore() {
        
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            NSLog("Error saving to persistent store \(error.localizedDescription)")
        }
        print("saveToPersistentStore Successful")
    }
    
    func saveRandom() {
        
        //FIXME: - randomize the array of people
        saveToPersistentStore()
    }
    
    func fetchPeople() {
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        people = (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    
    //MARK: - Properties
    
    var people: [Person] = []
    
}
