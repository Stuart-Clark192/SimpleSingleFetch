//
//  View+Extensions.swift
//  SimpleSingleFetch
//
//  Created by Stuart on 21/10/2020.
//

import SwiftUI

extension View {
    
    func showView(isVisible: Bool) -> some View {
        ModifiedContent(content: self, modifier: ShowView(isVisible: isVisible))
    }
}
