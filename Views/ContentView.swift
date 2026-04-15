import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @State private var viewModel = ExpensesListViewModel()
    @Query private var expenses: [Expense]
    
    @State private var isPresentingAdd = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                Text("Total: \(viewModel.total(from: expenses), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.title2.bold())
                    .padding(.horizontal)
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    Text("All").tag(ExpenseFilter.all)
                    Text("Today").tag(ExpenseFilter.today)
                    Text("Week").tag(ExpenseFilter.week)
                    Text("Month").tag(ExpenseFilter.month)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                if viewModel.filteredExpenses(from: expenses).isEmpty {
                    VStack {
                        Spacer()
                        Text("No expenses yet")
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                } else {
                
                    List {
                        ForEach(viewModel.filteredExpenses(from: expenses)) { expense in
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text(expense.title)
                                    .font(.headline)
                                
                                Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                                
                                Text(expense.date, format: .dateTime.day().month().year())
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(expenses[index])
                            }
                        }
                    }
                }
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button("+") {
                    isPresentingAdd = true
                }
            }
            .sheet(isPresented: $isPresentingAdd) {
                AddExpenseView()
            }
        }
    }
}
