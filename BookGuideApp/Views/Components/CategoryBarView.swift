//
//  CategoryBarView.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 18.09.2025.
//

import SwiftUI

struct CategoryBarView: View {
    @Binding var selectedCategory: Category
    @Binding var searchText: String
    let categories: [Category]
    let onCategoreySelected: (Category) -> Void
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 10){
                ForEach(categories,id: \.title){category in
                    Text(category.title)
                        .padding(.vertical,8)
                        .padding(.horizontal,16)
                        .background(searchText.isEmpty && selectedCategory.title == category.title ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundStyle(searchText.isEmpty && selectedCategory.title == category.title ? .white : .black)
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
    @Previewable @State var selectedCategory: Category = Category(title: "Novel", query: "novel")
    @Previewable @State var searchText: String = "etc"
    
    CategoryBarView(selectedCategory: $selectedCategory, searchText: $searchText, categories: [ Category(title: "Novel", query: "novel"),
                    Category(title: "Science", query: "science"),
                    Category(title: "History", query: "history"),
                    Category(title: "Philosophy", query: "philosophy")], onCategoreySelected: { category in
        print("Seçilen kategori: \(category)")
    })
}
