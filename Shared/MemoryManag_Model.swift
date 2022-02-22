//
//  MemoryManag_Model.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 15/02/22.
//

import Foundation
import SwiftUI


struct FolderValue : Decodable  {
    //    var createdAt, createdBy, modifiedAt, modifiedBy: String
    var ID, folder_name, email, maincategory: String
    var lastupdate: String
    var imageurl: String
    var favourites: Bool
    var visitedtimes, filecount: Int
    var lastvisited: String
    //    var isActiveEntity, hasActiveEntity, hasDraftEntity: Bool
}

struct FolderData : Decodable {
    var value: [FolderValue]
}

class FolderdataAccessories : ObservableObject{
    @Published var categories :[String] = []
    @Published var results =  [FolderValue]()
    var FullData = [FolderValue]()
    @Published var showMenu = false
    
    func GetUniqueFolderCategories( FolderData : [FolderValue]) -> [String]{
        var Categories = [String]()
        for item in FolderData{
            Categories.append(item.maincategory)
        }
//        Categories.insert("All", at: 0)
        var UniqueCat = Array(Set(Categories))
        UniqueCat.insert("All", at: 0)
        return UniqueCat
    }
    
    func GetFilteredFolders(FolderData : [FolderValue], Category: String) -> [FolderValue]{

        if Category == "All"{
//            self.showMenu = false
            return self.FullData
        }
        let filtered = self.FullData.filter { item in
            return  item.maincategory == Category
        }
//        print("filyer start",filtered.count,"filtered")
//        self.showMenu = false
        return filtered
    }
    
    func loadData() {
        guard let url = URL(string: "https://5aa7bb4ftrial-dev-contentmanagement-srv.cfapps.eu10.hana.ondemand.com/content-manag/Folder")
        else {
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
                        self.categories = self.GetUniqueFolderCategories(FolderData: self.results)
//                        print(self.FolderdataAccess.categories)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

class Theme {
    static func navigationBarColors(background : UIColor?,
       titleColor : UIColor? = nil, tintColor : UIColor? = nil ){
        
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
       
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
    }
}






