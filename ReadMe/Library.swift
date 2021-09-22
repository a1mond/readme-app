import class UIKit.UIImage
import Combine

enum Section: CaseIterable {
    case readMe
    case finished
}

final class Library: ObservableObject {
    var sortedBooks: [Book] { booksCache }
    
    var manuallySortedBooks: [Section: [Book]] {
        Dictionary(grouping: booksCache, by: \.readMe)
            .mapKeys(Section.init)
    }
    
    func addNewBook(_ book: Book, image: UIImage?) {
        booksCache.insert(book, at: 0)
        uiImages[book] = image
    }
    /// An in-memory cache of the manually-sorted books that are persistently stored.
    @Published private var booksCache: [Book] = [
        .init(title: "Ein Neues Land", author: "Shaun Tan", microReview: "Brilliant!"),
        .init(title: "Bosch", author: "Laurinda Dixon"),
        .init(title: "Dare to Lead", author: "Brené Brown"),
        .init(title: "Blasting for Optimum Health Recipe Book", author: "NutriBullet", microReview: "Awesome!")
    ]
    
    @Published var uiImages: [Book: UIImage] = [:]
}
private extension Section {
    init(readMe: Bool) {
        self = readMe ? .readMe : .finished
    }
}
private extension Dictionary {
    /// Same values, corresponding to `map`ped keys.
    ///
    /// - Parameter transform: Accepts each key of the dictionary as its parameter
    ///   and returns a key for the new dictionary.
    /// - Postcondition: The collection of transformed keys must not contain duplicates.
    func mapKeys<Transformed>(
        _ transform: (Key) throws -> Transformed
    ) rethrows -> [Transformed: Value] {
        .init(
            uniqueKeysWithValues: try map { (try transform($0.key), $0.value) }
        )
    }
}
