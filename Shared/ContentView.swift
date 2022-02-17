//
//  ContentView.swift
//  Shared
//
//  Created by Karthik on 15/02/22.
//

import SwiftUI


struct ContentView: View {
    @State private var results =  [FolderValue]()
    let FolderdataAccess = FolderdataAccessories()
    
    init(){
        Theme.navigationBarColors(background: .purple, titleColor: .white)
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            //            Text("Collection List").fontWeight(.bold).font(.title).padding()
            NavigationView {
                TabView{
                    FolderListView(FolderData: results)
                        .onAppear(perform: loadData)
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("List view")
                        }
                    
                    Text("Add New Collection View").tabItem{
                        Image(systemName: "folder.fill.badge.plus")
                        Text("Add Folder")
                    }
                    FolderCardView(FolderData: results)
                        .tabItem {
                            Image(systemName: "square.grid.2x2")
                            Text("Grid view")
                        }
                }
                .navigationTitle("Collection Dtails")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            //                                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                ))
            }
            
        }
    }
    
    
    @available(iOS 15.0, *)
    func loadData() {
        guard let url = URL(string: "https://5aa7bb4ftrial-dev-contentmanagement-srv.cfapps.eu10.hana.ondemand.com/content-manag/Folder") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                //                print(data)
                if let decodedResponse = try? JSONDecoder().decode(FolderData.self, from: data) {
                    DispatchQueue.main.async {
                        //                        print(decodedResponse)
                        self.results = decodedResponse.value
                        self.FolderdataAccess.categories = self.FolderdataAccess.GetUniqueFolderCategories(FolderData: self.results)
                        print(self.FolderdataAccess.categories)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
