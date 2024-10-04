//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 10/3/24.
//

import SwiftUI

final class CharacterDetailViewModel: ObservableObject {
    let model: Character
    @Published var image: UIImage = Character.dataType.defaultImage
    @Published var episode: [Episode] = []
    
    public func fetchData() {
        fetchImage()
        fetchEpisode()
    }
    
    private func fetchImage() {
        Task {
            if let data = try? await NetworkService.imageLoad(from: model.image) {
                self.image = UIImage(data: data) ?? Character.dataType.defaultImage
            }
        }
    }
    
    private func fetchEpisode() {
        for episodeURL in model.episode {
            Task { [weak self] in
                if let episode: Episode = try? await NetworkService.getSingleObject(from: episodeURL) {
                    self?.episode = (self?.episode ?? []) + [episode]
                }
            }
        }
    }
    
    init(model: Character) {
        self.model = model
    }
}
