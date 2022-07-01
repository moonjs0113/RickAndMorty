//
//  RNMNetworkManagerError.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import Foundation

enum RNMNetworkError: Error {
    case invalidURL
    case nilResponse
    case managerIsNil
    case errorEncodingJson
    case errorDecodingJson
}
