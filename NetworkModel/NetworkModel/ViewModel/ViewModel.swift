//
//  ViewModel.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

final class ViewModel<M: Codable>: ObservableObject, ViewModelProtocol {
    @Published var model: M?
    @Published var id: Int = 0
    @Published var totalCount: Int = 0
    
    func requestTotalCount() {
        DispatchQueue.main.async { [weak self] in
            NetworkService.ModelRoute.requestTotalCount(to: M.self) { info, error in
                guard let info = info, error == nil else {
                    if let error = error {
                        debugPrint(error)
                    }
                    return
                }
                self?.totalCount = info.info.count
                self?.id = 1
            }
        }
    }
    
    func requestInfo() {
        DispatchQueue.main.async { [weak self] in
            NetworkService.ModelRoute.requestObject(as: M.self, id: self?.id ?? 0) { model, error in
                guard let model = model, error == nil else {
                    if let error = error {
                        debugPrint(error)
                    }
                    return
                }
                self?.model = model
            }
        }
    }
}
