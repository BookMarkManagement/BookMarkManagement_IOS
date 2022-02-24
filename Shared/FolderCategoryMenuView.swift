//
//  FolderCategoryMenuView.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 18/02/22.
//

import SwiftUI

struct FolderCategoryMenuView: View {
    var Category : [String]
    var FolderdataAccess : FolderdataAccessories
    var body: some View {
        GeometryReader { geometry in
//            print(self.FolderdataAccess.showMenu,"Menu")
        VStack(alignment: .leading) {
            ForEach(Category, id: \.self) { item in
                HStack {
                    Text(item)
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .onTapGesture {
//                    print("Tapperd",item,FolderdataAccess.categories)
                    FolderdataAccess.FolderData =   FolderdataAccess.GetFilteredFolders( Category: item)
                    print(FolderdataAccess.FolderData.count,"Folder results")
                    FolderdataAccess.showMenu.toggle()
//                    print("Inside",FolderdataAccess.showMenu)
                }
                .padding(.top, 10)
            }
            Spacer()
        }
        .padding()
//        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: geometry.size.width, height: geometry.size.height)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255).edgesIgnoringSafeArea(.all))
//        .edgesIgnoringSafeArea(.bottom)
//        .ignoresSafeArea()
    }
    }
}

struct FolderCategoryMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FolderCategoryMenuView(Category: [],FolderdataAccess: FolderdataAccessories())
    }
}
