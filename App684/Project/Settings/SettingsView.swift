//
//  SettingsView.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Button(action: {
                    
                    SKStoreReviewController.requestReview()
                    
                }, label: {
                    
                    Text("Rate Us")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.3)))
                        .padding([.horizontal, .top])
                })
                
                Button(action: {
                    
                    guard let url = URL(string: "https://www.termsfeed.com/live/fe01e37a-fc32-4f5f-b7fb-6d1fb40bf9b6") else { return }
                    
                    UIApplication.shared.open(url)
                    
                }, label: {
                    
                    HStack {
                        
                        Image("ball")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                        
                        Text("Usage Policy")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                        
                        Image("ball")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                    }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.3)))
                        .padding([.horizontal])
                })
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
