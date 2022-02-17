//
//  FolderCategoryMenuView.swift
//  BookMarkManagement_IOS
//
//  Created by Karthik on 18/02/22.
//

import SwiftUI

struct FolderCategoryMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
        }
    }
}

struct FolderCategoryMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FolderCategoryMenuView()
    }
}
