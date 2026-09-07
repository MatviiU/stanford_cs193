//
//  ContentView.swift
//  stanford_cs193
//
//  Created by Matvii Ulytskyi on 07.09.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            pegs(colors: [.red, .green, .blue, .yellow])
            pegs(colors: [.red, .blue, .blue, .red])
            pegs(colors: [.red, .green, .green, .red])
        }.padding()
    }
    
    func pegs(colors: Array<Color>) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1 ,contentMode: .fit,)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: [.exact, .inexact, .exact, .nomatch])
        }
    }
}

#Preview {
    ContentView()
}
