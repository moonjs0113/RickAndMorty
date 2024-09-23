//
//  DataType.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 9/23/24.
//

import UIKit

enum DataType: CaseIterable {
    case character, location, episode
    
    var defaultImageName: String {
        "\(self)Image"
    }
    
    public var title: String {
        var title = "\(self)"
        return title.removeFirst().uppercased() + title
    }
    
    public var image: UIImage {
        print(defaultImageName)
        return UIImage(named: defaultImageName)!
    }
}
