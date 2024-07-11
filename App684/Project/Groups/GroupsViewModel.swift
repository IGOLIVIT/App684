//
//  GroupsViewModel.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI
import CoreData

final class GroupsViewModel: ObservableObject {
    
    @Published var groups: [GroupModel] = []
    @Published var isAddGroup: Bool = false
    @Published var isAddParticipant: Bool = false
    
    @Published var isDetail: Bool = false
    @Published var selectedGroup: GroupModel? = nil
    
    @Published var group_title: String = ""
    @Published var group_text: String = ""
    @Published var group_students: [ParticipantModel] = []
    
    @Published var student_name: String = ""
    @Published var student_age: String = ""
    
    func addGroup() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "GroupModel", into: context) as! GroupModel
        
        loan.title = group_title
        loan.text = group_text

        CoreDataStack.shared.saveContext()
    }
    
    func fetchGroups() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GroupModel>(entityName: "GroupModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.groups = result
            
        } catch let error as NSError {
            
            print("Error fetching: \(error), \(error.userInfo)")
            
            self.groups = []
        }
    }
    
    func addParticipant() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ParticipantModel", into: context) as! ParticipantModel
        
        loan.name = student_name
        loan.age = Int16(student_age) ?? 0
        loan.group_name = group_title

        CoreDataStack.shared.saveContext()
    }
    
    func fetchParticipants() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ParticipantModel>(entityName: "ParticipantModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.group_students = result.filter{$0.group_name == group_title}
            
        } catch let error as NSError {
            
            print("Error fetching: \(error), \(error.userInfo)")
            
            self.group_students = []
        }
    }
}
