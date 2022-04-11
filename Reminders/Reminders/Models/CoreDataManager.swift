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
    class func storeObj(title:String,description:String,rem: Reminder?=nil) {
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
    //questo metodo è per l'update
    class func fetchObjFor(selectedScopeIdx:Int?=nil,targetText:String?=nil) -> [Reminder] {
        
        let prova = [Reminder]()
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
            return fetchResult
            }
        catch {
            print(error.localizedDescription)
        }
        
        return prova
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
        
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Reminders")
            do{
                if let reminder = try fetchObjFor(selectedScopeIdx: 0, targetText: title) as? [NSManagedObject] {
                    
                    reminder[0].setValue(titleEdited, forKey: "titolo")
                    reminder[0].setValue(descrEdited, forKey: "descrizione")
                    try context.save()
                }
             }
         catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    
}
