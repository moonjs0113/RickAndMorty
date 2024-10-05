//
//  Int+Extention.swift
//  SOOP_Assignment
//
//  Created by Moon Jongseek on 4/23/24.
//

import Foundation

extension Int {
    var isZero: Bool {
        self == 0
    }
    
    var MB: Int {
        self * 1024 * 1024
    }
}
