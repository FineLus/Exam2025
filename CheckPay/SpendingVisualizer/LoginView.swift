
import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var name = ""
    @State private var phone = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("로그인")
                    .font(.largeTitle)
                    .bold()

                TextField("이름", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                TextField("전화번호", text: $phone)
                    .keyboardType(.phonePad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    if !name.isEmpty && !phone.isEmpty {
                        isLoggedIn = true
                    }
                }) {
                    Text("로그인")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
        }
    }
}
