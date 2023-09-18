import Foundation
import SwiftUI

struct ImageZoomView: View {
    
    let imageUrl: URL?
    
    var body: some View {
        CacheAsyncImage(url: imageUrl, content: { phase in
            switch phase {
            case .success(let image):
                image.resizable()
            case .failure(_):
                Image(systemName: "photo")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            case .empty:
                Image(systemName: "photo")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            @unknown default:
                fatalError()
            }
        })
    }
}
