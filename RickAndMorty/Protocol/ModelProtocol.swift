//
//  ModelProtocol.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 2022/07/16.
//

import Foundation

typealias ModelProtocol = Codable & Model & Identifiable

protocol Model {
    associatedtype FilterType where FilterType: FilterProtocol
    static var dataType: DataType { get }
    var id: Int { get }
    var name: String { get }
}
