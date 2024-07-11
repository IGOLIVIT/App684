//
//  TrainingViewModel.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI
import CoreData

final class TrainingViewModel: ObservableObject {
    
    @Published var workouts: [TrainingModel] = []
    @Published var isAddWorkout: Bool = false
    
    @Published var isDetail: Bool = false
    @Published var selectedGroup: TrainingModel? = nil
    
    @Published var title: String = ""
    @Published var date: String = ""
    @Published var note: String = ""
    
    @Published var group_name: String = ""
    @Published var groups: [GroupModel] = []
    
    func addWorkout() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TrainingModel", into: context) as! TrainingModel
        
        loan.title = title
        loan.date = date
        loan.note = note
        loan.group_name = group_name
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchWorkouts() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TrainingModel>(entityName: "TrainingModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.workouts = result
            
        } catch let error as NSError {
            
            print("Error fetching: \(error), \(error.userInfo)")
            
            self.workouts = []
        }
    }
}
