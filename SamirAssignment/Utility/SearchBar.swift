//
//  SearchBar.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 03/07/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search by name...", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
