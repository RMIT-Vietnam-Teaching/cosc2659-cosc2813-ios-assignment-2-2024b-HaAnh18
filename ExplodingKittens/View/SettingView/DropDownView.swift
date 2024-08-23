//
//  DropDownView.swift
//  ExplodingKittens
//
//  Created by Nana on 23/8/24.
//

import SwiftUI

struct DropDownView: View {
    @State private var isExpanded = false

    @Binding var selection: String
    var options: [String]
    
    var body: some View {
        VStack {
            HStack {
                Text(selection)
                    .font(Font.custom("Quicksand-Regular", size: 20))
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(isExpanded ? -180 : 0))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isExpanded.toggle()
                        }
                    }
                    
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            
            
            if isExpanded {
                VStack {
                    ForEach(options, id: \.self) { option in
                        HStack {
                            Text(option)
                                .foregroundStyle(selection == option ? Color("red") : .gray)
                                .font(Font.custom("Quicksand-Regular", size: 20))
                            
                            Spacer()
                        }
                        .frame(height: 40)
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                isExpanded.toggle()
                                selection = option
                            }
                        }
                    }
                }
//                    .transition(.move(edge: .bottom))
            }
            
        }
        
//            .background(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
        .frame(width: 200)
    }
}

#Preview {
    DropDownView(selection: .constant("Option 1"), options: ["Option 1", "Option 2", "Option 3"])
}
