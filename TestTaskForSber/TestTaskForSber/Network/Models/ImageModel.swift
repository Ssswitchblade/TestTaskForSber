import Foundation

// MARK: - ImagesReponseModel
struct ImagesReponseModel: Codable {
    let id: String
    let imageUrls: ImageUrls
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrls = "urls"
    }
}

// MARK: - ImageUrls
struct ImageUrls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
