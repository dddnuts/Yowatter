//
//  TimeViewHelper.swift
//  Yowatter
//
//  Created by t-matsumura on 8/3/15.
//  Copyright (c) 2015 dddnuts. All rights reserved.
//

import UIKit

class TimeViewHelper: NSObject {
    static func format(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.stringFromDate(date)
    }
}
