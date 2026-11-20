import SwiftUI

struct ChatView: View {
    @State private var draft = ""
    // shortcut: Messages reset on relaunch; add storage when chat history is needed.
    @State private var messages = [
        Message(author: "Maya", text: "Still up for coffee on Saturday?", outgoing: false),
        Message(author: "You", text: "Yes! How about 10 at the usual spot?", outgoing: true),
        Message(author: "Maya", text: "Perfect. See you there ☕", outgoing: false)
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .font(.title2)
                    .foregroundStyle(.indigo)
                    .padding(10)
                    .background(.indigo.opacity(0.12), in: .rect(cornerRadius: 12))
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 3) {
                    Text("TeleChat").font(.title2.bold())
                    Text("Coffee plans · Local demo")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding()
            Divider()
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(messages) { message in
                        VStack(alignment: message.outgoing ? .trailing : .leading, spacing: 4) {
                            Text(message.author).font(.caption).foregroundStyle(.secondary)
                            Text(message.text)
                                .padding(10)
                                .background(
                                    message.outgoing ? Color.indigo.opacity(0.16) : Color.secondary.opacity(0.12),
                                    in: .rect(cornerRadius: 14)
                                )
                        }
                        .frame(maxWidth: .infinity, alignment: message.outgoing ? .trailing : .leading)
                    }
                }
                .padding()
            }
            .defaultScrollAnchor(.bottom)
            Divider()
            HStack {
                TextField("Write a message…", text: $draft)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit(send)
                Button("Send", systemImage: "paperplane.fill", action: send)
                    .buttonStyle(.borderedProminent)
                    .tint(.indigo)
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding()
        }
    }

    private func send() {
        guard let message = Message.draft(draft) else { return }
        messages.append(message)
        draft = ""
    }
}
