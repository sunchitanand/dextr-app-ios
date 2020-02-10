//
//  AuthenticationViewController.swift
//  Dexter
//
//  Created by Sunchit Anand on 12/15/19.
//  Copyright © 2019 Sunchit Anand. All rights reserved.
//

import UIKit
import CoreData

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    // Style the views
    func setupElements() {
        Styles.styleFilledButton(signUpButton)
        Styles.styleHollowButton(signInButton)
    }

}
