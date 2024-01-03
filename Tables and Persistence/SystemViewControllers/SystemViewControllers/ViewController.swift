//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Devere Weaver on 1/2/24.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
    MFMailComposeViewControllerDelegate {

//==============================================================================
// MARK: IBOutlets
//==============================================================================
    @IBOutlet var imageView: UIImageView!
    
//==============================================================================
// MARK: View controller methods
//==============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /* Include the user's selected media in the info dictionary for the application to use. */
        
        // Unwrap the image from the info dictionary and cast it as a UIImage. Then set it to be the image
        // presented in the image view.
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        /* Dismiss the email compose view controller when the user has completed their email business. */
        dismiss(animated: true, completion: nil)
    }
    
//==============================================================================
// MARK: IBActions
//==============================================================================
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        /* Share the image with an activity controller. */
        guard let image = imageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        // Needed for the ipad to present the controller as a pop up.
        // This has no effect on smaller iOS devices.
        activityController.popoverPresentationController?.sourceView = sender
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        /* Present a Safari view controller to the user. */
        
        // The URL initializer returns an optional and needs to be
        // unwrapped before attempting to use it.
        if let url = URL(string: "https://www.apple.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        /* Present an Alert controller to the user to choose an option for the image view. */
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source",
                                                message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Check if the camera is available on the device before adding it to the alert controller.
        // In the handler we define the data source for the UIImagePickerController and then
        // present it using its delegate, which is the current view controller. The same is performed
        // for the photo library as well.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default,
                                             handler: {
                                                action in imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }


        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default,
                                                   handler: {
                                                        action in imagePicker.sourceType = .photoLibrary
                                                        self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        /* Allow the user to send an email from the application. */
        guard MFMailComposeViewController.canSendMail() else {
            print("Email is not available on this device.")
            return
        }
        
        // Create an instance of the mail compose controller and set the view controller as
        // the mail composer delegate.
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        // Use the mail composer to configure details of the email.
        mailComposer.setToRecipients(["devereaweaver@icloud.com"])
        mailComposer.setSubject("Look at this!!")
        mailComposer.setMessageBody("Yoooooooooo", isHTML: false)
        
        // Let's go ahead and send that image in the image view as an attachment as well
        if let image = imageView.image,
           let jpegData = image.jpegData(compressionQuality: 0.9) {
            mailComposer.addAttachmentData(jpegData, mimeType: "image/jpeg", fileName: "photo.jpg")
        }
        
        present(mailComposer, animated: true, completion: nil)
    }
    
}    // end of view controller
