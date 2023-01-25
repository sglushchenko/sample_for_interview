//
//  UserDetailsView.swift
//  SampleForIntreview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        Text("Welcome to \(user.name)")
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: User.sample)
    }
}
