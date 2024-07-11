//
//  GroupAdd.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI

struct GroupAdd: View {
    
    @StateObject var viewModel: GroupsViewModel
    @Environment(\.presentationMode) var router
    
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
                        
                        viewModel.addGroup()
                        viewModel.fetchGroups()
                        
                        router.wrappedValue.dismiss()
                        
                        viewModel.group_title = ""
                        viewModel.group_text = ""
                        viewModel.group_students = []
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.green)
                            .font(.system(size: 15, weight: .regular))
                    })
                    .opacity(viewModel.group_title.isEmpty || viewModel.group_text.isEmpty || viewModel.group_students.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.group_title.isEmpty || viewModel.group_text.isEmpty || viewModel.group_students.isEmpty ? true : false)
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
                                    .opacity(viewModel.group_title.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.group_title)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.4)))
                        })
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Description")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Text")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.group_text.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.group_text)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.4)))
                        })
                        
                        if !viewModel.group_title.isEmpty {
                            
                            VStack {
                                
                                HStack {
                                    
                                    Text("Students")
                                        .foregroundColor(.black)
                                        .font(.system(size: 19, weight: .semibold))
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        withAnimation(.spring()) {
                                            
                                            viewModel.isAddParticipant = true
                                        }
                                        
                                    }, label: {
                                        
                                        Image(systemName: "plus")
                                            .foregroundColor(.black)
                                            .font(.system(size: 17, weight: .medium))
                                    })
                                }
                                
                                ForEach(viewModel.group_students, id: \.self) { index in
                                
                                    HStack {
                                        
                                        Image(systemName: "camera")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 13, weight: .regular))
                                            .frame(width: 50, height: 50)
                                            .background(Circle().fill(.gray.opacity(0.3)))
                                        
                                        VStack(alignment: .leading, spacing: 4, content: {
                                            
                                            Text(index.name ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 15, weight: .medium))
                                            
                                            Text("\(index.age) years old")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                        })
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.3)))
                                }
                            }
                            
                            
                        }
                    }
                    .padding()
                }
            }
            .onChange(of: viewModel.group_title) { ina in
                
                viewModel.fetchParticipants()
            }
            .onAppear {
                
                viewModel.fetchParticipants()
            }
            .overlay(
            
                ZStack {
                    
                    Color.black.opacity(viewModel.isAddParticipant ? 0.5 : 0)
                        .ignoresSafeArea()
                        .onTapGesture {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddParticipant = false
                            }
                        }
                    
                    VStack(spacing: 25) {
                        
                        Text("Participants")
                            .foregroundColor(.black)
                            .font(.system(size: 19, weight: .semibold))
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Name")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Text")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.student_name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.student_name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.4)))
                        })
                        
                        VStack(alignment: .leading, spacing: 8, content: {
                            
                            Text("Age")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Text")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.student_age.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.student_age)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).stroke(.gray.opacity(0.4)))
                        })
                        
                        HStack {
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddParticipant = false
                                }
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Text("Cancel")
                                        .foregroundColor(Color("primary"))
                                        .font(.system(size: 15, weight: .medium))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color("primary")))
                            })
                            
                            Button(action: {
                                
                                viewModel.addParticipant()
                                viewModel.fetchParticipants()
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddParticipant = false
                                }
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Text("Save")
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .medium))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                            })
                            .opacity(viewModel.student_name.isEmpty || viewModel.student_age.isEmpty ? 0.5 : 1)
                            .disabled(viewModel.student_name.isEmpty || viewModel.student_age.isEmpty ? true : false)
                        }
                        .padding([.bottom])
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    .padding()
                    .offset(y: viewModel.isAddParticipant ? 0 : UIScreen.main.bounds.height)
                }
            )
        }
    }
}

#Preview {
    GroupAdd(viewModel: GroupsViewModel())
}
