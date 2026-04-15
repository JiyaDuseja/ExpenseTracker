import Foundation
import Observation

@MainActor
@Observable
final class ExpensesListViewModel {
    
    var selectedFilter: ExpenseFilter = .all


    // Filtering Logic (now takes input instead of storing data)
    func filteredExpenses(from expenses: [Expense]) -> [Expense] {
        let calendar = Calendar.current
        let now = Date()

        switch selectedFilter {

        case .all:
            return expenses

        case .today:
            return expenses.filter {
                calendar.isDate($0.date, inSameDayAs: now)
            }

        case .week:
            return expenses.filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .weekOfYear)
            }

        case .month:
            return expenses.filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .month)
            }
        }
    }

    func total(from expenses: [Expense]) -> Double {
        filteredExpenses(from: expenses).reduce(0) { $0 + $1.amount }
    }
}
