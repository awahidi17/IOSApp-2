import Foundation
import SwiftUI

// ViewModel that manages hunt progress and reward logic.
@Observable
class HuntSession {

    var items: [ScavengerItem] = ScavengerItem.allItems
    
    // Counts how many items were found.
    var foundCount: Int {
        items.filter { $0.isFound }.count
    }
    
    // Checks if all items were found.
    var allFound: Bool {
        foundCount == items.count
    }
    
    // Gives a discount code based on the number of found items.
    var discountCode: String? {
        if foundCount >= 10 { return "AHMAD-GRAND20" }
        if foundCount >= 7  { return "AHMAD-HUNT20" }
        if foundCount >= 5  { return "AHMAD-HUNT10" }
        return nil
    }
    
    // Marks an item as found and saves its photo.
    func markAsFound(id: UUID, photo: UIImage) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].isFound = true
            items[index].photo = photo
        }
    }

    // Marks a set number of items as found for quick testing.
    // Uses each item's matching asset image so the photo slot isn't empty.
    func simulateFound(_ count: Int) {
        for i in 0..<min(count, items.count) {
            items[i].isFound = true
            items[i].photo = UIImage(named: items[i].imageName) ?? UIImage()
        }
    }

    // Resets all items back to not found.
    func resetHunt() {
        items = ScavengerItem.allItems
    }
}
