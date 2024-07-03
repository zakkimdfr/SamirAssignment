//
//  Hellow.swift
//  SamirAssignment
//
//  Created by Zakki Mudhoffar on 03/07/24.
//

import SwiftUI

struct ZoomableImage: View {
    @State private var zoomed = false
    
    var body: some View {
        VStack {
            if zoomed {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            zoomed.toggle()
                        }
                    }
            } else {
                Button(action: {
                    withAnimation {
                        zoomed.toggle()
                    }
                }) {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipped()
                }
            }
        }
    }
}

struct ZoomView: View {
    @State private var showZoomedView = false
    
    var body: some View {
        Button(action: {
            showZoomedView.toggle()
        }) {
            Text("Zoom Gambar")
                .padding()
        }
        .sheet(isPresented: $showZoomedView) {
            ZoomableImage()
        }
    }
}

#Preview {
    ZoomableImage()
}
