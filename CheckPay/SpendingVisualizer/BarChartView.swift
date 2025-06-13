
import SwiftUI
import Charts

struct BarChartView: View {
    let records: [SpendingRecord]

    var groupedData: [String: Double] {
        Dictionary(grouping: records, by: { $0.platform })
            .mapValues { $0.reduce(0) { $0 + $1.amount } }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("플랫폼별 소비 금액")
                .font(.title2)
                .padding()

            Chart {
                ForEach(groupedData.sorted(by: { $0.key < $1.key }), id: \.key) { platform, total in
                    BarMark(
                        x: .value("플랫폼", platform),
                        y: .value("총액", total)
                    )
                    .foregroundStyle(by: .value("플랫폼", platform))
                }
            }
            .frame(height: 300)
            .padding()
        }
    }
}
