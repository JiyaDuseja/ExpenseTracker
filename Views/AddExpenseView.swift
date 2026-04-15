import SwiftUI
import SwiftData

struct AddExpenseView: View {
    
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // MARK: - ViewModel
    @StateObject private var viewModel = AddExpenseViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                
                // MARK: - Details
                Section("details_section") {
                    TextField("title_label", text: $viewModel.title)
                    
                    TextField("amount_label", text: $viewModel.amountText)
                        .keyboardType(.decimalPad)
                        .onChange(of: viewModel.amountText) { newValue in
                            viewModel.amountText = viewModel.filteredAmountInput(newValue)
                        }
                }
                
                // MARK: - Category
                Section("category_section") {
                    Picker("Category", selection: $viewModel.category) {
                        ForEach(ExpenseCategory.allCases, id: \.self) { cat in
                            Text(LocalizedStringKey(cat.localizedKey))
                                .tag(cat)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                // MARK: - Date
                Section("date_section") {
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                }
            }
            
            .navigationTitle("add_expense_title")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: - Toolbar
            .toolbar {
                
                // Cancel button
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel_button") {
                        dismiss()
                    }
                }
                
                // Save button
                ToolbarItem(placement: .confirmationAction) {
                    Button("save_button") {
                        save()
                    }
                    .disabled(!viewModel.canSave)
                }
            }
        }
    }
    
    // MARK: - Save Function
    private func save() {
        guard let expense = viewModel.buildExpense() else { return }
        
        context.insert(expense)   
        dismiss()
    }
}
