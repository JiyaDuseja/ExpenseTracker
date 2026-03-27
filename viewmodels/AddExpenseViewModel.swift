import Foundation
import Combine

// This ViewModel handles all the logic for adding a new expense
@MainActor
final class AddExpenseViewModel: ObservableObject {
    
    // Stores the amount entered by the user as text
    @Published var amountText: String = ""
    
    // Stores the title/description of the expense
    @Published var title: String = ""
    
    // Stores the selected category, default is "other"
    @Published var category: ExpenseCategory = .other
    
    // Stores the selected date, default is current date
    @Published var date: Date = Date()

    // This checks whether the Save button should be enabled or not
    var canSave: Bool {
        // Convert amountText to Double and >0
        // Make sure title is not empty
        guard let amount = Double(amountText), amount > 0 else { return false }
        
        return !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    // This function creates an Expense object if all inputs are valid
    func buildExpense() -> Expense? {
        
        // Convert amount and check if it's valid
        guard let amount = Double(amountText), amount > 0 else { return nil }
        
        // Remove extra spaces from title
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure title is not empty
        guard !trimmedTitle.isEmpty else { return nil }
        
        // If everything is valid, return a new Expense object
        return Expense(amount: amount, title: trimmedTitle, category: category, date: date)
    }
}
