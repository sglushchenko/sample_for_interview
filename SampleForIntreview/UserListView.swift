//
//  UserListView.swift
//  SampleForInterview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.users, id: \.self) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        UserRowView(user: user)
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)

                    Divider()
                }
            }
        }
        .onAppear {
            viewModel.reloadUsers()
        }
    }
    
    final class ViewModel: ObservableObject {
        enum State {
            case idle
            case loading
            case displayUsers
            case error
        }
        
        private var currentPage: Int = 0
        
        @Published
        fileprivate var users: [User] = []
        
        private let usersService: UsersServiceProtocol
        
        @Published
        fileprivate var state: State = .idle
        
        private var isFullLoaded: Bool = false
        
        init(usersService: UsersServiceProtocol = UsersService()) {
            self.usersService = usersService
        }
        
        /// Reload users.
        ///
        ///**Important**
        ///
        /// `users` set empty array.
        ///
        /// `currentPage` set to 0
        ///
        func reloadUsers() {
            guard state != .loading else { return }
            users = []
            
            state = .loading
            currentPage = 0
            usersService.loadUsers(page: currentPage) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.isFullLoaded = response.data.count == 0
                    self.users = response.data
                    self.state = .displayUsers
                case .failure:
                    self.state = .error
                }
            }
        }
        
        /// Load next page of Users
        ///
        func loadNextPageUsers() {
            guard state != .loading else { return }
            
            state = .loading
            currentPage += 1
            
            usersService.loadUsers(page: currentPage) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    self.isFullLoaded = response.data.count == 0
                    self.users.append(contentsOf: response.data)
                    self.state = .displayUsers
                case .failure: break
                }
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
