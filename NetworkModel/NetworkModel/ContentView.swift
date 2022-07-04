//
//  ContentView.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @ObservedObject private var viewModel: CharacterViewModel = CharacterViewModel()
    
    // MARK: Body
    var body: some View {
        VStack {
            if let character = self.viewModel.character {
                AsyncImage(url: character.imageURL) { image in
                    image
                } placeholder: {
                    ProgressView()
                }
                Text("\(character.id)")
                Text("\(character.name)")
                Text("\(character.status)")
                Text("\(character.url)")
                Text("\(character.species)")
                Text("\(character.type)")
                Text("\(character.gender)")
            }
            
            Divider()
            
            Button("Request Character Total Count") {
                self.viewModel.requestTotalCount()
            }
            
            Text("Total Count: \(self.viewModel.totalCount)")
            if self.viewModel.totalCount > 0 {
                Picker("Character ID", selection: self.$viewModel.id){
                    ForEach(1...self.viewModel.totalCount, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
            }
            
            Button("Request Character ID: \(self.viewModel.id)") {
                self.viewModel.requestInfo()
            }
            .disabled(self.viewModel.totalCount < 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
