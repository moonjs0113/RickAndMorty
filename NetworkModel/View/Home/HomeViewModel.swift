//
//  HomeViewModel.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 9/23/24.
//

import Foundation

final class HomeViewModel<M: ModelProtocol>: ObservableObject {
    private var totalCount: Int = 0
    private var randomID: [Int] = []
    @Published var models: [M] = []
    
    public func fetchTotalCount() {
        if totalCount == 0 {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                NetworkService.requestTotalObject(as: M.self, pageURL: nil) { info, error in
                    guard let info = info, error == nil else {
                        if let error = error {
                            debugPrint(error)
                        }
                        return
                    }
                    self.totalCount = info.info.count
                    self.fetchRandomCharaterData()
                }
            }
        }
        else { fetchRandomCharaterData() }
    }
    
    private func fetchRandomCharaterData() {
        let randomID = (0..<6).compactMap { _ in (1...self.totalCount).randomElement() }
        NetworkService.requestMultipleObjects(as: M.self, id: randomID) {model, error in
            guard let model = model, error == nil else {
                if let error = error {
                    debugPrint(error)
                }
                return
            }
            DispatchQueue.main.async {  [weak self] in
                guard let self = self else { return }
                self.models = model
            }
        }
    }
}
