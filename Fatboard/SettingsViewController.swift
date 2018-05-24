//
//  SettingsViewController.swift
//  Fatboard
//
//  Created by Dhruv Laad on 16/05/18.
//  Copyright © 2018 Dhruv Laad. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration.CaptiveNetwork


class SettingsViewController: UIViewController {

    @IBOutlet weak var wifiStatusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func connectToWifi(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 6.0, options: .curveEaseOut, animations: {
            
            sender.transform = CGAffineTransform.identity
            
            if board.status == 0 {
                board.connectToBoard()
            }
            
            if board.status == 1{
                sender.setImage(#imageLiteral(resourceName: "connected.png"), for: .normal)
                board.checkConnection()
            }
            
            else{
                sender.setImage(#imageLiteral(resourceName: "disconnected.png"), for: .normal)
            }
            
        }, completion: nil)
    }
    
    
}
