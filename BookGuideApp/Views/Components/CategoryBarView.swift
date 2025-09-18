//
//  CategoryBarView.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 18.09.2025.
//

import SwiftUI

struct CategoryBarView: View {
    @Binding var selectedCategory: String
    let categories: [String]
    let onCategoreySelected: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 4){
                ForEach(categories,id: \.self){category in
                Text(category)
                        .padding(.vertical,8)
                        .padding(.horizontal,16)
                        .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundStyle(selectedCategory == category ? .white : .black)
                        .cornerRadius(20)
                        .onTapGesture{
                            selectedCategory = category
                            onCategoreySelected(category)
                        }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical,8)
    }
}

#Preview {
    @Previewable @State var selectedCategory: String = "Roman"
    
    CategoryBarView(selectedCategory: $selectedCategory, categories:  ["Roman", "Bilim", "Tarih", "Felsefe"], onCategoreySelected: { category in
        print("Seçilen kategori: \(category)")
    })
}
