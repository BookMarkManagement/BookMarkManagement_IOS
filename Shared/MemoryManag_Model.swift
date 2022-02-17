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

class FolderdataAccessories{
    var categories :[String] = []
    
    func GetUniqueFolderCategories( FolderData : [FolderValue]) -> [String]{
        var Categories = [String]()
        for item in FolderData{
            Categories.append(item.maincategory)
        }
        let UniqueCat = Set(Categories)
        return Array(UniqueCat)
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




