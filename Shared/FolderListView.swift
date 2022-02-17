//
//  FolderListView.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 17/02/22.
//

import SwiftUI

struct FolderListView: View {
    var FolderData : [FolderValue]
    var body: some View {
        List(FolderData,id: \.ID){
            item in VStack(alignment: .leading){
                HStack(alignment: .center, spacing: 10){
                    if #available(iOS 15.0, *) {
                        AsyncImage(url: URL(string: item.imageurl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.red
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        // Fallback on earlier versions
                    }
                    HStack(alignment: .center){
                        VStack(alignment: .leading, spacing: 5){
                            Text(item.folder_name)
                                .font(.headline)
                            Text("File Count: \(item.filecount)")
                                .font(.subheadline)
                        }
                        Spacer()
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(item.favourites == true ? .red : .white)
                    }
                }
                
            }
        }
        .listStyle(.plain)
    }
}

struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView(FolderData: [])
    }
}
