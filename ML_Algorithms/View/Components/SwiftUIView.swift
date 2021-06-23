//
//  SwiftUIView.swift
//  ML_Algorithms
//
//  Created by Eduardo Oliveira on 17/06/21.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State private var selectedMethod = "KNN"
    var methods = ["KNN", "DMC"]
    
    var body: some View {
        VStack {
            Text("Escolha um método!")
                .font(.title2).bold()
            GeometryReader { geo in
                Picker(selection: $selectedMethod, label: Text("Escolha um método!")) {
                    ForEach(methods, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .frame(width: 300, height: 50)
            ZStack {
                if selectedMethod == "KNN" {
                    KNNView()
                } else if selectedMethod == "DMC" {
                    DMCView()
                }
            }
        }
    }
    
    
}

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}


