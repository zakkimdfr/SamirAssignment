//
//  SortOptionsView.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 03/07/24.
//

import SwiftUI

struct SortOptionsView: View {
    @Binding var sortOption: SortOption
    @Binding var ascending: Bool
    
    var body: some View {
        HStack {
            Menu {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Button(action: {
                        sortOption = option
                    }) {
                        Text(option.rawValue.capitalized)
                    }
                }
            } label: {
                HStack {
                    Text("Sort by:")
                    Text(sortOption.rawValue.capitalized)
                        .fontWeight(.bold)
                    Image(systemName: "chevron.down")
                }
                .background(Color(.systemGray6))
                .padding(.horizontal)
                .foregroundColor(.black)
                .cornerRadius(8)
            }
            
            Spacer()
            
            Button(action: {
                ascending.toggle()
            }) {
                HStack(spacing: 0) {
                    VStack(spacing: -2) {
                        Text("A")
                        Text("Z")
                    }
                    .font(.caption)
                    Image(systemName: ascending ? "arrow.up" : "arrow.down")
                }
                .background(Color(.systemGray6))
                .padding(.trailing)
                .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
    }
}

enum SortOption: String, CaseIterable, Identifiable {
    case name, amount, term, purpose
    var id: String { self.rawValue }
}

#Preview {
    SortOptionsView(sortOption: .constant(.name), ascending: .constant(true))
}

