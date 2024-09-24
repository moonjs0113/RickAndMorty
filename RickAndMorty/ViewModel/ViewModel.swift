//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 2022/07/04.
//

import Foundation

final class ViewModel<M: ModelProtocol>: ObservableObject, ViewModelProtocol {
    @Published var model: M?
    @Published var idText: String = ""
    @Published var totalCount: Int = 0
    
    var models: [M] = []
    var nextURLString: String?
    var isLoading: Bool = false
    
    func requestTotalCount() {
        isLoading = true
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            NetworkService.requestTotalObject(as: M.self, pageURL: self.nextURLString) { info, error in
                guard let info = info, error == nil else {
                    if let error = error {
                        debugPrint(error)
                    }
                    self.isLoading = false
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.totalCount = info.info.count
                    self.nextURLString = info.info.next
                    if let data = info.results {
                        self.models.append(contentsOf: data)
                    }
                    self.isLoading = false
                }
            }
        }
    }
    
    func requestInfo(ID: Int) {
        DispatchQueue.global().async { [weak self] in
            NetworkService.requestSingleObject(as: M.self, id: ID) { model, error in
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
