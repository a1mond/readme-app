//
//  DetailView.swift
//  ReadMe
//
//  Created by Владислав Котик on 09/09/2021.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    var body: some View {
        VStack {
            Book.Image(title: book.title)
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(book: .init())
    }
}
