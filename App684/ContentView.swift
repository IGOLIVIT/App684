//
//  ContentView.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentTab: Tab = .Groups
    
    @State var isFetched: Bool = false
    
    @State var isBlock: Bool = true
    @State var isDead: Bool = false
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            if status {
                
                VStack(spacing: 0, content: {
                    
                    TabView(selection: $currentTab, content: {
                        
                        GroupsView()
                            .tag(Tab.Groups)
                        
                        TrainingView()
                            .tag(Tab.Training)
                        
                        SettingsView()
                            .tag(Tab.Settings)
                        
                    })
                    
                    TabBar(selectedTab: $currentTab)
                })
                .ignoresSafeArea(.all, edges: .bottom)
                
            } else {
                
                Reviewers_1()
            }
        }
    }
}

#Preview {
    ContentView()
}
