
import Foundation

struct SpendingRecord: Identifiable {
    let id = UUID()
    let platform: String
    let date: Date
    let amount: Double
}
