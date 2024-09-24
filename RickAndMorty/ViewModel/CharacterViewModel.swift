//
//  CharacterViewModel.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

final class CharacterViewModel: ObservableObject, ViewModel {
    @Published var character: Character?
    @Published var id: Int = 0
    @Published var totalCount: Int = 0
    
    func requestTotalCount() {
        Task {
            let info = try await NetworkService.ModelRoute.requestTotalCount(to: Character.self)
            self.totalCount = info.info.count
            self.id = 1
        }
    }
    
    func requestInfo() {
        Task {
            self.character = try await NetworkService.ModelRoute.requestObject(as: Character.self, id: self.id)
        }
    }
}
