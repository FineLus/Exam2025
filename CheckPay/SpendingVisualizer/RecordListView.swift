
import SwiftUI

struct RecordListView: View {
    let records: [SpendingRecord]

    var body: some View {
        VStack(alignment: .leading) {
            Text("소비 상세 내역")
                .font(.title3)
                .padding(.horizontal)

            ForEach(records.sorted(by: { $0.date > $1.date })) { record in
                HStack {
                    VStack(alignment: .leading) {
                        Text(record.platform)
                            .font(.headline)
                        Text(dateTimeFormatter.string(from: record.date))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("₩\(Int(record.amount))")
                        .bold()
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
        }
    }
}
