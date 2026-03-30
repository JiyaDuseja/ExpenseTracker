import Foundation
import Combine
import SwiftUI

// This class acts as the data source (store) for all expenses
final class ExpenseStore: ObservableObject {
    private let storageKey = "expenses_key"
    
    // List of all expenses (published=UI updates automatically)
    @Published var expenses: [Expense] = []
    
    // Init → load saved data when app starts
        init() {
            print("loading expenses ")
            load()
        }

    
    // Add a new expense at the top of the list
    func add(_ expense: Expense) {
        expenses.insert(expense, at: 0)
        save()
    }
    
    // Delete expense using index (used for swipe-to-delete in list)
    func delete(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
        save()
    }
    
    // Delete a specific expense by matching its id
    func delete(_ expense: Expense) {
        expenses.removeAll { $0.id == expense.id}
        save()
    }
    private func save() {
        do {
            let data = try JSONEncoder().encode(expenses)
            UserDefaults.standard.set(data, forKey: storageKey)
            print("Saved \(expenses.count) expenses")
        } catch {
            print("Failed to save:", error)
        }
    }
       
       private func load() {
           guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
           
           do {
               expenses = try JSONDecoder().decode([Expense].self, from: data)
           } catch {
               print("Failed to load expenses:", error)
           }
       }
   }

