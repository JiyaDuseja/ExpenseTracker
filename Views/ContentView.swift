import SwiftUI

// Main screen showing list of expenses
struct ContentView: View {
    
    // ViewModel that manages expenses data
    @StateObject private var viewModel: ExpensesListViewModel
    
    // Controls whether Add Expense screen is shown
    @State private var isPresentingAdd = false

    // Initialize ViewModel with the shared store
    init(store: ExpenseStore) {
        _viewModel = StateObject(wrappedValue: ExpensesListViewModel(store: store))
    }

    var body: some View {
        NavigationStack {
            VStack {

                // Filter picker (All / Today / Week / Month)
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    ForEach(ExpenseFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                List {
                    
                    // Show empty state if no expenses
                    if viewModel.filteredExpenses.isEmpty {
                        ContentUnavailableView(
                            "No expenses yet",
                            systemImage: "tray",
                            description: Text("Tap + to add your first expense.")
                        )
                    } else {
                        
                        Section {
                            // Loop through filtered expenses
                            ForEach(viewModel.filteredExpenses) { expense in
                                ExpenseRowView(expense: expense)
                            }
                            
                            // Swipe to delete
                            .onDelete(perform: viewModel.delete)
                            
                        } header: {
                            
                            // Section header showing total amount
                            HStack {
                                Text("Total")
                                Spacer()
                                
                                // Display total in currency format
                                Text(
                                    viewModel.total,
                                    format: .currency(code: Locale.current.currency?.identifier ?? "INR")
                                )
                                .fontWeight(.semibold)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            
            // Screen title
            .navigationTitle("Expenses")
            
            // Top-right + button
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Open Add Expense screen
                        isPresentingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            
            // Present Add Expense screen as a sheet
            .sheet(isPresented: $isPresentingAdd) {
                AddExpenseView { expense in
                    
                    // Add new expense to list
                    viewModel.add(expense)
                }
            }
        }
    }
}
