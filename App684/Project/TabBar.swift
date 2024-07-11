//
//  TabBar.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 8, content: {
                        
                        Image(index.rawValue)
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == index ? Color("primary") : Color.gray.opacity(0.4))
                            .frame(width: 15, height: 15)
//
//                        Text(index.rawValue)
//                            .foregroundColor(selectedTab == index ? Color("prim") : Color.gray.opacity(0.4))
//                            .font(.system(size: 8, weight: .regular))
                        
                    })
                    .frame(maxWidth: .infinity)
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.top, 14)
        .padding(.bottom, 48)
        .background(RoundedRectangle(cornerRadius: 0).fill(.white))
        .ignoresSafeArea()
    }
}

enum Tab: String, CaseIterable {
    
    case Groups = "Groups"
    
    case Training = "Training"

    case Settings = "Settings"
}

