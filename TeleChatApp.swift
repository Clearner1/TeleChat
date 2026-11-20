import SwiftUI

@main
struct TeleChatApp: App {
    var body: some Scene {
        WindowGroup("TeleChat") {
            ChatView()
        }
        .defaultSize(width: 620, height: 500)
    }
}
