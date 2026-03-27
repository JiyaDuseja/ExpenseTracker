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
                
                
                Section("Details") {
                    TextField("Title", text: $viewModel.title)
                    
                    
                    TextField("Amount", text: $viewModel.amountText)
                        .keyboardType(.decimalPad)
                }
                
                Section("Category") {
                    Picker("Category", selection: $viewModel.category) {
                        
                        ForEach(ExpenseCategory.allCases, id: \.self) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Date") {
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                }
            }
            
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
        
            .toolbar {
                
               
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
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
