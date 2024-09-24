//
//  CharacterCardView.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 9/22/24.
//

import SwiftUI

struct CharacterCardView: View {
    var imageURL: String
    var id: Int
    var name: String
    @State var image: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 5,
                            topTrailingRadius: 5
                        )
                    )
                HStack {
                    VStack(alignment: .leading) {
                        Text("ID \(id)")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.cardText)
                        Text("\(name)")
                            .font(.footnote)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .foregroundStyle(Color.cardText)
                    }
                    Spacer()
                }
                .padding(10)
                .background {
                    Color.characterCardBackground
                        .clipShape(
                            .rect(
                                bottomLeadingRadius: 5,
                                bottomTrailingRadius: 5
                            )
                        )
                }
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 2)
        }

        .onAppear {
            NetworkService.requestImageData(from: imageURL) { (data, error) in
                guard let data = data else {
                    //                    print(error)
                    self.image = UIImage.characterImage
                    return
                }
                self.image = UIImage(data: data)
            }
        }
    }
}

#Preview {
    CharacterCardView(
        imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        id: 1,
        name: "Rick Sanchez"
    )
    .preferredColorScheme(.none)
}

#Preview {
    CharacterCardView(
        imageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        id: 1,
        name: "Rick Sanchez"
    )
    .preferredColorScheme(.dark)
}
