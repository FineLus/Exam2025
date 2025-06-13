
import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var selectedPlatform: String? = nil

    let sampleRecords: [SpendingRecord] = [
        SpendingRecord(platform: "넥슨", date: dateFrom("2025-06-13 08:00"), amount: 5000),
        SpendingRecord(platform: "스팀", date: dateFrom("2025-06-13 17:00"), amount: 12000),
        SpendingRecord(platform: "구글 플레이", date: dateFrom("2025-06-12 15:30"), amount: 3000),
        SpendingRecord(platform: "스팀", date: dateFrom("2025-06-10 20:00"), amount: 22000),
        SpendingRecord(platform: "넥슨", date: dateFrom("2025-06-09 11:15"), amount: 7000)
    ]

    var filteredRecords: [SpendingRecord] {
        if let platform = selectedPlatform {
            return sampleRecords.filter { $0.platform == platform }
        }
        return sampleRecords
    }

    var platforms: [String] {
        Array(Set(sampleRecords.map { $0.platform })).sorted()
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("플랫폼 선택", selection: $selectedPlatform) {
                        Text("전체").tag(String?.none)
                        ForEach(platforms, id: \.self) { platform in
                            Text(platform).tag(String?.some(platform))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    BarChartView(records: filteredRecords)
                    Divider()
                    CalendarChartView(records: filteredRecords)
                    Divider()
                    RecordListView(records: filteredRecords)
                }
            }
            .navigationTitle("소비 분석")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("계정 전환") {
                        isLoggedIn = false
                    }
                }
            }
        }
    }
}

func dateFrom(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter.date(from: string) ?? Date()
}

let dateTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "M월 d일 (E) a h시 mm분"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter
}()
