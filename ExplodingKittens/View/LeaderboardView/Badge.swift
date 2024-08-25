//
//  Badge.swift
//  ExplodingKittens
//
//  Created by Nana on 25/8/24.
//

import SwiftUI

struct Badge: View {
    var color: String
    var content: String
    
    var body: some View {
        Text(content)
            .font(Font.custom("Quicksand-Bold", size: 10))
            .padding(5)
            .background {
                Capsule()
                    .foregroundColor(Color(color))
            }
    }
}

#Preview {
    Badge(color: "lightblue", content: "Win 5 Games")
}
