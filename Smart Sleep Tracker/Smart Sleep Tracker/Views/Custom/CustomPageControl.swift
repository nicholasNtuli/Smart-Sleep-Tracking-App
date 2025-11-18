//
//  CustomPageControl.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/18.
//

import SwiftUI

struct CustomPageControl: View {
    @Binding var currentPage: Int
    let totalPages: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(.white)
                    .frame(
                        width: currentPage == index ? 24 : 8,
                        height: 4
                    )
                    .opacity(currentPage == index ? 1 : 0.4)
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
            }
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            CustomPageControl(currentPage: .constant(0), totalPages: 3)
            Spacer()
        }
        .padding(.top, 20)
    }
}
