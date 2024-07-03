//
//  LoanView.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 02/07/24.
//

import SwiftUI

struct LoanView: View {
    @StateObject var loanViewModel = LoanViewModel()
    @State private var searchText = ""
    @State private var sortOption: SortOption = .name
    @State private var ascending = true
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                SortOptionsView(sortOption: $sortOption, ascending: $ascending)
                
                List {
                        ForEach(loanViewModel.filteredAndSortedLoans(searchText: searchText, sortOption: sortOption, ascending: ascending)) { loan in
                        NavigationLink(destination: LoanDetailView(loan: loan, loanViewModel: loanViewModel)) {
                            LoanRowView(loan: loan)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Loans")
            .onAppear {
                loanViewModel.fetchLoan()
            }
        }
    }
}

struct LoanRowView: View {
    let loan: LoanModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(loan.borrower.name)
                .font(.headline)
            Text("Amount: $\(loan.amount)")
                .font(.subheadline)
            Text("Interest Rate: \(loan.interestRate, specifier: "%.1f")%")
                .font(.subheadline)
            Text("Term: \(loan.term) months")
                .font(.subheadline)
            Text("Purpose: \(loan.purpose)")
                .font(.subheadline)
            Text("Risk Rating: \(loan.riskRating)")
                .font(.subheadline)
        }
        .frame(width: 250, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    LoanView()
}
