import Foundation
import SwiftData

@Model
class Expense {
    var id: UUID
    var title: String
    var amount: Double
    var date: Date
    var category: ExpenseCategory
    
    init(
        id: UUID = UUID(),
        title: String,
        amount: Double,
        date: Date,
        category: ExpenseCategory   
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
        self.category = category
    }
}
