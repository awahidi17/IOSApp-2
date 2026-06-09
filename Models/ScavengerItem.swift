import SwiftUI

// Model that stores one scavenger hunt item.
struct ScavengerItem: Identifiable {
    let id = UUID()
    let name: String          // Name of the hidden item
    let clue: String          // Clue used to find the item
    let businessName: String  // Local business location
    let imageName: String     // Asset catalog image name
    var isFound: Bool = false // Found status
    var photo: UIImage? = nil // Photo proof for the item
}

// The 10 sample hunt items used in the app.
extension ScavengerItem {
    static let allItems: [ScavengerItem] = [
        ScavengerItem(name: "Golden Fork", clue: "Look near the front menu display.", businessName: "Downtown Restaurant", imageName: "item_fork"),
        ScavengerItem(name: "Red Bookmark", clue: "Check beside the mystery books.", businessName: "City Bookstore", imageName: "item_bookmark"),
        ScavengerItem(name: "Movie Ticket", clue: "Search close to the popcorn counter.", businessName: "Local Cinema", imageName: "item_ticket"),
        ScavengerItem(name: "Blue Coffee Cup", clue: "Look beside the espresso machine.", businessName: "Coffee Corner", imageName: "item_coffee"),
        ScavengerItem(name: "Mini Trophy", clue: "Find it near the sports gear wall.", businessName: "Sports Store", imageName: "item_trophy"),
        ScavengerItem(name: "Vintage Coin", clue: "Ask near the display case.", businessName: "Jewellery Shop", imageName: "item_coin"),
        ScavengerItem(name: "Green Keychain", clue: "Check by the entrance plants.", businessName: "Plant Shop", imageName: "item_keychain"),
        ScavengerItem(name: "Recipe Card", clue: "Look next to the fresh bread.", businessName: "Local Bakery", imageName: "item_recipe"),
        ScavengerItem(name: "Wooden Spoon", clue: "Search near the cooking supplies.", businessName: "Market Store", imageName: "item_spoon"),
        ScavengerItem(name: "Chamber Seal", clue: "The final item is near the welcome desk.", businessName: "Chamber of Commerce", imageName: "item_seal")
    ]
}
