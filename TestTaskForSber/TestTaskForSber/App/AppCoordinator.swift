import UIKit
import Foundation
import SwiftUI

final class AppCoordinator: ObservableObject {
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func showRootView() {
        let navController = UINavigationController()
        let mainViewCoodintor = MainViewCoordinator(navigationController: navController)
        window?.rootViewController = navController
        mainViewCoodintor.openMainView()
    }
}
 
