//
//  BookViews.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

extension Book {
    struct Image: View {
        let title: String
        
        var body: some View {
            let symbol = SwiftUI.Image(title: title) ?? .init(systemName: "book")
            symbol
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .font(Font.title.weight(.light))
                .foregroundColor(.secondary)
        }
    }
}
struct Book_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Book.Image(title: "")
                .padding(.bottom)
            Book.Image(title: "N")
            Book.Image(title: "O")
            Book.Image(title: "I")
            Book.Image(title: "C")
            Book.Image(title: "E")
            Book.Image(title: "")
                .padding(.top)
        }
    }
}

extension Image {
    init?(title: String) {
        guard let character = title.first else {
            return nil
        }
        let symbolNmae = "\(character.lowercased()).square"
        self.init(systemName: symbolNmae)
    }
}
