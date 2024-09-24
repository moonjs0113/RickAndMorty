//
//  LocationViewModel.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation
final class LocationViewModel: ObservableObject, ViewModel {
    @Published var location: Location?
    @Published var id: Int = 0
    @Published var totalCount: Int = 0
    
    func requestTotalCount() {
        Task {
            let info = try await NetworkService.ModelRoute.requestTotalCount(to: Location.self)
            self.totalCount = info.info.count
            self.id = 1
        }
    }
    
    func requestInfo() {
        Task {
            self.location = try await NetworkService.ModelRoute.requestObject(as: Location.self, id: self.id)
        }
    }
}
