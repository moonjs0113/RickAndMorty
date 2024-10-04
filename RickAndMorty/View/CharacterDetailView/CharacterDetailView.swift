//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 9/26/24.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    init(data: Character) {
        self.viewModel = CharacterDetailViewModel(model: data)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                
                ZStack {
                    HStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Name")
                                Text("\(viewModel.model.name) MMMMMMMM")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            }
                            
                            Text("Gender: \(viewModel.model.gender)")
                            Text("Status: \(viewModel.model.status)")
                            Text("Species: \(viewModel.model.species)")
                            Text("Type: \(viewModel.model.type)")
                            VStack(alignment: .leading) {
                                Text("Episode")
                                    .font(.title3)
                                    CardPagerView(
                                        data: viewModel.episode
                                    ) { episode  in
                                        VStack {
                                            Text("\(episode.episode ?? "")")
                                                .font(.subheadline)
                                            Text("\(episode.name)")
                                            Text("\(episode.air_date ?? "")")
                                            Spacer()
                                        }
                                        .onAppear {
                                            print(episode)
                                        }
                                    }
                                    .frame(height: 200)
                            }
                            .padding(.top, 10)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    VStack {
                        HStack {
                            Spacer()
                            Text("ID: \(viewModel.model.id)")
                                .font(.title2)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            BackButtonView {
                
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}

#Preview {
    CharacterDetailView(data: Character.sampleData)
}
