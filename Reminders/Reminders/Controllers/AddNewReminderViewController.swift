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
        setup()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
    }

    @IBAction func saveReminder(_ sender: Any) {
        CoreDataManager.storeObj(title: TitleField.text?.capitalizingFirstLetter() ?? "", description: DescriptionField!.text?.capitalizingFirstLetter() ?? "")
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
    
    func setup(){
        SaveButton.layer.borderWidth = 1
        SaveButton.layer.borderColor = UIColor.black.cgColor
        SaveButton.layer.backgroundColor = UIColor.random().cgColor
        SaveButton.layer.cornerRadius = 10
        SaveButton.layer.masksToBounds = false
        SaveButton.layer.shadowColor = UIColor.black
            .cgColor
        SaveButton.layer.shadowOpacity = 0.5
        SaveButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        SaveButton.layer.shadowRadius = 4.0
        SaveButton.titleLabel?.textColor = .black
    }
    
}

