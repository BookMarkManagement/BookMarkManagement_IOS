//
//  FolderListView.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 17/02/22.
//

import SwiftUI

@available(iOS 15.0, *)
struct FolderListView: View {
    var FolderData : [FolderValue]
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            //            VStack{
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
//                    .listRowSeparator(.hidden)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
//            .listRowSeparator(.hidden)
            //                Spacer()
            //    }
            
            .navigationTitle("Collection Details").font(.headline)
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
        .searchable(text: $searchText)
    }
}

@available(iOS 15.0, *)
struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView(FolderData: [])
    }
}
