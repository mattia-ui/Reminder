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
    
    var diction : Dictionary<String,AnyObject> = ["titolo" : Reminder()]
    var titoloString: String?
    var descrizioneString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TitoloDetail.text = titoloString
        DescrizioneDetail.text = descrizioneString
        setUp()
        
//        let aSelector : Selector = "lblTapped"
        let aSelector : Selector = Selector(("lblTapped"))
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        DescrizioneDetail.addGestureRecognizer(tapGesture)
        TitoloDetail.addGestureRecognizer(tapGesture)
         
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
        
        //CoreDataManager.storeObj(title: TitleField.text ?? "", description: DescriptionField.text ?? "")
        
        SalvaButton.isHidden = true
        SalvaButton.isEnabled = false
        ModificaBtn.isEnabled = true
        ModificaBtn.isHidden = false
        fldTapped()
        CoreDataManager.updateEvent(title: titoloString ?? "",titleEdited: TitoloDetail.text ?? "", descrEdited: DescrizioneDetail.text ?? "")
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
        DescrizioneDetail.text = DescriptionField.text
        
        TitoloDetail.isHidden = false
        TitleField.isHidden = true
        TitoloDetail.text = TitleField.text
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
    }
    
}

