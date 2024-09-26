//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 9/26/24.
//

import SwiftUI

struct CharacterDetailView: View {
    let model: Character
    @State var image: UIImage?
    
    var body: some View {
        ZStack {
            ScrollView {
                Image(uiImage: image ?? Character.dataType.defaultImage)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                
                ZStack {
                    HStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Name")
                                Text("\(model.name) MMMMMMMM")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            }
                            
                            Text("Gender: \(model.gender)")
                            Text("Status: \(model.status)")
                            Text("Species: \(model.species)")
                            Text("Type: \(model.type)")
                        }
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    VStack {
                        HStack {
                            Spacer()
                            Text("ID: \(model.id)")
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
            Task {
                if let data = try? await NetworkService.imageLoad(from: model.image) {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}

#Preview {
    CharacterDetailView(model: Character.sampleData)
}
