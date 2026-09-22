//
//  GameSummary.swift
//  stanford_cs193
//
//  Created by Matvii Ulytskyi on 21.09.2026.
//

import SwiftUI

struct GameSummary: View {
    // MARK: Data In
    let game: CodeBreaker
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.name).font(.title)
            PegChooser(choices: game.pegChoices)
                .frame(maxHeight: 50)
            Text("^[\(game.attempts.count) attempt](inflect: true)")
        }
    }
}

//#Preview {
//    GameSummary()
//}
