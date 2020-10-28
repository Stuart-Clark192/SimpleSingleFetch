//
//  UserView.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        Group {
            
            switch viewModel.viewData.viewState {
            case .loading:
                Text("Loading")
            case .data:
                List {
                    ForEach(viewModel.viewData.users) { user in
                        Text(user.name)
                    }
                }
            case .noData:
                Text("No data to display")
            case .error:
                Text("Data error")
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = UserViewModel(using: URLTestSession.testSession())
        return UserView(viewModel: viewModel)
    }
}

