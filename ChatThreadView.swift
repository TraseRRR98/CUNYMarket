import SwiftUI

struct ChatThreadView: View {
    let itemName: String
    let otherUser: String

    // Initialize messages AFTER properties are ready
    @State private var messages: [(sender: String, text: String)] = []
    @State private var newMessage = ""

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(Array(messages.enumerated()), id: \.offset) { index, msg in
                            HStack {
                                if msg.sender == "buyer" {
                                    Spacer()
                                    Text(msg.text)
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(10)
                                        .frame(maxWidth: 250, alignment: .trailing)
                                } else {
                                    Text(msg.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .frame(maxWidth: 250, alignment: .leading)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .onChange(of: messages.count) { _ in
                    // Auto-scroll when new message appears
                    withAnimation {
                        proxy.scrollTo(messages.count - 1, anchor: .bottom)
                    }
                }
            }

            Divider()

            // Message input
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(.roundedBorder)
                Button("Send") {
                    sendMessage()
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
            .padding()
        }
        .navigationTitle(otherUser)
        .onAppear {
            // Initialize conversation when view appears
            messages = [
                ("buyer", "Hey, is the \(itemName) still available?"),
                ("seller", "Yes!"),
                ("buyer", "Cool. Can meet today?"),
                ("seller", "Sure, BMCC cafeteria works.")
            ]
        }
    }

    // MARK: - Send logic
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        messages.append(("buyer", newMessage))
        newMessage = ""
    }
}

#Preview {
    ChatThreadView(itemName: "MacBook Air 2015", otherUser: "Daniil")
}
