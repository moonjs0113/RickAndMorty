//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 9/23/24.
//

import Foundation

final class HomeViewModel<M: ModelProtocol>: ObservableObject {
    private var totalCount: Int = 0
    private var randomID: [Int] = []
    @Published var models: [M] = []
    
    public func fetchTotalCount() async {
        do {
            if totalCount == 0 {
                let data: ModelList<M> = try await NetworkService.getObjectPage()
                totalCount = data.info.count
            }
            try await fetchRandomCharaterData()
        } catch(let e) {
            print(e)
        }
    }
    
    private func fetchRandomCharaterData() async throws {
        let randomID = (0..<6).compactMap { _ in (1...self.totalCount).randomElement() }
        let data: [M] = try await NetworkService.getMultipleObjects(fromIDs: randomID)
        Task(priority: .high) { [weak self] in
            self?.models = data
        }
    }
}
