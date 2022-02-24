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
    @StateObject var FolderdataAccess = FolderdataAccessories()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List{
                ForEach(FolderdataAccess.FolderData, id: \.category) { item in
                    Section(header: Text(item.category).font(.headline).fontWeight(.bold)) {
                        ForEach(item.Items, id: \.ID) {    item in VStack(alignment: .leading){
                            HStack(alignment: .center, spacing: 10){
                                AsyncImage(url: URL(string: item.imageurl)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                HStack(alignment: .center){
                                    VStack(alignment: .leading, spacing: 5){
                                        Text(item.folder_name)
                                            .font(.headline)
                                        Text("\(item.filecount) Files")
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(item.favourites == true ? .red : .white)
                                }
                            }
                        }
                        }
                    }
                }
            }
            .navigationTitle("Collection Details").font(.headline)
            .navigationBarTitleDisplayMode(.inline)
        }
        .listStyle(SidebarListStyle())
        .searchable(text: $FolderdataAccess.FolderSearchString)
    }
}

@available(iOS 15.0, *)
struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView(FolderData: [])
    }
}
