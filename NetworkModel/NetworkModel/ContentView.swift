//
//  ContentView.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import SwiftUI

struct ContentView: View {
    @State private var character: Character?
    
    var body: some View {
        VStack {
            if let character = self.character {
                Text("\(character.name)")
                    .padding()
            }
            Button("Get Info") {
                RickAndMortyService.CharacterRoute.searchBy(id: 1) { character, error in
                    guard error != nil else {
                        debugPrint(error as Any)
                        return
                    }
                    guard let character = character else {
                        return
                    }
                    self.character = character
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
