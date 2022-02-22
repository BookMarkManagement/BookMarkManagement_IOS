//
//  FolderHeaderView.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 22/02/22.
//

import SwiftUI

struct FolderHeaderView: View {
    @StateObject var FolderdataAccess = FolderdataAccessories()
    @State private var searchText = ""
    
    var body: some View {
//        GeometryReader { geometry in
//            VStack{
//        NavigationView {
            VStack(alignment : .leading,  spacing : 5){
                Button(action: {
                    withAnimation {
                        print(self.FolderdataAccess.showMenu,"Menu")
//                        self.showMenu.toggle()
                        self.FolderdataAccess.showMenu.toggle()
                        print(self.FolderdataAccess.showMenu,"Menu")
                    }
                }) {
                    HStack{
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top,50)
                }
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                
//                Text("Searching for \(searchText)")
//                                .searchable(text: $searchText)
//                                .navigationTitle("Searchable Example")
                        }
//            }
            
//            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color("primary"))
                .foregroundColor(Color.white)
           
//            }
//            .frame(
//                 minWidth: 0,
//                 maxWidth: .infinity,
//                 minHeight: 1000,
//                 maxHeight: .infinity
////                 alignment: .topLeading
//               )
    
            
//        }
    }
}

struct FolderHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderHeaderView()
    }
}
