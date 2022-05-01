//
//  AllTransacitonsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import SwiftUI

struct AllTransacitonsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject private var dm = CoreDataHandler.shared
    @StateObject private var vm = AllTransactionsViewModel()
    
    private let error = "Something went wrong"
    
    var body: some View {
        
        ScrollView {
            VStack {
                switch vm.page {
                case .today:
                    today
                case .seven:
                    week
                case .month:
                    month
                case .year:
                    year
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Sort by", selection: $vm.page) {
                            
                            HStack {
                                Text("Today [\(dm.today.count)]")
                            }
                            .tag(selectedFilter.today)
                            
                            HStack {
                                Text("7 Days [\(dm.week.count)]")
                            }
                            .tag(selectedFilter.seven)
                            
                            HStack {
                                Text("Month [\(dm.month.count)]")
                            }
                            .tag(selectedFilter.month)
                            
                            HStack {
                                Text("All Transactions [\(dm.all.count)]")
                            }
                            .tag(selectedFilter.year)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "square.3.stack.3d.top.filled")
                            Text("Filter")
                        }
                    }
                }
            }
            .navigationBarTitle(vm.status)
            .navigationBarItems(trailing: EditButton())
        }.onAppear(perform: dm.getEverything)
        
    }
}


extension AllTransacitonsView {
    
    var today: some View {
        ForEach(dm.today) { t in
            RowView(
                entity: t,
                entities: $dm.all,
                onDelete: dm.deleteTransactions(_:),
                item: t.name ?? "",
                date: t.date?.formatted() ?? error,
                amount: t.amount,
                category: t.category ?? "")
        }
    }
    
    var week: some View {
        ForEach(dm.week) { t in
            RowView(
                entity: t,
                entities: $dm.all,
                onDelete: dm.deleteTransactions(_:),
                item: t.name ?? "",
                date: t.date?.formatted() ?? error,
                amount: t.amount,
                category: t.category ?? "")
        }
    }
    
    var month: some View {
        ForEach(dm.month) { t in
            RowView(
                entity: t,
                entities: $dm.all,
                onDelete: dm.deleteTransactions(_:),
                item: t.name ?? "",
                date: t.date?.formatted() ?? error,
                amount: t.amount,
                category: t.category ?? "")
        }
        
    }
    
    var year: some View {
        ForEach(dm.all) { t in
            RowView(
                entity: t,
                entities: $dm.all,
                onDelete: dm.deleteTransactions(_:),
                item: t.name ?? "",
                date: t.date?.formatted() ?? error,
                amount: t.amount,
                category: t.category ?? "")
        }
    }
}


