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
        let normalized = normalizeNumber(amountText)
        
        guard let amount = Double(normalized), amount > 0 else { return false }
        
        // Remove extra spaces from title
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure title is not empty
        guard !trimmedTitle.isEmpty else { return false }
        
        return true
    }
    
    // This function creates an Expense object if all inputs are valid
    func buildExpense() -> Expense? {
        
        // Convert amount and check if it's valid
        let normalized = normalizeNumber(amountText)
        
        guard let amount = Double(normalized), amount > 0 else { return nil }
        
        // Remove extra spaces from title
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make sure title is not empty
        guard !trimmedTitle.isEmpty else { return nil }
        
        // If everything is valid, return a new Expense object
        return Expense(amount: amount, title: trimmedTitle, category: category, date: date)
    }
}
    private func normalizeNumber(_ input: String) -> String {
        let hindiToEnglishMap: [Character: Character] = [
            "०":"0","१":"1","२":"2","३":"3","४":"4",
            "५":"5","६":"6","७":"7","८":"8","९":"9"
        ]
        
        return String(input.map { hindiToEnglishMap[$0] ?? $0 })
    }

