import Foundation

struct Message: Identifiable {
    let id = UUID()
    let author: String
    let text: String
    let outgoing: Bool

    static func draft(_ text: String) -> Self? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return Self(author: "You", text: trimmed, outgoing: true)
    }
}
