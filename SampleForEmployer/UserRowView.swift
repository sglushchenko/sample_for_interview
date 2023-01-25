//
//  UserRowView.swift
//  SampleForEmployer
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack {
            UserAvatarView(url: URL(string: user.avatar), size: 64)
            Text(user.name)
            
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User.sample)
    }
}
