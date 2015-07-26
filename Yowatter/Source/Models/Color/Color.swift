//
//  Color.swift
//  Yowatter
//
//  Created by t-matsumura on 7/26/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit

struct Color {
    
    static func colorWithRGB256(red: NSInteger, green: NSInteger, blue: NSInteger) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static func darkBlue() -> UIColor {
        return colorWithRGB256(0, green: 38, blue: 53)
    }
    
    static func blue() -> UIColor {
        return colorWithRGB256(1, green: 52, blue: 64)
    }
    
    static func red() -> UIColor {
        return colorWithRGB256(171, green: 26, blue: 37)
    }
    
    static func orange() -> UIColor {
        return colorWithRGB256(217, green: 121, blue: 37)
    }
    
    static func cream() -> UIColor {
        return colorWithRGB256(239, green: 231, blue: 190)
    }
    
    static func apply() {
        UINavigationBar.appearance().barTintColor = Color.darkBlue()
        UINavigationBar.appearance().tintColor = Color.orange()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Color.cream()]
        
        UITableView.appearance().backgroundColor = Color.cream()
        UITableViewCell.appearance().backgroundColor = Color.cream()
    }
}
