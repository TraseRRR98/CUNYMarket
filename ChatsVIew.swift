import SwiftUI

struct ChatsView: View {
    @State private var selectedTab = "Buying"

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Chat Type", selection: $selectedTab) {
                    Text("Buying").tag("Buying")
                    Text("Selling").tag("Selling")
                }
                .pickerStyle(.segmented)
                .padding()

                List {
                    if selectedTab == "Buying" {
                        NavigationLink(destination: ChatThreadView(itemName: "MacBook Air 2015", otherUser: "Daniil")) {
                            ChatRow(
                                name: "Daniil",
                                item: "MacBook Air 2015",
                                lastMessage: "Sure, can meet at BMCC lobby.",
                                time: "2:14 PM"
                            )
                        }
                        NavigationLink(destination: ChatThreadView(itemName: "Dorm Lamp", otherUser: "Jamie")) {
                            ChatRow(
                                name: "Jamie",
                                item: "Dorm Desk Lamp",
                                lastMessage: "It’s still available!",
                                time: "Yesterday"
                            )
                        }
                    } else {
                        NavigationLink(destination: ChatThreadView(itemName: "Calculator", otherUser: "Alex")) {
                            ChatRow(
                                name: "Alex",
                                item: "TI-84 Calculator",
                                lastMessage: "Can I get it tomorrow?",
                                time: "11:45 AM"
                            )
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Chats")
        }
    }
}

struct ChatRow: View {
    var name: String
    var item: String
    var lastMessage: String
    var time: String

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 45, height: 45)
                .foregroundColor(.blue)
                .padding(.trailing, 6)

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                Text(item)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(lastMessage)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
            Text(time)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}
