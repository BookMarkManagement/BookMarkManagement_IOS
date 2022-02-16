//
//  ContentView.swift
//  Shared
//
//  Created by Karthik on 15/02/22.
//

import SwiftUI


struct ContentView: View {
    @State private var results =  [FolderValue]()
    var body: some View {
        if #available(iOS 15.0, *) {
            Text("Collection List").fontWeight(.bold).font(.title).padding()
            TabView{
                List(results,id: \.ID){
                    item in VStack(alignment: .leading){
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
                                    Text("File Count: \(item.filecount)")
                                        .font(.subheadline)
                                }
                                Spacer()
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(item.favourites == true ? .red : .white)
                            }
                        }
                        
                    }
                }.onAppear(perform: loadData)
                    .listStyle(.plain)
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("List view")
                    }
                
                Text("Grid View")
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Grid view")
                    }
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
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(FolderData.self, from: data) {
                    DispatchQueue.main.async {
                        print(decodedResponse)
                        self.results = decodedResponse.value
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
    
    //        do {
    //            print(url)
    //            let (data, _) = try await URLSession.shared.data(from: url)
    //
    //            if let decodedResponse = try?
    //                JSONDecoder().decode(FolderData.self, from: data) {
    //                results = decodedResponse.value
    //                print(results)
    //            }
    //        } catch {
    //            print("Invalid data")
    //        }
    //    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
