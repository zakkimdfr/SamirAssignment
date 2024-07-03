//
//  LoanDetailView.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 02/07/24.
//

import SwiftUI

struct LoanDetailView: View {
    let loan: LoanModel
    @ObservedObject var loanViewModel: LoanViewModel
    @State private var isZoomed = false
    @State private var selectedImageData: Data? = nil
    @State private var showDocuments = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Borrower:")
                .font(.title)
                .fontWeight(.semibold)
            Text("Name: \(loan.borrower.name)")
            Text("Email: \(loan.borrower.email)")
            Text("Credit Score: \(loan.borrower.creditScore)")
            Text("Collateral Type: \(loan.collateral.type)")
            Text("Collateral Value: $\(loan.collateral.value)")
            
            Text("Repayment Schedule:")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            ForEach(loan.repaymentSchedule.installments, id: \.self) { installment in
                VStack(alignment: .leading) {
                    Text("Due Date: \(installment.dueDate)")
                    Text("Amount Due: $\(installment.amountDue)")
                }
                .padding(.leading, 20)
            }
            
            if !loan.documents.isEmpty {
                Button(action: {
                    withAnimation {
                        showDocuments.toggle()
                    }
                }) {
                    HStack {
                        Text("Income Statement")
                        Spacer()
                        Image(systemName: showDocuments ? "chevron.up" : "chevron.down")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .padding(.vertical)
                
                if showDocuments {
                    ForEach(loan.documents, id: \.url) { document in
                        Text("")
                            .padding(.bottom, -50)
                            .onAppear {
                                if let urlString = document.url {
                                    loanViewModel.fetchDocument(urlString: urlString)
                                }
                            }
                            .onTapGesture {
                                if let urlString = document.url {
                                    if let imageData = loanViewModel.downloadedDocument {
                                        selectedImageData = imageData
                                        isZoomed.toggle()
                                    }
                                }
                            }
                            .sheet(isPresented: $isZoomed) {
                                if let imageData = selectedImageData {
                                    ZoomableView(uiImage: UIImage(data: imageData)!)
                                }
                            }
                        
                        if let downloadedData = loanViewModel.downloadedDocument {
                            Image(uiImage: UIImage(data: downloadedData)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 250, alignment: .center)
                                .cornerRadius(8)
                                .padding(.top, 8)
                                .onTapGesture {
                                    selectedImageData = downloadedData
                                    isZoomed.toggle()
                                }
                                .sheet(isPresented: $isZoomed) {
                                    if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                                        ZoomableView(uiImage: uiImage)
                                    }
                                }
                        } else {
                            ProgressView()
                                .frame(width: 100, height: 100)
                                .padding(.top, 8)
                        }
                    }
                }
            } else {
                Text("No documents available")
            }
            
            Spacer()
        }
        .padding()
        .foregroundColor(.black)
        .navigationTitle("Loan Details")
    }
}

struct ZoomableView: View {
    let uiImage: UIImage
    
    var body: some View {
        VStack {
            Spacer()
            GeometryReader { geometry in
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoanDetailView(loan: LoanModel(
        id: "1",
        amount: 5000,
        interestRate: 0.8,
        term: 120,
        purpose: "Business Expansion",
        riskRating: "C",
        borrower: Borrower(
            id: "1",
            name: "Shelly Valenzuela",
            email: "shellyvalenzuela@orbaxter.com",
            creditScore: 650
        ),
        collateral: Collateral(
            type: "Real Estate",
            value: 100000
        ),
        documents: [
            Documents(type: "Income Statement", url: "/api/json/loans/documents/income_statement/slip-gaji-karyawan-pertamina.jpeg")
        ],
        repaymentSchedule: RepaymentSchedule(
            installments: [
                Installment(dueDate: "2023-01-15", amountDue: 500)
            ]
        )
    ), loanViewModel: LoanViewModel())
}
