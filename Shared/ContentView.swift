//
//  ContentView.swift
//  Shared
//
//  Created by Karthik on 15/02/22.
//

import SwiftUI


struct ContentView: View {
    @State private var results =  [FolderValue]()
    @State var showMenu = false
    @StateObject var FolderdataAccess = FolderdataAccessories()
//    @State var FolderdataAccess;.showMenu = false
    
    init(){
//        Theme.navigationBarColors(background: .systemIndigo, titleColor: .white)
//        UITabBar.appearance().backgroundColor = UIColor(Color("primary"))
//        UITabBar.appearance().barTintColor = .white
//        UITabBar.appearance().isTranslucent = false
    }
    
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.FolderdataAccess.showMenu = false
                    }
                }
            }
        if #available(iOS 15.0, *) {
            GeometryReader { geometry in
//                NavigationView {
                    ZStack(alignment: .leading){
                        VStack{
                            FolderHeaderView(FolderdataAccess: FolderdataAccess)
                        TabView{
                            FolderListView(FolderData: FolderdataAccess.results, FolderdataAccess: FolderdataAccess)
                                .tabItem {
                                    Image(systemName: "list.dash")
                                    Text("List view")
                                }
                            
//                            FolderHeaderView(FolderdataAccess: FolderdataAccess).tabItem{
//                                Image(systemName: "folder.fill.badge.plus")
//                                Text("Add Folder")
//                            }
                            FolderCardView(FolderData: FolderdataAccess.results)
                                .tabItem {
                                    Image(systemName: "square.grid.2x2")
                                    Text("Grid view")
                                }
                        }
//                        .background(Color("FolderBack"))
                        .onAppear(perform: loadData)
//                        .frame(
//                            width: geometry.size.width ,
//                                   height: geometry.size.height
//                               )
                        }
                        .background(Color("FolderBack"))
                        .ignoresSafeArea( edges: .all)
                        .offset(x: self.FolderdataAccess.showMenu == true ? geometry.size.width/2 : 0)
                        .disabled(self.FolderdataAccess.showMenu ? true : false)
                        //                        .navigationTitle("Collection Dtails")
                        //                        .navigationBarTitleDisplayMode(.inline)
                        //                        .navigationBarItems(leading: (
                        //                            Button(action: {
                        //                                withAnimation {
                        //                                    print(self.FolderdataAccess.showMenu,"Menu")
                        //                                    self.showMenu.toggle()
                        //                                    self.FolderdataAccess.showMenu.toggle()
                        //                                    print(self.FolderdataAccess.showMenu,"Menu")
                        //                                }
                        //                            }) {
                        //                                Image(systemName: "line.horizontal.3")
                        //                                    .imageScale(.large)
                        //                            }
                        //                        ))
                        if self.FolderdataAccess.showMenu == true {
                            FolderCategoryMenuView(Category: FolderdataAccess.categories, FolderdataAccess: FolderdataAccess)
                                .frame(width: geometry.size.width/2,height: geometry.size.height)
//                                .edgesIgnoringSafeArea(.bottom)
//                                .ignoresSafeArea(edges:.bottom)
                        }
                    }
                    .gesture(drag)
//                }
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
                        self.results = decodedResponse.value
                        self.FolderdataAccess.categories = self.FolderdataAccess.GetUniqueFolderCategories(FolderData: self.results)
                        self.FolderdataAccess.results = self.results
                        self.FolderdataAccess.FullData = self.results
                        self.FolderdataAccess.GetFolderDetails()
//                        print(self.FolderdataAccess.categories)
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
