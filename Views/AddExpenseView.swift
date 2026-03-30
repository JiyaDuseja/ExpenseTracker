import SwiftUI

// This view is used to add a new expense
struct AddExpenseView: View {
    
    // Used to dismiss (close) the screen
    @Environment(\.dismiss) private var dismiss
    
    // Callback to send the new expense back to the parent view
    let onSave: (Expense) -> Void

    // ViewModel to manage form data and validation
    @StateObject private var viewModel = AddExpenseViewModel()

    var body: some View {
        NavigationStack {
            Form {
                
                
                Section("details_section") {
                    TextField("title_label", text: $viewModel.title)
                    
                    
                    TextField("amount_label", text: $viewModel.amountText)
                        .keyboardType(.decimalPad)
                }
                
                Section("category_section") {
                    Picker("Category", selection: $viewModel.category) {
                        
                        ForEach(ExpenseCategory.allCases, id: \.self) { cat in
                            Text(LocalizedStringKey(cat.localizedKey)).tag(cat)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("date_section") {
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                }
            }
            
            .navigationTitle("add_expense_title")
            .navigationBarTitleDisplayMode(.inline)
        
            .toolbar {
                
               
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel_button") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("save_button") { save() }
                        .disabled(!viewModel.canSave)
                }
            }
        }
    }

    private func save() {
        
        // Create expense only if data is valid
        guard let expense = viewModel.buildExpense() else { return }
        
        // Send expense back to parent view
        onSave(expense)
        dismiss()
    }
}
