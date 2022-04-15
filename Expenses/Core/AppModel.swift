//
//  AppModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/29/21.
//

import Foundation

enum Banks: String, CaseIterable, Identifiable  {
    var id: String {self.rawValue}
    
    case chase = "Chase"
    case capitalone = "Capital One"
    case apple = "Apple"
    case schwab = "Charles Schwab"
    case amex = "American Express"
}

enum Categories: String, CaseIterable, Identifiable {
    var id: String {self.rawValue}
    
    case groceries = "Groceries"
    case bills = "Bills"
    case personal = "Personal"
    case other = "Other"
    case necesities = "Necesities"
    
    var icon: String {
        switch self {
            
        case.groceries: return "cart"
        case.bills: return "list.bullet.rectangle.portrait"
        case.personal: return "person.fill"
        case.necesities: return "person.text.rectangle.fill"
        case.other: return "questionmark"
            
        }
    }
    
}

enum CategorySymbols: String  {
    case groceries = "cart"
    case bills = "list.bullet.rectangle.portrait"
    case personal = "person.fill"
    case other = "questionmark"
    case necesities = "person.text.rectangle.fill"
}

enum Months: String, Identifiable, CaseIterable {
    var id: String {self.rawValue}
    
    case jan = "January"
    case feb = "Febuary"
    case mar = "March"
    case apr = "April"
    case may = "May"
    case jun = "June"
    case jul = "July"
    case aug = "August"
    case sep = "September"
    case oct = "October"
    case nov = "November"
    case dec = "December"
}

