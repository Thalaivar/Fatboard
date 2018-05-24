//
//  SpeedViewController.swift
//  Fatboard
//
//  Created by Dhruv Laad on 17/05/18.
//  Copyright © 2018 Dhruv Laad. All rights reserved.
//

import UIKit
import Socket

extension String {
    var data: Data { return Data(utf8) }
}

extension Numeric {
    var data: Data {
        var source = self
        // This will return 1 byte for 8-bit, 2 bytes for 16-bit, 4 bytes for 32-bit and 8 bytes for 64-bit binary integers. For floating point types it will return 4 bytes for single-precision, 8 bytes for double-precision and 16 bytes for extended precision.
        return Data(bytes: &source, count: MemoryLayout<Self>.size)
    }
}

class Board {
    var speedValue:Int = 1000
    var status = 0

    let port = Int32(345)
    let address = "192.168.4.1"
    
    var connectMessage = Int16(-45)
    
    var boardWiFi: Socket? = nil
    
    init(){
        self.boardWiFi = try! Socket.create(family: Socket.ProtocolFamily.inet, type: Socket.SocketType.stream, proto: Socket.SocketProtocol.tcp)
    }
    
    func connectToBoard(){
        try! self.boardWiFi?.connect(to: self.address, port: self.port)
        self.status = 1
    }
    
    func checkConnection(){
        if self.status == 1 {
                try! self.boardWiFi?.write(from: self.connectMessage.data)
        }
    }
}

var board = Board()

class SpeedViewController: UIViewController {

    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedLevel: UILabel!
    
    var thumbImageMagnified: UIImage = UIImage(named: "sliderIcon")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        speedSlider.transform = CGAffineTransform(rotationAngle: -.pi/2)
        speedLevel.text = String(Int(speedSlider.value))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeValue(_ sender: UISlider) {
        speedLevel.text = String(Int(speedSlider.value))
    }
   
    
    @IBAction func goBackHome(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "go_to_speed_slider", sender: sender)
    }
    
}

