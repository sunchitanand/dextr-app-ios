//
//  UserProfileViewController.swift
//  Dexter
//
//  Created by Sunchit Anand on 2/20/20.
//  Copyright © 2020 Sunchit Anand. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    /* MARK: Buttons */
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    /* MARK: ImageViews/ Views */
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var twitterLogo: UIImageView!
    @IBOutlet weak var instagramLogo: UIImageView!
    
    /* MARK: Text Views */
    @IBOutlet weak var aboutTextView: UITextView!
    
    
    /* MARK: Labels */
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var twitterUsernameLabel: UILabel!
    @IBOutlet weak var instagramUsernameLabel: UILabel!
    
    public var temp : String = ""
    public var selectedUser  = User(documentData: [:])
    
    static var hasReportedOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        setupData()
    }
    
    @IBAction func moreTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let flagAction = UIAlertAction(title: "Report as Inappropriate", style: .default) { _ in
            print("Reporting \(String(describing: self.selectedUser?.email))")
            
            let successAlert = UIAlertController(title: "Reported", message: "The user account has been reported as inappropriate.", preferredStyle: UIAlertController.Style.alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            let errorAlert = UIAlertController(title: "Error Occurred", message: "There was an error reporting the user. Please try again or contact developer for more help.", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            if !UserProfileViewController.hasReportedOnce {
                UserModelController.flagUser(uid: self.selectedUser!.uid) { (response) in
                    switch response {
                    case .success(_):
                        UserProfileViewController.hasReportedOnce = true
                        self.present(successAlert, animated: true, completion: nil)
                        
                    case .failure(_):
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
            }
            else {
                self.present(successAlert, animated: true, completion: nil)
            }
        }
        alertController.addAction(flagAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //        cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        alertController.view.tintColor = .white
        //        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        //        subview.layer.cornerRadius = 1
        //        subview.backgroundColor = Theme.Color.darkBg
    }
    
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupElements() {
        let backgroundColor = Theme.Color.darkBg
        self.view.backgroundColor = backgroundColor
        
        /* MARK: Buttons */
        Render.styleBackButton(backButton)
        
        
        /* MARK: Views */
        Render.renderUserCardElements(cardContainer: container, separator: separator, profilePhoto: profilePhotoImageView, twitterLogo: twitterLogo, instagramLogo: instagramLogo, fullName: fullNameLabel, email: emailLabel, bio: aboutTextView, twitterHandle: twitterUsernameLabel, instagramUsername: instagramUsernameLabel)
        
        let moreImg = UIImage(named: "baseline_more_vert_white_24pt")?.withRenderingMode(.alwaysOriginal)
        moreButton.setImage(moreImg, for: .normal)
        moreButton.contentMode = .scaleAspectFit
        moreButton.setTitle("", for: .normal)
    }
    
    func setupData() {
        if let selectedUser = self.selectedUser {
            fullNameLabel.text = selectedUser.firstName + " " + selectedUser.lastName
            aboutTextView.text = selectedUser.about
            emailLabel.text = selectedUser.email
            twitterUsernameLabel.text = selectedUser.twitterHandle
            instagramUsernameLabel.text = selectedUser.instagramHandle
        }
    }
    
    func setupDummyData() {
        fullNameLabel.text = "Sunchit Anand"
        aboutTextView.text = "SWE at Oracle, Bay Area. Deep into skiing, chess and space. Looking to connect with PMs and professionals working on autonomous vehicles."
        emailLabel.text = "sunchit.anand@gmail.com"
        twitterUsernameLabel.text = "@sunchitanand"
        instagramUsernameLabel.text = "@sunchitanand"
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
