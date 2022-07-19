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
    
    
    
    //MARK: List view of 5 Recent transactions.
    
    var HomeList: some View {
        ScrollView {
                Section {
                    ForEach(dm.all.prefix(5)) { data in
                        RowView(
                            entity: data,
                            entities: $dm.all,
                            onDelete: dm.deleteTransactions,
                            item: data.name ?? "",
                            date: data.date ?? Date(),
                            amount: data.amount,
                            category: data.category ?? "")
                    }
                }
        }
    }
    
    //MARK: Navigation header responsible for navigating to AllTransactionsView()
    
    var HomeNavigation: some View {
        
        HStack {
            
            Text("5 Most recent transactions")
                .bold()
                .opacity(0.63)
            
            Spacer()
            
            Button { activeSheet = .all } label: {
                HStack {
                    Text("View All")
                    Image(systemName: "chevron.down")
                }
            }
            
        }.padding(.top, 10)
    }
    
    //MARK: SummaryView() of SpentToday, TopCategory, TopBank
    
    var HomeSummary: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            VStack(alignment: .leading) {
                
                Text("Spent Today")
                    .font(.system(size: 30))
                    .opacity(0.5)
                
            }
            
            HStack(alignment: .center) {
                
                Text("$\(vm.spentToday, specifier: specifiedToTenths)")
                    .headlineStyle(empty: vm.areTransactionsEmpty)
                
                Spacer()
                
                
                HStack {
                    Image(systemName: vm.differenceBool ? "arrow.up.right": "arrow.down.right")
                        .foregroundColor(vm.differenceBool ? .green : .red)
                    
                    Text("\(vm.diffPercentage.rounded(), specifier: specifiedToTenths)%")
                    
                }
                .font(.system(size: 20, weight: .bold, design: .default))
                

            }
            
            VStack(alignment: .leading) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(vm.topCat)
                    .headlineStyle(empty: vm.areTransactionsEmpty)
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(vm.topPayment)
                    .headlineStyle(empty: vm.areTransactionsEmpty)
                
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
    
    var HomeBottomBar: some View {
        HStack {
            Menu {
                Section {
                    EditButton()
                        .disabled(dm.all.isEmpty)
                }
                Section {
                    Button(action: {
                        activeSheet = .settings
                    }) {
                        Label("Settings", systemImage: "person.text.rectangle")
                    }
                }
            } label: {
                Image(systemName: "bolt.fill")
            }
            
            Spacer()
            
            Button(action: {
                activeSheet = .add
                settings.haptic(style: .heavy)
            }) {
                Label("Add", systemImage: "plus")
            }
        }
        .font(.title3)
    }
}



