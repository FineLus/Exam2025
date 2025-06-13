
import SwiftUI

struct RootView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            ContentView()
        } else {
            LoginView()
        }
    }
}
