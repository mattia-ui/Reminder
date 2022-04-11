//
//  CoreDataManager.swift
//  Reminders
//
//  Created by Mattia Cardone on 10/04/22.
//

import UIKit
import CoreData

struct RemindersItem {
    var title:String?
    var description:String?
    
    
    init() {
        title = ""
        description = ""
         
    }
    init(title:String,description:String) {
        self.title = title
        self.description = description
        
    }
}

class CoreDataManager: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///store obj into core data
    class func storeObj(title:String,description:String) {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(title, forKey: "titolo")
        managedObj.setValue(description, forKey: "descrizione")
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    ///fetch all the objects from core data
    class func fetchObj(selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [RemindersItem] {
        var aray = [RemindersItem]()
        
        let fetchRequest:NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        if selectedScopeIdx != nil && targetText != nil{
            
            var filterKeyword = ""
            switch selectedScopeIdx! {
            case 0:
                filterKeyword = "titolo"
            default:
                filterKeyword = "descrizione"
            }

            var predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
        
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let rem = RemindersItem(title: item.titolo!, description: item.descrizione!)
                aray.append(rem)
                print("titolo:"+rem.title!+"\n descrizione:"+rem.description!)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return aray
    }

    ///delete all the data in core data
    class func cleanCoreData() {
        
        let fetchRequest:NSFetchRequest<Reminder> = Reminder.fetchRequest()
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }
  
    
   
    
    class func updateEvent( title: String, titleEdited: String, descrEdited: String) {
        
            let context = getContext()
            var reminder: RemindersItem = fetchObj(selectedScopeIdx: 0, targetText: title)[0]
            
            print(reminder.title)
            reminder.title = titleEdited
            reminder.description = descrEdited
            print(reminder.title)
            do {
                try context.save()//self.storeObj(title: reminder.title ?? "", description: reminder.description ?? "")
            }catch {
                print(error.localizedDescription)
            }
        
        
        
    }
    
    
    
}
