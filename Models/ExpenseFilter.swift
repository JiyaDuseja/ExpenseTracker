import Foundation
enum ExpenseFilter: String, CaseIterable, Identifiable {
    
    case all = "All"
    case today = "Today"
    case week = "This Week"
    case month = "This Month"

    // Conforming to Identifiable
    var id: String { rawValue }
}
