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
        NavigationView{
            
            VStack{
                Picker("Category", selection: $viewModel.selectedCategory){
                    ForEach(viewModel.categories,id: \.self){category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: viewModel.selectedCategory){newCategory in
                    Task{
                        await viewModel.fetchBooks(query: newCategory)
                    }
                }
            }
            
            
            if viewModel.isLoading{
                ProgressView("Loading...")
            }else if let error = viewModel.errorMessage{
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }else {
                List(viewModel.books){book in
                
                    NavigationLink(destination: BookDetailView(book: book)){
                        
                        HStack{
                            if let urlString = book.volumeInfo.imageLinks?.thumbnail,
                               let secureUrl = URL(string: urlString.replacingOccurrences(of: "http://", with: "https://")){
                                AsyncImage(url: secureUrl){image in
                                image
                                        .resizable()
                                        .scaledToFit()
                                }placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50,height: 75)
                                .cornerRadius(5)
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text(book.volumeInfo.title ?? "None")
                                .font(.headline)
                            Text(book.volumeInfo.authors?.joined(separator: ", ") ?? "None")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("Book Guide")
                
            }
        }
        .task {
            await viewModel.fetchBooks(query: "roman")
        }
    }
}

#Preview {
    BookListView()
}
