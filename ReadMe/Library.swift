import class UIKit.UIImage
import Combine

class Library: ObservableObject {
    var sortedBooks: [Book] { booksCache }
    
    func addNewBook(_ book: Book, image: UIImage?) {
        booksCache.insert(book, at: 0)
        uiImages[book] = image
    }
    /// An in-memory cache of the manually-sorted books that are persistently stored.
    @Published private var booksCache: [Book] = [
        .init(title: "Ein Neues Land", author: "Shaun Tan"),
        .init(title: "Bosch", author: "Laurinda Dixon"),
        .init(title: "Dare to Lead", author: "Brené Brown"),
        .init(title: "Blasting for Optimum Health Recipe Book", author: "NutriBullet"),
        .init(title: "Drinking with the Saints", author: "Michael P. Foley"),
        .init(title: "A Guide to Tea", author: "Adagio Teas"),
        .init(title: "The Life and Complete Work of Francisco Goya", author: "P. Gassier & J Wilson"),
        .init(title: "Lady Cottington's Pressed Fairy Book", author: "Lady Cottington"),
        .init(title: "How to Draw Cats", author: "Janet Rancan"),
        .init(title: "Drawing People", author: "Barbara Bradley"),
        .init(title: "What to Say When You Talk to Yourself", author: "Shad Helmstetter")
    ]
    
    @Published var uiImages: [Book: UIImage] = [:]
}
