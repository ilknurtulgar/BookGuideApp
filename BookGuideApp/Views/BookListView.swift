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
        NavigationStack {
            VStack {
               SearchBarView(text: $viewModel.searchText, placeholder: "Search books")
                    .padding(.top, 8)
                CategoryBarView(selectedCategory: $viewModel.selectedCategory, searchText: $viewModel.searchText, categories: viewModel.categories){
                    category in
                    Task{
                        await viewModel.fetchBooks(query: category.query)
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
                }else if viewModel.isGridView {
                    ScrollView{
                        LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], spacing: 5){
                            ForEach(viewModel.books){book in
                                NavigationLink(destination: BookDetailView(book: book)){
                                    BookGridItemView(book: book)
                                }
                            }
                        }
                    }
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
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {viewModel.isGridView.toggle()}){
                        Image(systemName: viewModel.isGridView ? "square.grid.2x2" : "list.bullet"  )
                    }
                }
            }
            .onChange(of: viewModel.searchText){newValue in
                Task{
                    if newValue.isEmpty{
                        await viewModel.fetchBooks(query: viewModel.selectedCategory.query)
                    }else {
                        await viewModel.fetchBooks(query: newValue)
                    }
                }
            }

        }
        .task{
            await viewModel.fetchBooks(query: viewModel.selectedCategory.query)
        }
    }
}



#Preview {
    BookListView()
}
