//
//  MemoryManag_Model.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 15/02/22.
//

import Foundation
import SwiftUI


struct FolderValue : Decodable {
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



