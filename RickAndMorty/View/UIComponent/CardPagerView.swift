//
//  CardPagerView.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 10/3/24.
//

import SwiftUI

struct CardPagerView<D: ModelProtocol, Content: View>: View {
    var data: [D]
    let content: (D) -> Content

    init(data: [D], @ViewBuilder content: @escaping (D) -> Content) {
        self.data = data
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center) {
                    ForEach(data, id: \.self.id) { data in
                        HStack {
                            Spacer(minLength: proxy.size.width * 0.05)
                            content(data).clipShape(
                                RoundedRectangle(
                                    cornerRadius: 20,
                                    style: .continuous
                                )
                            )
                            .frame(width: proxy.size.width * 0.9)
                            Spacer(minLength: proxy.size.width * 0.05)
                        }
                    }
                }
            }
            .scrollIndicators(.never)
            .scrollTargetLayout()
        }
        .scrollClipDisabled()
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    CardPagerView(
        data: [Character.sampleData],
        content: { data in
            Text("\(data.name)")
        }
    )
        .preferredColorScheme(.dark)
}
