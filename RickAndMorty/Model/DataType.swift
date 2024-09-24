//
//  DataType.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 9/23/24.
//

import UIKit

enum DataType: CaseIterable {
    case character, location, episode
    
    public var toString: String {
        "\(self)"
    }
    
    public var defaultImageName: String {
        "\(toString)Image"
    }
    
    public var title: String {
        var title = "\(self)"
        return title.removeFirst().uppercased() + title
    }
    
    public var defaultImage: UIImage {
        return UIImage(named: defaultImageName)!
    }
}
