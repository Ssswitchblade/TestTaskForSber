import Foundation
import Combine
import SwiftUI

protocol MainViewModelProtocol: ObservableObject {
    
}

final class MainViewModel: MainViewModelProtocol {

    @Published var imageUrl: URL?
    @Published var loadImage: Bool = false
    @Published var showAlert: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    private let networkService = GetImageService()
    
    private let coordinator: MainViewCoordinator
    
    init(coordinator: MainViewCoordinator) {
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
     
  
