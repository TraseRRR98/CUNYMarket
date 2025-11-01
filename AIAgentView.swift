import SwiftUI

struct AIAgentView: View {
    @State private var messages: [Message] = [
        Message(text: "👋 Hi! I’m CUNY AI — here to help you safely buy, sell, or find resources!", isUser: false)
    ]
    @State private var userInput: String = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(messages) { msg in
                                HStack {
                                    if msg.isUser {
                                        Spacer()
                                        Text(msg.text)
                                            .padding()
                                            .foregroundColor(.white)
                                            .background(Color.blue)
                                            .cornerRadius(14)
                                            .frame(maxWidth: 250, alignment: .trailing)
                                    } else {
                                        HStack(alignment: .top) {
                                            Text("🤖")
                                            Text(msg.text)
                                                .padding()
                                                .background(Color(.systemGray5))
                                                .cornerRadius(14)
                                                .frame(maxWidth: 250, alignment: .leading)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }

                Divider()
                HStack {
                    TextField("Ask AI...", text: $userInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button("Send") {
                        sendMessage()
                    }
                    .padding(.trailing)
                    .buttonStyle(.borderedProminent)
                }
                .padding(.bottom)
            }
            .navigationTitle("CUNY AI Assistant 🤖")
        }
    }

    // MARK: - Send Message Logic
    func sendMessage() {
        let userMsg = Message(text: userInput, isUser: true)
        messages.append(userMsg)
        let response = generateAIResponse(for: userInput)
        messages.append(Message(text: response, isUser: false))
        userInput = ""
    }

    // MARK: - Smart AI Logic
    func generateAIResponse(for input: String) -> String {
        let lower = input.lowercased()

        // 💻 MacBook Air response
        if lower.contains("macbook air 2015") || lower.contains("mac air") || lower.contains("macbook") {
            return "💻 The typical price range for a **MacBook Air 2015** is **$150–$200**, depending on its condition and storage. Remember to meet in public and verify student ID!"
        }

        // 🧮 Calculator
        if lower.contains("calculator") || lower.contains("ti-84") {
            return "🧮 The TI-84 Calculator usually goes for **$50–$70** in used condition."
        }

        // 📘 Textbooks
        if lower.contains("textbook") || lower.contains("book") {
            return "📚 Textbook prices vary, but most students list them for **$30–$60** depending on the course and edition."
        }

        // 🪑 Furniture
        if lower.contains("chair") || lower.contains("lamp") || lower.contains("desk") {
            return "🪑 Dorm furniture typically ranges between **$20–$80** depending on the item."
        }

        // 🏦 Payment help
        if lower.contains("payment") || lower.contains("zelle") || lower.contains("cashapp") {
            return "🏦 To share your payment info, go to **Payments tab → Share in Chat**. Your info stays private until you decide to share."
        }

        // Default friendly fallback
        return "🤖 AI: That’s a great question! Please provide more details or item name, and I’ll try to estimate its price range for you."
    }
}

// MARK: - Message Model
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

#Preview {
    AIAgentView()
}
