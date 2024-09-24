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
                                    Image(uiImage: type.image)
                                        .resizable()
                                        .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 10000)
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
            viewModel.fetchTotalCount()
        }
    }
}

//struct ContentOffsetKey: PreferenceKey {
//    typealias Value = CGFloat
//    static var defaultValue = CGFloat.zero
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value += nextValue()
//    }
//}
//
//struct ObservableScrollView<Content: View>: View {
//    let content: Content
//    @Binding var contentOffset: CGFloat
//
//    init(contentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
//        self._contentOffset = contentOffset
//        self.content = content()
//    }
//
//    var body: some View {
//        ScrollView {
//            content
//                .background {
//                    GeometryReader { geometry in
//                        Color.clear
//                            .preference(key: ContentOffsetKey.self, value: geometry.frame(in: .named("scrollView")).minY)
//                    }
//                }
//        }
//        .coordinateSpace(name: "scrollView")
//        .onPreferenceChange(ContentOffsetKey.self) { value in
//            self.contentOffset = value
//        }
//    }
//}

#Preview {
    HomeView()
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
