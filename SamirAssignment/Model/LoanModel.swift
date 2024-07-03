//
//  LoanModel.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 02/07/24.
//

import Foundation

struct LoanModel: Identifiable, Decodable {
    let id: String
    let amount: Double
    let interestRate: Double
    let term: Int
    let purpose: String
    let riskRating: String
    let borrower: Borrower
    let collateral: Collateral
    let documents: [Documents]
    let repaymentSchedule: RepaymentSchedule
}

struct Borrower: Decodable {
    let id: String
    let name: String
    let email: String
    let creditScore: Int
}

struct Collateral: Decodable {
    let type: String
    let value: Double
}

struct Documents: Decodable {
    let type: String
    let url: String?
}

struct RepaymentSchedule: Decodable {
    let installments: [Installment]
}

struct Installment: Hashable, Decodable {
    var dueDate: String
    var amountDue: Double
    
    // Implement Hashable manually if needed
    func hash(into hasher: inout Hasher) {
        hasher.combine(dueDate)
        hasher.combine(amountDue)
    }
    
    // Implement Equatable if needed
    static func == (lhs: Installment, rhs: Installment) -> Bool {
        return lhs.dueDate == rhs.dueDate && lhs.amountDue == rhs.amountDue
    }
}
