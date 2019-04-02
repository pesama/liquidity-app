//
//  LandingViewController.swift
//  Finances
//
//  Created by Margareto, Pelayo on 30/03/2019.
//  Copyright © 2019 Smarla. All rights reserved.
//

import Foundation
import UIKit
import AWSAuthCore
import AWSAuthUI

class LandingViewController: UIViewController {
    
    @IBOutlet weak var loginStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var userNotificationTypes : UIUserNotificationType
        userNotificationTypes = [.alert , .badge , .sound]
        let notificationSettings = UIUserNotificationSettings.init(types: userNotificationTypes, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        UIApplication.shared.registerForRemoteNotifications()
        
        self.loginStatus.text = "Login to continue"
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            AWSAuthUIViewController
                .presentViewController(with: self.navigationController!,
                                       configuration: nil,
                                       completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                                        if error != nil {
                                            print("Error occurred: \(String(describing: error))")
                                        } else {
                                            self.loginStatus.text = "Successsfully logged in"
                                            self.launchApp()
                                        }
                })
        } else {
            self.loginStatus.text = "Successsfully logged in"
            self.launchApp()
        }
    }
    
    func launchApp () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainController")
        self.present(controller, animated: true, completion: nil)
    }
}
