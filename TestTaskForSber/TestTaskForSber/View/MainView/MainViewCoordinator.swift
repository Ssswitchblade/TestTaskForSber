import UIKit
import Foundation
import SwiftUI

final class MainViewCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openMainView() {
        let mainViewModel = MainViewModel(coordinator: self)
        let mainView = UIHostingController(rootView: MainView()
            .environmentObject(mainViewModel))
        navigationController.pushViewController(mainView, animated: true)
    }
    
    func toZoomView(url: URL?) {
        let zoomView = UIHostingController(rootView: ImageZoomView(imageUrl: url))
        navigationController.present(zoomView, animated: true)
    }
}
