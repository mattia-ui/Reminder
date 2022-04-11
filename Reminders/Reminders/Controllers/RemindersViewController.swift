//
//  RemindersViewController.swift
//  Reminders
//
//  Created by Mattia Cardone on 10/04/22.
//

import UIKit
import CoreData

class RemindersViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var RemindersTable: UITableView!
    
    
    var index: Int!
    
    fileprivate var remindersArray = [RemindersItem]()

    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RemindersTable.delegate = self
        updateData()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationDismiss"), object: nil)

    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        updateData()
        RemindersTable.reloadData()
        
    }

    
    func updateData() {
        remindersArray = CoreDataManager.fetchObj()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindersArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! RemindersViewCell
        let reminderItem = remindersArray[indexPath.row]
        cell.TitleLabel.text = reminderItem.title!
        
        return cell
        
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    @IBAction func deleteAllReminders(_ sender: Any) {
        CoreDataManager.cleanCoreData()
        updateData()
        RemindersTable.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ReminderDetail") {

            let viewController = segue.destination as! ReminderDetailViewController
            
            if let indexPath = RemindersTable!.indexPathForSelectedRow as NSIndexPath?{
                index = indexPath.row
                viewController.titoloString = remindersArray[index].title
                viewController.descrizioneString = remindersArray[index].description
                
            }
        }
    }

    

}
