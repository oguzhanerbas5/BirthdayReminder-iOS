//
//  CoreDataManager.swift
//  birthdayReminder
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        // Create ManagedObjectModel programmatically
        let model = NSManagedObjectModel()
        
        let entity = NSEntityDescription()
        entity.name = "BirthdayEntity"
        entity.managedObjectClassName = NSStringFromClass(NSManagedObject.self)
        
        // Attributes
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .UUIDAttributeType
        idAttribute.isOptional = false
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.attributeType = .stringAttributeType
        nameAttribute.isOptional = false
        
        let dateAttribute = NSAttributeDescription()
        dateAttribute.name = "date"
        dateAttribute.attributeType = .dateAttributeType
        dateAttribute.isOptional = false
        
        let messageAttribute = NSAttributeDescription()
        messageAttribute.name = "message"
        messageAttribute.attributeType = .stringAttributeType
        messageAttribute.isOptional = true
        
        let reminderHourAttribute = NSAttributeDescription()
        reminderHourAttribute.name = "reminderHour"
        reminderHourAttribute.attributeType = .integer16AttributeType
        reminderHourAttribute.defaultValue = 9
        reminderHourAttribute.isOptional = false
        
        let reminderMinuteAttribute = NSAttributeDescription()
        reminderMinuteAttribute.name = "reminderMinute"
        reminderMinuteAttribute.attributeType = .integer16AttributeType
        reminderMinuteAttribute.defaultValue = 0
        reminderMinuteAttribute.isOptional = false
        
        entity.properties = [idAttribute, nameAttribute, dateAttribute, messageAttribute, reminderHourAttribute, reminderMinuteAttribute]
        model.entities = [entity]
        
        persistentContainer = NSPersistentContainer(name: "BirthdayReminderModel", managedObjectModel: model)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Core Data Error: \(error), \(error.userInfo)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - CRUD Operations
    
    func saveBirthday(_ birthday: Birthday) {
        let context = viewContext
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "BirthdayEntity")
        request.predicate = NSPredicate(format: "id == %@", birthday.id as CVarArg)
        
        do {
            let results = try context.fetch(request)
            let entityToSave: NSManagedObject
            if let existing = results.first {
                entityToSave = existing
            } else {
                guard let entityDesc = NSEntityDescription.entity(forEntityName: "BirthdayEntity", in: context) else { return }
                entityToSave = NSManagedObject(entity: entityDesc, insertInto: context)
            }
            
            entityToSave.setValue(birthday.id, forKey: "id")
            entityToSave.setValue(birthday.name, forKey: "name")
            entityToSave.setValue(birthday.date, forKey: "date")
            entityToSave.setValue(birthday.message, forKey: "message")
            entityToSave.setValue(Int16(birthday.reminderHour), forKey: "reminderHour")
            entityToSave.setValue(Int16(birthday.reminderMinute), forKey: "reminderMinute")
            
            try context.save()
            SharedBirthdayStore.shared.save(birthdays: fetchBirthdays())
        } catch {
            print("Failed to save birthday: \(error)")
        }
    }
    
    func fetchBirthdays() -> [Birthday] {
        let context = viewContext
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "BirthdayEntity")
        
        do {
            let results = try context.fetch(request)
            return results.compactMap { object -> Birthday? in
                guard let id = object.value(forKey: "id") as? UUID,
                      let name = object.value(forKey: "name") as? String,
                      let date = object.value(forKey: "date") as? Date else {
                    return nil
                }
                let message = object.value(forKey: "message") as? String ?? ""
                let hour = Int(object.value(forKey: "reminderHour") as? Int16 ?? 9)
                let minute = Int(object.value(forKey: "reminderMinute") as? Int16 ?? 0)
                
                return Birthday(id: id, name: name, date: date, message: message, reminderHour: hour, reminderMinute: minute)
            }
        } catch {
            print("Failed to fetch birthdays: \(error)")
            return []
        }
    }
    
    func deleteBirthday(withId id: UUID) {
        let context = viewContext
        let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "BirthdayEntity")
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try context.fetch(request)
            for object in results {
                context.delete(object)
            }
            try context.save()
            SharedBirthdayStore.shared.save(birthdays: fetchBirthdays())
        } catch {
            print("Failed to delete birthday: \(error)")
        }
    }
}
