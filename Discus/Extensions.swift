//
//  Extensions.swift
//  Discus
//
//  Created by Tim Ng on 4/19/19.
//  Copyright © 2019 Tim Ng. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let Divisor: CGFloat = 255
    
    static let bgGray = UIColor.rgb(red: 241, green: 241, blue: 241)
    static let inFocusBlue = UIColor.rgb(red: 17, green: 154, blue: 237)
    static let outOfFocusBlue = UIColor.rgb(red: 149, green: 204, blue: 244)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / Divisor, green: green / Divisor, blue: blue / Divisor, alpha: alpha)
    }
}

