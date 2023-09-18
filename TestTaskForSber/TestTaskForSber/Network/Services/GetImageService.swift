import Foundation
import Combine

protocol GetImageServiceProtocol {
    func getRandomImage() -> AnyPublisher<ImagesReponseModel, Error>
}

final class GetImageService: GetImageServiceProtocol {
    
    private let decoder = JSONDecoder()
    
    private let baseURL = "https://api.unsplash.com/photos/random"
    
    func getRandomImage() -> AnyPublisher<ImagesReponseModel, Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: NetworkErrors.invalidURLRequest.self).eraseToAnyPublisher()
        }
        
        var reguest = URLRequest(url: url)
        reguest.httpMethod = "GET"
        reguest.addValue("Client-ID 4NJfZryGisdInHxQdhJ3n264AEtBUJlw_pSZsBOeW6g", forHTTPHeaderField: "Authorization")
        return URLSession.shared.dataTaskPublisher(for: reguest)
            .tryMap { (data, response) -> ImagesReponseModel in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300) ~= httpResponse.statusCode else {
                    throw NetworkErrors.badServerResponse
                }
                do {
                    return try self.decoder.decode(ImagesReponseModel.self, from: data)
                } catch let decodeError {
                    debugPrint(decodeError)
                    throw NetworkErrors.responseParse
                }
            }.eraseToAnyPublisher()
    }
}

enum NetworkErrors: Error, LocalizedError {
    case invalidURLRequest
    case badServerResponse
    case responseParse
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURLRequest:
            return NSLocalizedString("URLRequest вернул nil", comment: "invalidURLRequest")
        case .badServerResponse:
            return NSLocalizedString("Статус код сервера >299", comment: "badServerResponse")
        case .responseParse:
            return NSLocalizedString("Parse error", comment: "look console")
        case.unknown:
            return NSLocalizedString("Неизвестная ошибка", comment: "unknown")
        }
    }
}
