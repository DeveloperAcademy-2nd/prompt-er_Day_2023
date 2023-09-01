//
//  QuestionDataController.swift
//  WhyFine
//
//  Created by Youngbin Choi on 2023/09/01.
//

import CoreData
import Foundation

class QuestionDataController: ObservableObject {
    let container = NSPersistentContainer(name: "QuestionModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Fail : \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("DATA SAVED")
        } catch {
            print("FAILED TO SAVE DATA")
        }
    }
    
    func addQuestion(sentence: String, context: NSManagedObjectContext) {
        let question = Question(context: context)
        question.sentence = sentence
        question.date = Date()
        
        save(context: context)
    }
}
