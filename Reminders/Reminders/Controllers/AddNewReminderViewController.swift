//
//  ViewController.swift
//  Reminders
//
//  Created by Mattia Cardone on 10/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
    }

    @IBAction func saveReminder(_ sender: Any) {
            CoreDataManager.storeObj(title: TitleField.text ?? "", description: DescriptionField!.text ?? "")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

        
    }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Notification.Name("NotificationDismiss"), object: nil)

    }
 
 @objc func dismissKeyboard() {
     //Causes the view (or one of its embedded text fields) to resign the first responder status.
     view.endEditing(true)
 }
}

