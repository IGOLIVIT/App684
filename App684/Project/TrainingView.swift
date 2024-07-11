//
//  TrainingView.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI

struct TrainingView: View {
    
    @StateObject var viewModel = TrainingViewModel()
    
    var body: some View {
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Training")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                HStack {
                    
                    Text("You have added")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold))
                    
                    Text("\(viewModel.workouts.count)")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 14, weight: .bold))
                        .padding(4)
                        .background(Color.white)
                    
                    Text("workouts")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("black")))
                .padding(.horizontal)
                
                Button(action: {
                    
                    viewModel.isAddWorkout = true
                    
                }, label: {
                    
                    HStack {
                        
                        Image(systemName: "plus")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 16, weight: .medium))
                        
                        Text("Add a workout")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 15, weight: .medium))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color("primary")))
                    .padding([.horizontal, .bottom])
                })
                
                if viewModel.workouts.isEmpty {
                    
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
                            
                            ForEach(viewModel.workouts, id: \.self) { index in
                            
                                HStack {
                                    
                                    Image(systemName: "camera")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .frame(width: 100, height: 90)
                                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.3)))
                                    
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        
                                        Text(index.group_name ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 19, weight: .bold))
                                        
                                        HStack(content: {
                                            
                                            Text(index.date ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                            
                                            Spacer()
                                            
                                  
                                        })
                                        
                                        Text(index.title ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 16, weight: .semibold))
                                        
                                        
                                    })
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
        .sheet(isPresented: $viewModel.isAddWorkout, content: {
            
            TrainingAdd(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchWorkouts()
        }
    }
}

#Preview {
    TrainingView()
}
