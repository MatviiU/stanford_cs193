//
//  PegChooser.swift
//  stanford_cs193
//
//  Created by Matvii Ulytskyi on 14.09.2026.
//

import SwiftUI

struct PegChooser: View {
    // MARK: Data In
    let choices: Array<Peg>
    
    // MARK: Data Out Function
    let onChoose: ((Peg) -> Void)?
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(choices, id: \.self) { peg in
                Button {
                    onChoose?(peg)
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
}

//#Preview {
//    PegChooser()
//}
