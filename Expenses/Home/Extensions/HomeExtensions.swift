//
//  HomeExtensions.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import SwiftUI

//MARK: Extracted Views of HomeView

extension HomeView {
    
    var transactionsList: some View {
        
        ScrollView {
            Section {
                ForEach(dm.all.prefix(5)) { t in
                    RowView(
                        entity: t,
                        entities: $dm.all,
                        onDelete: dm.deleteTransactions(_:),
                        item: t.name ?? "",
                        date: t.date?.formatted() ?? "Something went wrong",
                        amount: t.amount,
                        category: t.category ?? "")
                }
            }
        }
        .padding(.horizontal)
    }
    
    var HomeNavigation: some View {
        HStack {
            Text("5 Most recent transactions")
                .bold()
                .opacity(0.63)
            Spacer()
            NavigationLink(destination: AllTransacitonsView(), label: {
                HStack {
                    
                    Text("View All")
                    Image(systemName: "chevron.right")
                    
                }
                
            })
        }.padding([.horizontal, .top])
    }
    
    var HomeSummary: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: .leading) {
                
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                if diffPercentage > 0 {
                    
                    HStack {
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(Color.red)
                        Text("\(diffPercentage.rounded(), specifier: "%2.f")%")
                    }
                    .font(.system(size: 20, weight: .bold, design: .default))
                } else if diffPercentage < 0{
                    HStack {
                        Image(systemName: "arrow.down.right")
                            .foregroundColor(Color.green)
                        Text("\(diffPercentage.rounded(), specifier: "%2.f")%" )
                        
                    }
                    .font(.system(size: 20, weight: .bold, design: .default))
                }
                
                
                Text("$\(spentToday, specifier: "%.2f")")
                    .font(.system(size: 35, weight: .regular, design: .rounded))
            }
            VStack(alignment: .leading) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(topCat)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(topPayment)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipped()
    }
}

//MARK: Computed Properties returning data.

extension HomeView {
    
    var spentToday: Double {
        
        var total = 0.0
        
        for transaction in dm.today {
            total += transaction.amount
        }
        
        return total
    }
    
    var spentYesterday: Double {
        
        var total = 0.0
        
        for transaction in dm.yesterday {
            total += transaction.amount
        }
        
        return total
    }
    
    
    
    var diffPercentage: Double {
        
        let difference = spentToday - spentYesterday
        
        return (difference / spentYesterday) * 100
    }
  
    
    
    var topCat: String {
        var arry: [String] = []
        
        for transaction in dm.all {
            arry.append(transaction.category ?? "")
            
        }
        
        return arry.filtered().first ?? "No Category Recorded"
    }
    
    var topPayment: String {
        var arry: [String] = []
        
        for transaction in dm.all {
            arry.append(transaction.bank ?? "")
        }
        
        return arry.filtered().first ?? "No Payment Recorded"
    }
}



