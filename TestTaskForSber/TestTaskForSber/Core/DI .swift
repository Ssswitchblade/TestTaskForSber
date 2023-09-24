import Factory
import Foundation

extension Container {
    var getImageService: Factory<GetImageServiceProtocol> {
        Factory(self) { GetImageService() }
    }
}
