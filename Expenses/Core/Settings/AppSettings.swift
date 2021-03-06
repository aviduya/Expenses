//
//  AppModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/29/21.
//

import Foundation
import SwiftUI
import Sentry

enum HapticStyle {
    case light
    case medium
    case heavy
    case rigid
    
}

enum FeedbackType: String, CaseIterable, Identifiable {
    case bug = "Bug"
    case feature = "Feature"
    case tweak = "Tweak"
    case other = "Other"
    
    var id: String {
        self.rawValue
    }
    
}

enum Keys: String {
    case bank = "bank"
    case category = "category"
    case threshold = "threshold"
}

class AppSettings: ObservableObject {
    
    @Published var banks: [String] = []
    @Published var categories: [String] = []
    let userDefaults = UserDefaults.standard
    
    let bankKey = Keys.bank.rawValue
    let categoryKey = Keys.category.rawValue

    
    init() {
        banks = userDefaults.object(forKey: bankKey) as? [String] ?? []
        categories = userDefaults.object(forKey: categoryKey) as? [String] ?? []
    }
    
    func addElement(new: String, element: inout [String], key: String) {
        withAnimation {
            element.append(new)
            userDefaults.set(element, forKey: key)
        }
        
    }
    
    func submitFeedback(subject: String, comment: String, email: String, type: FeedbackType) {
        let eventID = SentrySDK.capture(message: subject)
        let feedback = UserFeedback(eventId: eventID)
        
        feedback.comments = comment
        feedback.email = email
        feedback.name = type.rawValue
        
        SentrySDK.capture(userFeedback: feedback)
        
    }
    
    func removeBank(at offsets: IndexSet) {
        banks.remove(atOffsets: offsets)
        userDefaults.set(banks, forKey: bankKey)
    }
    
    func removeCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
        userDefaults.set(categories, forKey: categoryKey)
    }
    
    
    func haptic(style: HapticStyle) {
        let heavy = UIImpactFeedbackGenerator(style: .heavy)
        let soft = UIImpactFeedbackGenerator(style: .soft)
        let medium = UIImpactFeedbackGenerator(style: .medium)
        let rigid = UIImpactFeedbackGenerator(style: .rigid)

        switch style {
        case .light:
            soft.impactOccurred()
        case .medium:
            medium.impactOccurred()
        case .heavy:
            heavy.impactOccurred()
        case .rigid:
            rigid.impactOccurred()
        }
       
        
    }
    
    
}
