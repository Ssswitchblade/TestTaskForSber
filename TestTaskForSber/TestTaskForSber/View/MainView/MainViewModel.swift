import Foundation
import Combine
import SwiftUI
import Factory

final class MainViewModel: ObservableObject {

    @Published var imageUrl: URL?
    @Published var loadImage: Bool = false
    @Published var showAlert: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    private let networkService: GetImageServiceProtocol = Container.shared.getImageService()
    
    private let coordinator: MainViewCoordinatorCoordinator
    
    init(coordinator: MainViewCoordinatorCoordinator) {
        self.coordinator = coordinator
    }
    
    func getImage() {
        networkService.getRandomImage()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.showAlert = true
                    self.loadImage = false 
                    print(error.localizedDescription)
                }
            }, receiveValue: { value in
                self.imageUrl = URL(string: value.imageUrls.small)
            }).store(in: &bag)
    }
    
    func toImageZoomView() {
        coordinator.toZoomView(url: imageUrl)
    }
}
     
  
