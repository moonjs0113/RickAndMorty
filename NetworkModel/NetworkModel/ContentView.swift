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
            if maxID > 0 {
                Button("Get Info") {
                    NetworkService.CharacterRoute.searchBy(id: self.id) { character, error in
                        if let error = error {
                            debugPrint(error)
                            return
                        }
                        
                        guard let character = character else {
                            return
                        }
                        self.character = character
                        print(self.character)
                    }
                }
                Picker("Character ID", selection: self.$id){
                    ForEach(1...self.maxID, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.wheel)
            } else {
                Text("load Data...")
                ProgressView("")
                    .progressViewStyle(.circular)
                    .onAppear {
                        NetworkService.CharacterRoute.getCharacterCount {
                            info, error in
                            if let error = error {
                                debugPrint(error)
                                return
                            }
                            
                            guard let info = info else {
                                return
                            }
                            self.maxID = info.count
                        }
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
