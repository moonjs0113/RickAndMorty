//
//  HomeView.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 2022/07/01.
//

import SwiftUI

struct HomeView: View {
    // MARK: Properties
    @ObservedObject private var viewModel = HomeViewModel<Character>()
    // MARK: Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    Image("titleImage", bundle: .main)
                        .resizable()
                        .scaledToFit()
                    Divider()
                    HStack(spacing: 20) {
                        ForEach(DataType.allCases, id: \.self) { type in
                            Button {
                                
                            } label: {
                                VStack {
                                    Image(uiImage: type.defaultImage)
                                        .resizable()
                                        .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 15)
                                        )
                                    Text(type.title)
                                        .foregroundStyle(Color.text)
                                }
                            }
                        }
                    }
                    Divider()
                    HStack {
                        Text("Random Characters")
                            .bold()
                        Spacer()
                    }
                    LazyVGrid(
                        columns: [GridItem(.flexible()), GridItem(.flexible())],
                        spacing: 10
                    ) {
                        ForEach(viewModel.models) { model in
                            CharacterCardView(
                                imageURL: model.image,
                                id: model.id,
                                name: model.name
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Rick & Morty")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await viewModel.fetchTotalCount()
            }
            
        }
    }
}

#Preview {
    HomeView()
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
