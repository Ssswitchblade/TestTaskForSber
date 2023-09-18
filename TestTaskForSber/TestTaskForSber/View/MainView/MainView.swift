import SwiftUI
import Foundation

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    @State var isLinkActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ImageZoomView(imageUrl: viewModel.imageUrl), isActive: $isLinkActive) { }
                CacheAsyncImage(url: viewModel.imageUrl) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                    case .failure(_):
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                    case .empty:
                        if viewModel.loadImage {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(Color.accentColor)
                        } else {
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        }
                    @unknown default:
                        fatalError()
                    }
                }.frame(width: 200, height: 200, alignment: .center)
                .onTapGesture {
                    guard let _ = viewModel.imageUrl else { return }
                    self.isLinkActive = true
                }
                Spacer().frame(height: 20)
                Button("Get Image!") {
                    viewModel.loadImage = true
                    viewModel.getImage()
                }.buttonStyle(.borderedProminent)
            }.alert("Что-то пошло не так, проверьте интернет соединение!",
                    isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
             .padding()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
