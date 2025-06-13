
import SwiftUI

struct CalendarChartView: View {
    let records: [SpendingRecord]

    var dailySpending: [Date: Double] {
        Dictionary(grouping: records, by: { Calendar.current.startOfDay(for: $0.date) })
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
    }

    var currentMonthDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let range = calendar.range(of: .day, in: .month, for: today)!
        let components = calendar.dateComponents([.year, .month], from: today)
        let firstDay = calendar.date(from: components)!

        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: firstDay)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("이번 달 소비 캘린더")
                .font(.title2)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(currentMonthDates, id: \.self) { date in
                    let amount = dailySpending[Calendar.current.startOfDay(for: date)] ?? 0.0
                    VStack {
                        Text("\(Calendar.current.component(.day, from: date))")
                            .font(.caption)

                        Circle()
                            .fill(amount > 0 ? Color.red.opacity(min(amount / 10000, 1)) : Color.gray.opacity(0.2))
                            .frame(width: 24, height: 24)

                        if amount > 0 {
                            Text("₩\(Int(amount))")
                                .font(.footnote)
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
