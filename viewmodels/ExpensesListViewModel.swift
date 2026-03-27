import Foundation
import Combine

//manages the list of expenses and related actions no logic modify
@MainActor
final class ExpensesListViewModel: ObservableObject {

    // List of all expns
    @Published private(set) var expenses: [Expense] = []
    @Published var selectedFilter: ExpenseFilter = .all
    private let store: ExpenseStore

    // Initialize with store and keep expenses in sync
    init(store: ExpenseStore) {
        self.store = store
        
        // Listen to changes from store and update local expenses
        store.$expenses
            .receive(on: RunLoop.main)
            .assign(to: &$expenses)
    }

    // Add a new expense
    func add(_ expense: Expense) {
        store.add(expense)
    }

    // Delete expense using index (used in list swipe delete)
    func delete(at offsets: IndexSet) {
        store.delete(at: offsets)
    }

    // Delete a specific expense
    func delete(_ expense: Expense) {
        store.delete(expense)
    }

    //Filtering Logic

    // Returns expenses based on selected filter
    var filteredExpenses: [Expense] {
        let calendar = Calendar.current
        let now = Date()

        switch selectedFilter {

        case .all:
            // Show all expenses
            return expenses

        case .today:
            // Show only today's expenses
            return expenses.filter {
                calendar.isDate($0.date, inSameDayAs: now)
            }

        case .week:
            // Show expenses from current week
            return expenses.filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .weekOfYear)
            }

        case .month:
            // Show expenses from current month
            return expenses.filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .month)
            }
        }
    }

    var total: Double {
        filteredExpenses.reduce(0) { $0 + $1.amount }
    }
}
