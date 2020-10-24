//
//  ShowView.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import SwiftUI

struct ShowView: ViewModifier {
    
    var isVisible: Bool
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
        }
    }
}
