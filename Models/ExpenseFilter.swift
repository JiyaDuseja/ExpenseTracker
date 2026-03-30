import Foundation
enum ExpenseFilter: String, CaseIterable, Identifiable {
    
    case all = "All"
    case today = "Today"
    case week = "This Week"
    case month = "This Month"
    
    // Conforming to Identifiable
    var id: String { rawValue }
    
    var localizedKey: String {
        switch self {
        case .all: return "filter_all"
        case .today: return "filter_today"
        case .week: return "filter_week"
        case .month: return "filter_month"
        }
    }
}
