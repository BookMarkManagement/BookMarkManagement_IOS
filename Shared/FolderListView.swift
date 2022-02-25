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
    
    var FolderData1: [FolderDataFinal] { // 1
        var FolderData : [FolderDataFinal] = []
        if searchText.isEmpty && ( FolderdataAccess.SelectedCategory == "" || FolderdataAccess.SelectedCategory == "All" ) {
            //           self.FolderData = self.FolderDataAll
            return self.FolderdataAccess.FolderDataAll
        } else {
            print(searchText,"text")
            var category : String = ""
            if ( !FolderdataAccess.SelectedCategory.isEmpty  && FolderdataAccess.SelectedCategory != "All" ){
                category = FolderdataAccess.SelectedCategory
                FolderData = self.FolderdataAccess.FolderDataAll.filter { item in
                    return  item.category.contains(category)
                }
            } else if !searchText.isEmpty{
                category = searchText
                FolderData = self.FolderdataAccess.GetSearchedItemsbyName(Folder: searchText)
                print(FolderData.count,"Count", searchText)
            }
            
            //               print("reached",FolderdataAccess.SelectedCategory,category)
            return FolderData
        }
    }
    //    var FolderData1 = FolderdataAccess.FolderData
    
    var body: some View {
        NavigationView {
            List{
                ForEach(FolderData1, id: \.category) { item in
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
                //                .listRowBackground(Color("FolderBack"))
            }
            .navigationTitle("Collection Details").font(.headline)
            .navigationBarTitleDisplayMode(.inline)
        }
        .listStyle(SidebarListStyle())
        .searchable(text: $searchText,    prompt: "Search Folder Name",
                    suggestions: { //1
            ForEach(FolderdataAccess.FullData.filter {item in item.folder_name.localizedCaseInsensitiveContains(searchText) } , id: \.ID) { item in
                Text(item.folder_name)
                        .searchCompletion(item.folder_name)
                }
//            ForEach(FolderdataAccess.FullData, id: \.ID){ item in
//                Text(item.folder_name).searchCompletion(item.folder_name).searchCompletion(item.folder_name) // 2
//            }
//            for item in FolderdataAccess.FullData {
//                
//            }
           
        })
    }
}

@available(iOS 15.0, *)
struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView(FolderData: [])
    }
}
