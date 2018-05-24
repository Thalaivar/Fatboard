//
//  ViewController.swift
//  Fatboard
//
//  Created by Dhruv Laad on 16/05/18.
//  Copyright © 2018 Dhruv Laad. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func speedSliderButton(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 6.0, options: .curveEaseOut, animations: {
            
            sender.transform = CGAffineTransform.identity
            self.performSegue(withIdentifier: "go_to_speed_slider", sender: sender)
            
        }, completion: nil)
    }
    
    @IBAction func settingsButton(_ sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.1, initialSpringVelocity: 6.0, options: .curveEaseOut, animations: {
            
            sender.transform = CGAffineTransform.identity
            self.performSegue(withIdentifier: "go_to_settings", sender: sender)
            
        }, completion: nil)
        
    }
    
    
}

