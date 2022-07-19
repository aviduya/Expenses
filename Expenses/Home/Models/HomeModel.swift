//
//  HomeModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 7/9/22.
//

import Foundation
import SwiftUI

enum ActiveView: Identifiable {
    
    case settings
    case add
    case all
    
    var id: Int {
        hashValue
    }
}

struct HeadlineStyle: ViewModifier {
    
    var activeRedacted: Bool
    var activeShimmer: Bool
    
    func body(content: Content) -> some View {
        
        content
            .redacted(reason: activeRedacted ? .placeholder : [] )
            .shimmering(active: activeShimmer)
            .font(.system(size: 35, weight: .regular, design: .rounded))
    }
    
}

extension View {
    func headlineStyle(empty: Bool) -> some View {
        modifier(HeadlineStyle(activeRedacted: empty, activeShimmer: empty))
    }
}
