//
//  BackButtonView.swift
//  RickAndMorty
//
//  Created by Moon Jongseek on 9/26/24.
//

import SwiftUI

struct BackButtonView: View {
    var dismiss: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss?()
                } label: {
                    ZStack {
                        Circle()
                            .fill(.white)
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundStyle(Color.black)
                    }
                }
                .frame(width: 50, height: 50)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    BackButtonView()
}
