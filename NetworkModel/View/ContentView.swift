//
//  ContentView.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @ObservedObject private var viewModel: ViewModel = ViewModel<Character>()
    @State var isPresented: Bool = false
    @State var isHidden: Bool = true
    @State var searchText: String = ""
    let gridItems: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()),]
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.models) { model in
                        CharacterCardView(
                            imageURL: model.image,
                            id: model.id,
                            name: model.name
                        )
                    }
                }
            }
        }
        .navigationTitle("Rick & Morty Characters")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, placement: .automatic)
        .onAppear {
            viewModel.requestTotalCount()
        }
    }
}

#Preview {
    ContentView()
}
