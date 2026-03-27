import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    // Single source of truth for expns
    @StateObject private var store = ExpenseStore()
    
    var body: some Scene {
        WindowGroup {
            // Pass the SAME store everywhere
            ContentView(store: store)
        }
    }
}
