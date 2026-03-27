import Foundation
import Combine
import SwiftUI

// This class acts as the data source (store) for all expenses
final class ExpenseStore: ObservableObject {
    
    // List of all expenses (published=UI updates automatically)
    @Published var expenses: [Expense] = []
    
    // Add a new expense at the top of the list
    func add(_ expense: Expense) {
        expenses.insert(expense, at: 0)
    }
    
    // Delete expense using index (used for swipe-to-delete in list)
    func delete(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
    
    // Delete a specific expense by matching its id
    func delete(_ expense: Expense) {
        expenses.removeAll { $0.id == expense.id }
    }
}
