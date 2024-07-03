//
//  LoanViewModel.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 02/07/24.
//

import Foundation
import Combine

class LoanViewModel: ObservableObject {
    @Published var documents: [LoanModel] = []
    @Published var downloadedDocument: Data?
    private var cancellables = Set<AnyCancellable>()
    private let loanService: LoanService
    
    init(loanService: LoanService = APIService()) {
        self.loanService = loanService
    }
    
    func fetchLoan() {
        loanService.fetchLoan()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching documents: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] loans in
                self?.documents = loans
            })
            .store(in: &cancellables)
    }
    
    func fetchDocument(urlString: String) {
        let fullURLString = "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main" + urlString
        loanService.fetchDocument(urlString: fullURLString)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching document: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] data in
                self?.downloadedDocument = data
            })
            .store(in: &cancellables)
    }
    
    func filteredAndSortedLoans(searchText: String, sortOption: SortOption, ascending: Bool) -> [LoanModel] {
        var filteredLoans = documents.filter { document in
            searchText.isEmpty || document.borrower.name.lowercased().contains(searchText.lowercased())
        }
        
        switch sortOption {
        case .amount:
            filteredLoans.sort { ascending ? $0.amount < $1.amount : $0.amount > $1.amount }
        case .term:
            filteredLoans.sort { ascending ? $0.term < $1.term : $0.term > $1.term }
        case .purpose:
            filteredLoans.sort { ascending ? $0.purpose < $1.purpose : $0.purpose > $1.purpose }
        case .name:
            filteredLoans.sort { ascending ? $0.borrower.name < $1.borrower.name : $0.borrower.name > $1.borrower.name }
        }
        return filteredLoans
    }
}
