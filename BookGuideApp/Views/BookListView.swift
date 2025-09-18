//
//  BookListView.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 16.09.2025.
//

import SwiftUI

struct BookListView: View {
    @StateObject var viewModel = BookViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CategoryBarView(selectedCategory: $viewModel.selectedCategory, categories: viewModel.categories){
                    category in
                    print("click: \(category)")
                    Task{
                        await viewModel.fetchBooks(query: category.lowercased())
                    }
                }

                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading...")
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                } else {
                    List(viewModel.books) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                          BookRowView(book: book)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Book Guide")
        }
        .task{
            await viewModel.fetchBooks(query: "roman")
        }
    }
}



#Preview {
    BookListView()
}
