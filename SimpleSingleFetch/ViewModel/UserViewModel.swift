//
//  UserViewModel.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import SwiftUI
import Combine

enum ViewState {
    case loading
    case data
    case noData
    case error
}

struct ViewModelPublished {
    var users: [User] = []
    var viewState: ViewState = .noData
}

class UserViewModel: ObservableObject {
    
    @Published private(set) var viewData = ViewModelPublished()
    
    private var worker = UserWorker()
    private var cancellationToken: AnyCancellable?
    private var session: URLSession!
    
    init(using session: URLSession) {
        self.session = session
    }
    
    func loadUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        viewData.viewState = .loading
        cancellationToken = worker.fetchUsers(url: url, httpMethod: .get, using: session)

            .receive(on: DispatchQueue.main) // We want to receive this on the main queue so we can update
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.viewData.viewState = .error
                }
            },
            receiveValue: { [weak self] model in
                self?.viewData.viewState = model.isEmpty ? .noData : .data
                self?.viewData.users = model
            })
    }
}
