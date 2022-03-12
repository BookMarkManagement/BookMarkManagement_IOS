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
    @State private var confirmationShown = false
    @State private var selectedFolder: String = ""
    @State private var selectedID: String = ""
    @State private var isPresented = false
    @State private var FolderEdit = FolderValue(ID: "", folder_name: "", email: "karthi.hifi@gmail.com", maincategory: "", lastupdate: "", imageurl: "", favourites: false, visitedtimes: 0, filecount: 0, lastvisited: "")
    
    
    var FolderData1: [FolderDataFinal] { // 1
        var FolderData : [FolderDataFinal] = []
        if FolderdataAccess.DeletePressed == true {
            let folderIndex = self.FolderdataAccess.FullData.firstIndex(where: { $0.ID == FolderdataAccess.DeletionID})!
//            print(self.FolderdataAccess.FullData[folderIndex].folder_name,"Bef del",folderIndex)
            let newFolderData =  self.FolderdataAccess.DeleteFolder(Index: folderIndex)
//            print(self.FolderdataAccess.FullData.count,"After Del")
            FolderdataAccess.DeletePressed.toggle()
            return newFolderData
            
        } else if searchText.isEmpty && ( FolderdataAccess.SelectedCategory == "" || FolderdataAccess.SelectedCategory == "All" ) {
            //           self.FolderData = self.FolderDataAll
            return self.FolderdataAccess.FolderDataAll
        } else if FolderdataAccess.isNewFolder == true{
            print("reached new Folder")
            FolderdataAccess.isNewFolder.toggle()
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
    
    func Delete(at offsets: IndexSet, in section: FolderDataFinal){
        print(offsets,"offsets",section)
        //        FolderData1.remove(atOffsets: offsets)
        //        print(FolderData)
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(FolderData1, id: \.category) { item in
                    Section(header: Text(item.category).font(.headline).fontWeight(.bold)) {
                        
                        ForEach(item.Items, id: \.ID) {    item in VStack(alignment: .leading){
                            HStack(alignment: .center, spacing: 10){
                                
                                if FolderdataAccess.EditPressed == true  {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                        .onTapGesture(perform: {
                                            selectedID = item.ID
                                            selectedFolder = item.folder_name
                                            confirmationShown = true
                                        })
                                        .alert(isPresented: $confirmationShown) {
                                            Alert(title: Text("Do you want to Delete \(selectedFolder) ?"), primaryButton: .destructive(Text("Cancel"), action: { // 1
                                            }),
                                                  secondaryButton:
                                                        .default(Text("Ok"), action: {
                                                self.FolderdataAccess.DeletePressed.toggle()
                                                self.FolderdataAccess.DeletionID = self.selectedID
                                            }
                                                                )
                                            )}
                                    
                                    Image(systemName: "pencil.circle.fill")
                                        .foregroundColor(.gray)
                                        .onTapGesture(perform: {
                                            FolderEdit = item
                                            self.FolderdataAccess.NewFolder = self.FolderEdit
                                            print(self.FolderdataAccess.NewFolder.folder_name,"Edit",self.FolderEdit.folder_name,"selectedFolder")
                                            self.FolderdataAccess.isEditFolder.toggle()
                                            isPresented.toggle()
                                        })
                                }
                                
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
                        .onDelete{self.Delete(at: $0, in : item)}
                    }
                }
                //                .listRowBackground(Color("FolderBack"))
            }
//            .fullScreenCover(isPresented: $isPresented, content: FolderAddView.init)
            .fullScreenCover(isPresented: $isPresented){
                FolderAddView(FolderdataAccess : FolderdataAccess)
            }
            .navigationTitle("Collection Details")
//            .font(.headline)
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Add Category") {
                        print("New Folder")
//                        self.FolderdataA ccess.EditPressed.toggle()
                    }
                    Button("Add") {
                        print("Edit tapped!")
                        self.FolderdataAccess.isNewFolder.toggle()
                        isPresented.toggle()
                    }
                    FolderdataAccess.EditPressed == false ?  Button("Edit") {
                        print("Edit tapped!")
//                        self.FolderdataAccess.NewFolder = FolderEdit
//                        print(self.FolderdataAccess.NewFolder,"Edit",FolderEdit)
//                        self.FolderdataAccess.NewFolder.folder_name =
                        self.FolderdataAccess.EditPressed.toggle()
                    } :
                    Button("Cancel") {
                        print("Cancel tapped!")
                        self.FolderdataAccess.EditPressed.toggle()
                    }
                }
            }
        }
        .listStyle(SidebarListStyle())
        .searchable(text: $searchText,    prompt: "Search Folder Name",
                    suggestions: { //1
            ForEach(FolderdataAccess.FullData.filter {item in item.folder_name.localizedCaseInsensitiveContains(searchText) } , id: \.ID) { item in
                Text(item.folder_name)
                    .searchCompletion(item.folder_name)
            }
        })
    }
}

@available(iOS 15.0, *)
struct FolderListView_Previews: PreviewProvider {
    static var previews: some View {
        FolderListView(FolderData: [])
    }
}
