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
            .searchable(text: $viewModel.searchText,prompt: "Search books")
            .onChange(of: viewModel.searchText){newValue in
                Task{
                    if newValue.isEmpty{
                        print(viewModel.selectedCategory)
                        await viewModel.fetchBooks(query: viewModel.selectedCategory.lowercased())
                    }else {
                        await viewModel.fetchBooks(query: newValue)
                    }
                }
            }
        }
        .task{
            await viewModel.fetchBooks(query: viewModel.selectedCategory)
        }
    }
}



#Preview {
    BookListView()
}
