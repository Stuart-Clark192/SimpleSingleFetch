//
//  UserItem.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 03/11/2020.
//

import SwiftUI

struct UserItem: View {
    
    var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Name: \(user.name)")
            Text("Email: \(user.email)")
            Text("Company: \(user.company.name)")
        }.padding()
    }
}

struct UserItem_Previews: PreviewProvider {
    static var previews: some View {
        UserItem(user: User(id: 1, name: "Stuart", username: "clarkus", email: "test@email.com", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "Company", catchPhrase: "", bs: "")))
    }
}
