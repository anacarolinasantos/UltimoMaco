//
//  Page1ViewController.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 09/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit
import Photos

class Page1ViewController: PageModelViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var warningPopup: UIView!
    @IBOutlet weak var warningButton: UIButton!
    
    var picker = UIImagePickerController()
    
    //MARK: - ViewController Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // -- SETUP
        picker.delegate = self
        self.hideKeyboardWhenTappedAround()
        nameTextField.delegate = self
        userPhoto.isUserInteractionEnabled = true
        
        //Setting warning
        warningButton.isHidden = true
        warningPopup.isHidden = true
        warningPopup.layer.cornerRadius = 11
    }
    
    //MARK: - UITextFieldDelegate
    
    // Dismiss keyboard, and capture text when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldContinueToNextViewController() -> Bool {
        return (nameTextField.text?.isValid())!
    }
    
    //MARK: - Actions
    
    @IBAction func warningTap(_ sender: UIButton) {
        warningPopup.isHidden = !warningPopup.isHidden
    }
}

extension Page1ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func didChangePhoto(_ sender: Any) {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ handler in
                if handler == .authorized {
                    self.showPickerPhoto()
                } else if handler == .denied {
                    self.alertAuth()
                }
            })
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            self.showPickerPhoto()
        }  else if PHPhotoLibrary.authorizationStatus() == .denied {
            self.alertAuth()
        }
    }
    
    func alertAuth() {
        let alert = UIAlertController(title: "Mude a permissão de acesso ao rolo de câmera nas configurações para poder alterar sua foto de perfil",
                                      message: nil,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "default"), style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func showPickerPhoto() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPhoto.layer.cornerRadius = userPhoto.frame.size.width / 2
            userPhoto.clipsToBounds = true
            userPhoto.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
