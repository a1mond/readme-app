//
//  ContentView.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var library: Library
    @State var isModalSheetPresented = false
    var body: some View {
        NavigationView {
            List {
                Button {
                    isModalSheetPresented = true
                } label: {
                    Spacer()
                    VStack(spacing: 6.0) {
                        Image(systemName: "book.circle")
                            .font(.system(size: 60))
                        Text("Add new book")
                            .font(.title2)
                    }
                    Spacer()
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.vertical, 8)
                .sheet(isPresented: $isModalSheetPresented, content: {
                    NewBookView(book: .init(), image: nil)
                })
                
                ForEach(library.sortedBooks) { book in
                    BookRow(book: book)
                        .padding(.vertical, 5)
                }
            }
            .navigationBarTitle("My Library")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewedInAllColorSchemes
                .environmentObject(Library())
        }
    }
}



struct BookRow: View {
    @ObservedObject var book: Book
    @EnvironmentObject var library: Library
    
    var body: some View {
        NavigationLink(
            destination: DetailView(book: book),
            label: {
                HStack {
                    Book.Image(
                        uiImage: library.uiImages[book],
                        title: book.title, size: 80,
                        cornerRadius: 12
                    )
                    .padding(.trailing, 3)
                    VStack(alignment: .leading) {
                        TitleAndAuthorStack(book: book, titleFont: .title3, authorFont: .title2)
                            .lineLimit(1)
                        if !book.microReview.isEmpty {
                            Spacer()
                            Text(book.microReview)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                    }
                    Spacer()
                    BookmarkButton(book: book)
                        .buttonStyle(BorderlessButtonStyle())
                }
            })
    }
}


