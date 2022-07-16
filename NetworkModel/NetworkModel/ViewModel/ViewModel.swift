//
//  ViewModel.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

final class ViewModel<M: Codable & Model>: ObservableObject, ViewModelProtocol {
    @Published var model: M?
    @Published var id: Int = 0
    @Published var totalCount: Int = 0
    
    func requestTotalCount() {
        DispatchQueue.global().async { [weak self] in
            NetworkService.requestTotalObject(as: M.self) { info, error in
                guard let info = info, error == nil else {
                    if let error = error {
                        debugPrint(error)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self?.totalCount = info.info.count
                    self?.id = 1
                }
            }
        }
    }
    
    func requestInfo() {
        DispatchQueue.global().async { [weak self] in
            NetworkService.requestSingleObject(as: M.self, id: self?.id ?? 0) { model, error in
                guard let model = model, error == nil else {
                    if let error = error {
                        debugPrint(error)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self?.model = model
                }
            }
        }
    }
    
    func requestMultipleInfo() {
        DispatchQueue.global().async {
            NetworkService.requestMultipleObjects(as: M.self, id: [1,4,5]) { model, error in
                guard let model = model, error == nil else {
                    if let error = error {
                        debugPrint(error)
                    }
                    return
                }
                print(model)
            }
        }
    }
    
    func requestFilterInfo(filter: [M.FilterType]) {
        DispatchQueue.global().async {
            NetworkService.requestObject(as: M.self, filterBy: filter) { info, error in
                guard let info = info, error == nil else {
                    if let error = error {
                        debugPrint(error)
                    }
                    return
                }
                if let results = info.results {
                    print(results.count)
                }
            }
        }
    }
}
