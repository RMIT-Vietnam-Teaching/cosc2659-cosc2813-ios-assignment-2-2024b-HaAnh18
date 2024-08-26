//
//  DropDownView.swift
//  ExplodingKittens
//
//  Created by Nana on 23/8/24.
//

import SwiftUI

struct DropDownView: View {
    @State private var isExpanded = false
    @EnvironmentObject var localizationManager: LocalizationManager

    @Binding var selection: String
    var options: [String]
    
    var body: some View {
        VStack {
            if !isExpanded {
                HStack {
                    Text(localizationManager.localizedString(for: selection))
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
            }
            
            
            if isExpanded {
                VStack {
                    ForEach(options, id: \.self) { option in
                        HStack {
                            Text(localizationManager.localizedString(for: option))
                                .foregroundStyle(selection == option ? .black : .gray)
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
        .onChange(of: localizationManager.currentLanguage) { _ in
            // Re-render view when language changes
            selection = selection // Re-trigger the binding
        }
    }
}

#Preview {
//    DropDownView(selection: .constant("Option 1"), options: ["Option 1", "Option 2", "Option 3"])
    MenuView()
}
