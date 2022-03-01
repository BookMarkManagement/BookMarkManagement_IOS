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
                            FolderData.folder_name = FolderdataAccess.NewFolder.folder_name
                        }
                    TextField("Category", text: $FolderData.maincategory)
                        .onAppear(){
                            FolderData.maincategory = FolderdataAccess.NewFolder.maincategory
                        }
                    
                }
                Section(header: Text("Others")) {
                    TextField("Image Url", text: $FolderData.imageurl)
                        .onAppear(){
                            FolderData.imageurl = FolderdataAccess.NewFolder.imageurl
                        }
                    Toggle(isOn: $FolderData.favourites)
                    {
                        Text("Add to Favourities")
                    }
                    .onAppear(){
                        FolderData.favourites = FolderdataAccess.NewFolder.favourites
                    }
                }
                
            }
            .navigationBarTitle("New Collection")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        print("Cancel tapped!")
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("Save") {
                        print("Save tapped!")
                    }
                    .disabled(FolderdataAccess.NewFolder.folder_name.isEmpty || FolderdataAccess.NewFolder.maincategory.isEmpty)
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
