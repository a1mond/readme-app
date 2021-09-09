//
//  ContentView.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(Library().sortedBooks, id: \.title) { book in
                BookRow(book: book)
            }
            .navigationBarTitle("My Library")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}



struct BookRow: View {
    let book: Book
    
    var body: some View {
        NavigationLink(
            destination: DetailView(book: book),
            label: {
                HStack {
                    Book.Image(title: book.title, size: 80)
                        .padding(.trailing, 3)
                    TitleAndAuthorStack(book: book, titleFont: .title3, authorFont: .title2)
                        .lineLimit(1)
                }
            })
    }
}


