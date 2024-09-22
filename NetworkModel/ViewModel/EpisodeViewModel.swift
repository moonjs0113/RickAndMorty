//
//  EpisodeViewModel.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

final class EpisodeViewModel: ObservableObject, ViewModel {
    @Published var episode: Episode?
    @Published var id: Int = 0
    @Published var totalCount: Int = 0
    
    func requestTotalCount() {
        Task {
            let info = try await NetworkService.ModelRoute.requestTotalCount(to: Episode.self)
            self.totalCount = info.info.count
            self.id = 1
        }
    }
    
    func requestInfo() {
        Task {
            self.episode = try await NetworkService.ModelRoute.requestObject(as: Episode.self, id: self.id)
        }
    }
}
