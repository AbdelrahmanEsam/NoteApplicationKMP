import SwiftUI
import shared

@main
struct iOSApp: App {
    
    init() {
        CommonCompnentKt.doInitKoin()
      }
    
	var body: some Scene {
		WindowGroup {
			NotesScreenView()
		}
	}
}
