
import SwiftUI

class AppHideControl: ObservableObject {
    
    static let shared = AppHideControl()
    
    @Published var zIndex: Double = -1.0
    
    func showLoading() {
        zIndex = 1.0
    }
    
    func hideLoading() {
        zIndex = -1.0
    }
}
