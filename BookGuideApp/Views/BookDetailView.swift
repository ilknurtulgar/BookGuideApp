//
//  BookDetailView.swift
//  BookGuideApp
//
//  Created by İlknur Tulgar on 16.09.2025.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    var body: some View {
        ScrollView{
            VStack(alignment: .center,spacing: 16){
                if let urlString = book.volumeInfo.imageLinks?.thumbnail,
                   let secureUrl = URL(string: urlString.replacingOccurrences(of: "http://", with: "https://")){
                    HStack {
                        Spacer()
                        AsyncImage(url: secureUrl){image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 200)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                            
                            
                        }placeholder: {
                            Color.gray.frame(height: 100)
                        }
                        Spacer()
                    }
                }else{
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50,height: 75)
                }
                
                HStack {
                    Image(systemName: "person.fill")
                    Text(book.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown Author")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                if let published = book.volumeInfo.publisher{
                    HStack {
                        Image(systemName: "globe")
                        Text(published)
                            .font(.callout)
                            .foregroundColor(.primary)
                    }
                        
                }
                Divider()
                
                if let description = book.volumeInfo.description{
                    Text(description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                }
            }
            .padding()
        }
        
        .navigationTitle("Book Detail")
    }
}

#Preview {
    BookDetailView(book: Book(id: "123", volumeInfo: VolumeInfo(title: "Martin eden", authors: ["John", "Green"], publisher: "asdf", imageLinks: ImageLinks(thumbnail: "www.google.com"), description: "lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum, lorem ipsum,")))
}
