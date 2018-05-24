//
//  SexySlider.swift
//  Fatboard
//
//  Created by Dhruv Laad on 17/05/18.
//  Copyright © 2018 Dhruv Laad. All rights reserved.
//

import UIKit

@IBDesignable
class SexySlider: UISlider {
    
    @IBInspectable var thumbImage: UIImage? {
        didSet {
            self.setThumbImage(thumbImage, for: .normal)
            self.setThumbImage(#imageLiteral(resourceName: "sliderThumbMagnified.png"), for: .highlighted)
        }
    }
}
