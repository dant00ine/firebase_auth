//
//  ViewController.swift
//  firebase-auth
//
//  Created by Daniel Thompson on 7/19/17.
//  Copyright © 2017 Daniel Thompson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI

class ViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        
        handle = Auth.auth().addStateDidChangeListener({ ( auth, user ) in
            
            if Auth.auth().currentUser == nil {
                let authViewController = authUI?.authViewController()
                self.present(authViewController!, animated: true, completion: nil)
            }
            
        })
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        print("did sign in with user \(String(describing: user)) and errors? \(String(describing: error))")
    }
}

