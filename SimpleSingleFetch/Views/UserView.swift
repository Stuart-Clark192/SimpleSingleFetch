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
            Text("Loading").showView(isVisible: viewModel.viewData.viewState == ViewState.loading)
            
            List {
                ForEach(viewModel.viewData.users) { user in
                    Text(user.name)
                }
            }.showView(isVisible: viewModel.viewData.viewState == ViewState.data)
            
            Text("No data to display").showView(isVisible: viewModel.viewData.viewState == ViewState.noData)
            
            Text("Data error").showView(isVisible: viewModel.viewData.viewState == ViewState.error)
        }
        .onAppear {
            viewModel.loadUsers()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = UserViewModel()
        return UserView(viewModel: viewModel)
    }
}
