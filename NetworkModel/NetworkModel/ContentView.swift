//
//  ContentView.swift
//  NetworkModel
//
//  Created by Moon Jongseek on 2022/07/01.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @ObservedObject private var viewModel: ViewModel = ViewModel<Character>()
    
    // MARK: Body
    var body: some View {
        VStack {
            if let model = self.viewModel.model {
                Text("\(model.id)")
                Text("\(model.name)")
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
