//
//  FolderCardView.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 17/02/22.
//

import SwiftUI

struct FolderCardView: View {
    var FolderData : [FolderValue]
    var body: some View {
        
        if #available(iOS 15.0, *) {
            let data = FolderData //(1...20).map { "Item \($0)" }
            
            let columns = [
                GridItem(.adaptive(minimum: 100))
            ]
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(data, id: \.ID) { item in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.white)
                            
                            VStack {
                                AsyncImage(url: URL(string: item.imageurl)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
//                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                } placeholder: {
                                    Color.purple.opacity(0.1)
                                }
                                Text(item.folder_name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                                
                                Text(item.maincategory)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(10)
                            .multilineTextAlignment(.center)
                        }
                    }
                }
                .padding(.horizontal)
            }
//            .frame(maxHeight: 300)
        } else {
        // Fallback on earlier versions
    }
    //        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
}
}

struct FolderCardView_Previews: PreviewProvider {
    static var previews: some View {
        FolderCardView(FolderData: [])
    }
}

