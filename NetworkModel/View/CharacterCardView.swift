//
//  CharacterCardView.swift
//  NetworkModel
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
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
    //            AsyncImage(url: .init(string: imageURL))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .overlay(
                        VStack {
                            HStack {
                                Text("ID \(id)")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(10)
                            .background {
                                Rectangle()
                                    .fill(.linearGradient(
                                        colors: [.clear, .white],
                                        startPoint: .bottom,
                                        endPoint: .top)
                                    )
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                Text("\(name)")
                                    .font(.footnote)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                            .padding(.bottom, 5)
                            .background {
                                Rectangle()
                                    .fill(.linearGradient(
                                        colors: [.clear, .white],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                    )
                            }
                        }
                        .clipped()
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                    )
            }
        }
        .padding(10)
        .onAppear {
            NetworkService.requestImageData(from: imageURL) { (data, error) in
                guard let data = data else {
                    print(error)
                    self.image = UIImage(named: "temp")
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
}
