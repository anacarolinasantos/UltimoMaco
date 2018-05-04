//
//  NewMotivationTableViewController.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 13/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import CoreData

class NewMotivationTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField?
    @IBOutlet weak var descriptionTextView: UITextView?
    @IBOutlet weak var motivationImage: UIImageView?
    @IBOutlet weak var removeTableViewCell: UITableViewCell!
    
    //MARK: - Atributes
    var motivation: Motivation?
    
    //MARK: - UIViewController life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motivation != nil {
            if let image = motivation?.getImageAsMedia() {
                motivationImage?.image = image
                
                if let description = motivation?.desMotivation {
                    titleTextField?.text = motivation?.title
                    descriptionTextView?.text = description
                }
            } else {
                titleTextField?.text = motivation?.title
                descriptionTextView?.text = motivation?.desMotivation
            }
            removeTableViewCell.isHidden = false
            self.title = "Editar motivação"
        } else {
            motivation = NSEntityDescription.insertNewObject(forEntityName: "Motivation", into: DatabaseController.persistentContainer.viewContext) as? Motivation
        }
        
        titleTextField?.delegate = self
        descriptionTextView?.delegate = self

        descriptionTextView?.layer.borderWidth = 0.5
        descriptionTextView?.layer.borderColor = UIColor(red: 216/255, green: 215/255, blue: 220/255, alpha: 1).cgColor
        descriptionTextView?.layer.cornerRadius = 5
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //If user select the imageView, then opens the picker view to choose an image
        if indexPath.section == 2 && indexPath.row == 0{
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        motivation?.imageAsMedia(image: image)
        
        dismiss(animated: true, completion: nil)
        
        motivationImage?.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    //MARK: - TextField delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Limit to 20 characters the motivation title
        let charLimit = 20
        
        let startLength = textField.text?.count ?? 0
        let addLength = string.count
        let lengthReplace = range.length
        
        let newLength = startLength + addLength - lengthReplace
        
        //Don't allow punctuation in the text field
        let setNotAllowed = NSCharacterSet.punctuationCharacters
        
        //Check all the possibilities to allow or not the insertion on the text field
        if string.isEmpty {
            return true
        } else if let _ = string.rangeOfCharacter(from: setNotAllowed, options: .caseInsensitive) {
            return false
        } else if newLength <= charLimit {
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - TextView delegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //If click in Done, then hides the keyboard
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        //always check all the possibilities to allow or not the insertion on the text field
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        
        //If text length is smaller than 100, return true
        return numberOfChars < 100
    }
    
    //MARK: - Action
    @IBAction func saveMotivation(_ sender: UIBarButtonItem) {
        
        if titleTextField?.text != nil || titleTextField?.text != "" {
            motivation?.title = titleTextField?.text
        }
        
        if descriptionTextView?.text != nil || descriptionTextView?.text != "" {
            motivation?.desMotivation = descriptionTextView?.text
        }
        
        DatabaseController.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeMotivation(_ sender: UIButton) {
        if let motivation = motivation {
            DatabaseController.persistentContainer.viewContext.delete(motivation)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
