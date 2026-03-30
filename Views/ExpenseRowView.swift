import SwiftUI

// View to display a single expense row in the list
struct ExpenseRowView: View {
    
    // The expense data passed into this row
    let expense: Expense

    // Formats the date into a readable string (e.g., Mar 17, 2026)
    private var formattedDate: String {
        expense.date.formatted(date: .abbreviated, time: .omitted)
    }

    var body: some View {
        HStack {
            
            // Left side: title, category, and date
            VStack(alignment: .leading, spacing: 4) {
                
                // Expense title
                Text(expense.title)
                    .font(.headline)
                
                // Expense category
                Text(LocalizedStringKey(expense.category.localizedKey))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // Formatted date
                Text(formattedDate)
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            
            Spacer()
            
            // Right side: amount
            Text(
                expense.amount,
                format: .currency(code: Locale.current.currency?.identifier ?? "INR")
            )
                .font(.headline)
                .foregroundStyle(.primary)
        }
        
        // Adds some vertical spacing between rows
        .padding(.vertical, 4)
    }
}
