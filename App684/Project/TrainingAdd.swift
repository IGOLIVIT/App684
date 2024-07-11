//
//  TrainingAdd.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI

struct TrainingAdd: View {
    
    @StateObject var viewModel: TrainingViewModel
    @Environment(\.presentationMode) var router
    
    @StateObject var groupModel = GroupsViewModel()
    
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                            
                            Text("Back")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.addWorkout()
                        viewModel.fetchWorkouts()
                        
                        router.wrappedValue.dismiss()
                        
                        viewModel.title = ""
                        viewModel.date = ""
                        viewModel.note = ""
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.green)
                            .font(.system(size: 15, weight: .regular))
                    })
                    .opacity(viewModel.title.isEmpty || viewModel.date.isEmpty || viewModel.note.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.title.isEmpty || viewModel.date.isEmpty || viewModel.note.isEmpty ? true : false)
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Title")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Text")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.title.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.title)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.4)))
                        })
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Date")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Text")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.date.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.date)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.4)))
                        })
                        
                        Text("Groups")
                            .foregroundColor(.black)
                            .font(.system(size: 21, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {
                                
                                ForEach(groupModel.groups, id: \.self) { index in
                                    
                                    Button(action: {
                                        
                                        viewModel.group_name = index.title ?? ""
                                        
                                    }, label: {
                                        
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
                                            }
                                        }
                                        .padding()
                                        .frame(width: 200)
                                        .background(RoundedRectangle(cornerRadius: 15).stroke(viewModel.group_name == index.title ?? "" ? Color("primary") : .gray.opacity(0.3)))
                                    })
                                }
                            }
                            .padding(1)
                        }
                        
                        Text("Notes")
                            .foregroundColor(.black)
                            .font(.system(size: 21, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Note")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Text")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.note.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.note)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.4)))
                        })
                    }
                    .padding()
                }
            }
            .onAppear {
                
                groupModel.fetchGroups()
            }
        }
    }
}

#Preview {
    TrainingAdd(viewModel: TrainingViewModel())
}
