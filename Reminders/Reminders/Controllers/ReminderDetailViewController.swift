//
//  ReminderDetailViewController.swift
//  Reminders
//
//  Created by Mattia Cardone on 10/04/22.
//

import UIKit

class ReminderDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TitoloDetail: UILabel!
    @IBOutlet weak var DescrizioneDetail: UILabel!
    @IBOutlet weak var DescriptionField: UITextField!
    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var ModificaBtn: UIButton!
    @IBOutlet weak var SalvaButton: UIButton!
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    
    var titoloString: String?
    var descrizioneString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TitoloDetail.text = titoloString
        DescrizioneDetail.text = descrizioneString
        setUp()
        
        let aSelector : Selector = Selector(("lblTapped"))
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        DescrizioneDetail.addGestureRecognizer(tapGesture)
        TitoloDetail.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
       view.addGestureRecognizer(tap)
         
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: Notification.Name("NotificationDismiss"), object: nil)

    }
    

    @IBAction func modifica(_ sender: Any) {
        lblTapped()
        SalvaButton.isHidden = false
        SalvaButton.isEnabled = true
        ModificaBtn.isEnabled = false
        ModificaBtn.isHidden = true
    }
    
    @IBAction func salva(_ sender: Any) {
        
        SalvaButton.isHidden = true
        SalvaButton.isEnabled = false
        ModificaBtn.isEnabled = true
        ModificaBtn.isHidden = false
        fldTapped()
        CoreDataManager.updateEvent(title: titoloString ?? "",titleEdited: TitoloDetail.text?.capitalizingFirstLetter() ?? "", descrEdited: DescrizioneDetail.text?.capitalizingFirstLetter() ?? "")
    }
    
    func lblTapped(){
        
        DescrizioneDetail.isHidden = true
        DescriptionField.isHidden = false
        DescriptionField.text = DescrizioneDetail.text
            
        TitoloDetail.isHidden = true
        TitleField.isHidden = false
        TitleField.text = TitoloDetail.text
        
        }

    func fldTapped(){
        
        DescrizioneDetail.isHidden = false
        DescriptionField.isHidden = true
        DescrizioneDetail.text = DescriptionField.text?.capitalizingFirstLetter()
        
        TitoloDetail.isHidden = false
        TitleField.isHidden = true
        TitoloDetail.text = TitleField.text?.capitalizingFirstLetter()
        
    }
    
    
    @IBAction func shareTextButton(_ sender: UIButton) {
        
        // text to share
        let text = TitoloDetail.text! + ", /n" + DescrizioneDetail.text!
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        //se volessi escludere qualche social su cui condividere
//        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteReminder(_ sender: Any) {
        
        CoreDataManager.clearObject(title: titoloString ?? "")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
      
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUp(){
        
        SalvaButton.isHidden = true
        SalvaButton.isEnabled = false
        
        DescriptionField.delegate = self
        DescriptionField.isHidden = true
        DescrizioneDetail.isUserInteractionEnabled = true
        TitleField.delegate = self
        TitleField.isHidden = true
        TitoloDetail.isUserInteractionEnabled = true
        
        ModificaBtn.layer.borderWidth = 1
        ModificaBtn.layer.borderColor = UIColor.black.cgColor
        ModificaBtn.layer.backgroundColor = UIColor.random().cgColor
        ModificaBtn.layer.cornerRadius = 10
        ModificaBtn.layer.masksToBounds = false
        ModificaBtn.layer.shadowColor = UIColor.black
            .cgColor
        ModificaBtn.layer.shadowOpacity = 0.5
        ModificaBtn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        ModificaBtn.layer.shadowRadius = 4.0
        ModificaBtn.titleLabel?.textColor = .black
        
        SalvaButton.layer.borderWidth = 1
        SalvaButton.layer.borderColor = UIColor.black.cgColor
        SalvaButton.layer.backgroundColor = UIColor.random().cgColor
        SalvaButton.layer.cornerRadius = 10
        SalvaButton.layer.masksToBounds = false
        SalvaButton.layer.shadowColor = UIColor.black
            .cgColor
        SalvaButton.layer.shadowOpacity = 0.5
        SalvaButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        SalvaButton.layer.shadowRadius = 4.0
        SalvaButton.titleLabel?.textColor = .black
        
        ShareButton.layer.borderWidth = 1
        ShareButton.layer.borderColor = UIColor.black.cgColor
        ShareButton.layer.cornerRadius = 10
        ShareButton.clipsToBounds = true
        ShareButton.layer.shadowColor = UIColor.black
            .cgColor
        ShareButton.layer.shadowOpacity = 0.5
        ShareButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        ShareButton.layer.shadowRadius = 4.0
        ShareButton.layer.masksToBounds = false
        
        DeleteButton.layer.borderWidth = 1
        DeleteButton.layer.borderColor = UIColor.black.cgColor
        DeleteButton.layer.cornerRadius = 10
        DeleteButton.clipsToBounds = true
        DeleteButton.layer.shadowColor = UIColor.black
            .cgColor
        DeleteButton.layer.shadowOpacity = 0.5
        DeleteButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        DeleteButton.layer.shadowRadius = 4.0
        DeleteButton.layer.masksToBounds = false
        
        TitoloDetail.layer.borderColor = UIColor.random().cgColor
        TitoloDetail.layer.cornerRadius = 10
        TitoloDetail.layer.borderWidth = 1
        
        DescrizioneDetail.layer.borderColor = UIColor.random().cgColor
        DescrizioneDetail.layer.cornerRadius = 10
        DescrizioneDetail.layer.borderWidth = 1
    }
    
}

