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
        fetchPeople()
    }
    
    //MARK: - Create, Save, Randomize, Fetch, Group
    
    func createPerson(fullName: String) {
        
        let person = Person(fullName: fullName)
        people.append(person)
        saveToPersistentStore()
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
        
        people.random()
        saveToPersistentStore() //FIXME: - This doesn't have any effect?
    }
    
    func fetchPeople() {
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        people = (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    func group(People: [Person]) -> [[Person]] {
        
        let split = 2
        let groupedPeople = stride(from: 0, to: People.count, by: split).map { Array(People[$0..<min($0 + split, People.count)]) }
        return groupedPeople
    }
    
    //MARK: - Properties
    
    var people: [Person] = [] {
        didSet {
            saveToPersistentStore() //FIXME: - How do I make it so the people model gets saved in coredata to?
        }
    }
    
    var pairs: [[Person]] {
        return group(People: people)
    }
    
}

//MARK: - Extensions

// This is so that I can call people.random and it will automatically shuffle the array.
extension Array {
    mutating func random() {
        for _ in 0..<30 { sort { (_,_) in arc4random() < arc4random() } } // is 20 a good number? 30?
    }
}
