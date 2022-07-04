//
//  ContentView.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import SwiftUI

struct ContentView: View {
    @State private var character: Character?
    @State private var id: Int = 1
    @State private var maxID: Int = 0
    
    var body: some View {
        VStack {
            if let character = self.character {
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
                Task {
                    let info = try await NetworkService.ModelRoute.requestTotalCount(to: Character.self)
                    self.maxID = info.info.count
                }
            }
            
            Text("Total Count: \(maxID)")
            
            Button("Request Character ID: 1") {
                Task {
                    self.character = try await NetworkService.ModelRoute.requestObject(as: Character.self, id: 1)
                }
            }
            .disabled(self.maxID > 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
