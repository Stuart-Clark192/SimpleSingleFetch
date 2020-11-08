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
            body(for: viewModel.viewData.viewState)

// Note iOS 14 makes this so much nicer as we can directly switch on the enum
//            switch viewModel.viewData.viewState {
//            case .loading:
//                Text("Loading")
//            case .data:
//                List {
//                    ForEach(viewModel.viewData.users) { user in
//                        UserItem(user: user)
//                    }
//                }
//            case .noData:
//                Text("No data to display")
//            case .error:
//                Text("Data error")
//            }
        }
        .onAppear {
            self.viewModel.loadUsers()
        }
    }
    
    @ViewBuilder
    private func body(for state: ViewState) -> some View {
        
        if state == .loading {
            Text("Loading")
        } else if state ==  .data {
            List {
                ForEach(viewModel.viewData.users) { user in
                    UserItem(user: user)
                }
            }
        } else if state == .noData {
            Text("No data to display")
        } else if state == .error {
            Text("Data error")
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = UserViewModel()
        return UserView(viewModel: viewModel)
    }
}

