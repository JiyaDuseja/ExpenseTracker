import Foundation
import Combine

// logic for adding exoense
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
        return Expense(title: trimmedTitle, amount: amount,  date: date, category: category,)
    }
    
    // This function filters the input to allow only valid decimal numbers
    func filteredAmountInput(_ input: String) -> String {
        // First normalize any Hindi numerals to English
        let normalized = normalizeNumber(input)
        
        // Allow only digits and decimal point
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let filtered = normalized.filter { char in
            char.unicodeScalars.allSatisfy { allowedCharacters.contains($0) }
        }
        
        // Ensure only one decimal point
        let components = filtered.components(separatedBy: ".")
        if components.count > 2 {
            // If more than one decimal point, keep only the first one
            return components[0] + "." + components[1...].joined()
        }
        
        return filtered
    }
    
    private func normalizeNumber(_ input: String) -> String {
        let hindiToEnglishMap: [Character: Character] = [
            "०":"0","१":"1","२":"2","३":"3","४":"4",
            "५":"5","६":"6","७":"7","८":"8","९":"9"
        ]
        
        return String(input.map { hindiToEnglishMap[$0] ?? $0 })
    }
}

