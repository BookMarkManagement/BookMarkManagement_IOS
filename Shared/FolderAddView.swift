//
//  FolderAddView.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 01/03/22.
//

import SwiftUI

struct FolderAddView: View {
    @Environment(\.presentationMode) var presentationMode
//    @StateObject var FolderdataAccess = FolderdataAccessories()
    var FolderdataAccess = FolderdataAccessories()
    @State private var FolderData = FolderValue(ID: "", folder_name: "", email: "karthi.hifi@gmail.com", maincategory: "", lastupdate: "", imageurl: "", favourites: false, visitedtimes: 0, filecount: 0, lastvisited: "")
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Folder Details")) {
                    TextField("Folder Name", text: $FolderData.folder_name)
                        .onAppear(){
                            if FolderdataAccess.isEditFolder == true {
                                FolderData.folder_name = FolderdataAccess.NewFolder.folder_name
                            }
                        }
                    TextField("Category", text: $FolderData.maincategory)
                        .onAppear(){
                            if FolderdataAccess.isEditFolder == true {
                                FolderData.maincategory = FolderdataAccess.NewFolder.maincategory
                            }
                        }
                    
                }
                Section(header: Text("Others")) {
                    TextField("Image Url", text: $FolderData.imageurl)
                        .onAppear(){
                            if FolderdataAccess.isEditFolder == true {
                                FolderData.imageurl = FolderdataAccess.NewFolder.imageurl
                            }
                            
                        }
                    Toggle(isOn: $FolderData.favourites)
                    {
                        Text("Add to Favourities")
                    }
                    .onAppear(){
                        if FolderdataAccess.isEditFolder == true {
                            FolderData.favourites = FolderdataAccess.NewFolder.favourites
                        }
                      
                    }
                }
                
            }
            .navigationBarTitle("New Collection")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        print("Cancel tapped!")
                        FolderdataAccess.isEditFolder = false
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("Save") {
                        print("Save tapped!")
                        FolderdataAccess.isNewFolder.toggle()
                    }
                    .disabled(FolderData.folder_name.isEmpty || FolderData.maincategory.isEmpty)
                }
              
                
            }
        }
    }
}

struct FolderAddView_Previews: PreviewProvider {
    static var previews: some View {
        FolderAddView()
    }
}
