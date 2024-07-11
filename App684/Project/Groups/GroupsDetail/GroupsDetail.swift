//
//  GroupsDetail.swift
//  App684
//
//  Created by Вячеслав on 7/7/24.
//

import SwiftUI

struct GroupsDetail: View {
    
    @StateObject var viewModel = GroupsViewModel()
    @Environment(\.presentationMode) var router
    
    let index: GroupModel
    
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
                    
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 5, content: {
                            
                            Text(index.title ?? "")
                                .foregroundColor(.black)
                                .font(.system(size: 26, weight: .semibold))
                                .multilineTextAlignment(.leading)
                            
                            Text(index.text ?? "")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.leading)
                        })
                        
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
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .onAppear {
                
                viewModel.group_title = index.title ?? ""
                viewModel.fetchParticipants()
            }
        }
    }
}

//#Preview {
//    GroupsDetail()
//}
