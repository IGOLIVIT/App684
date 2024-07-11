//
//  GroupsView.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI

struct GroupsView: View {
    
    @StateObject var viewModel = GroupsViewModel()
    
    var body: some View {
       
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Groups")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                HStack {
                    
                    Image("ball")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 43, height: 43)
                    
                    Text("Training")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("black")))
                .padding([.horizontal, .bottom])
                
                Button(action: {
                    
                    viewModel.isAddGroup = true
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("Add a group")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 15, weight: .medium))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("primary")))
                    .padding([.horizontal, .bottom])
                })
                
                if viewModel.groups.isEmpty {
                    
                    VStack(alignment: .center, spacing: 15, content: {
                        
                        Image("ball")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 66, height: 66)
                        
                        Text("You haven't added any entries")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                    })
                    .padding()
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.groups, id: \.self) { index in
                                
                                VStack(spacing: 15) {
                                    
                                    Text(index.title ?? "")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .medium))
                                        .multilineTextAlignment(.center)
                                    
                                    Text(index.text ?? "")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                        .multilineTextAlignment(.center)
                                    
                                    HStack {
                                        
                                        ZStack {
                                            
                                            Image(systemName: "camera")
                                                .foregroundColor(.white)
                                                .font(.system(size: 13, weight: .regular))
                                                .frame(width: 34, height: 34)
                                                .background(Circle().fill(.gray.opacity(1)))
                                            
                                            Image(systemName: "camera")
                                                .foregroundColor(.white)
                                                .font(.system(size: 13, weight: .regular))
                                                .frame(width: 34, height: 34)
                                                .background(Circle().fill(.gray.opacity(1)))
                                                .offset(x: 10)
                                            
                                            Image(systemName: "camera")
                                                .foregroundColor(.white)
                                                .font(.system(size: 13, weight: .regular))
                                                .frame(width: 34, height: 34)
                                                .background(Circle().fill(.gray.opacity(1)))
                                                .offset(x: 20)
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                            viewModel.isDetail = true
                                            viewModel.selectedGroup = index
                                            
                                        }, label: {
                                            
                                            Text("Details")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14, weight: .medium))
                                                .frame(width: 80, height: 40)
                                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                                        })
                                    }
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.3)))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isAddGroup, content: {
            
            GroupAdd(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            if let index = viewModel.selectedGroup {
                
                GroupsDetail(index: index)
            }
        })
        .onAppear {
            
            viewModel.fetchGroups()
        }
    }
}

#Preview {
    GroupsView()
}
