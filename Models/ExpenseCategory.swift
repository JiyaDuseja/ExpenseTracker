import Foundation

enum ExpenseCategory: String, CaseIterable, Codable {
    case food = "Food"
    case transport = "Transport"
    case shopping = "Shopping"
    case bills = "Bills"
    case entertainment = "Entertainment"
    case health = "Health"
    case other = "Other"

    var localizedKey: String {
        switch self {
        case .food: return "category_food"
        case .transport: return "category_transport"
        case .shopping: return "category_shopping"
        case .bills: return "category_bills"
        case .entertainment: return "category_entertainment"
        case .health: return "category_health"
        case .other: return "category_other"
        }
    }
}
