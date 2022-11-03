import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: Image?
    var url: URL?

    func load(_ url: URL) async {
        if url == self.url && image != nil { return }

        do {
            self.url = url
            self.image = nil
            let (data, _) = try await URLSession.shared.data(from: url)
            try await Task.sleep(nanoseconds: NSEC_PER_SEC/4) // Artificial sleep to see the loading
            #if os(macOS)
            image = NSImage(data: data).map(Image.init)
            #else
            image = UIImage(data: data).map(Image.init)
            #endif
        } catch {
            print(error)
        }
    }
}

struct RemoteImage<V: View>: View {
    var url: URL
    @ViewBuilder var placeholder: () -> V
    var _resizable: Bool = false
    @StateObject private var loader = ImageLoader()

    var body: some View {
        UnmanagedRemoteImage(url: url, loader: loader, resizable: _resizable, placeholder: placeholder)
    }

    func resizable() -> Self {
        var copy = self
        copy._resizable = true
        return copy
    }
}

struct UnmanagedRemoteImage<V: View>: View {
    var url: URL
    var placeholder: V
    fileprivate var _resizable: Bool
    @ObservedObject var loader: ImageLoader

    init(url: URL, loader: ImageLoader, resizable: Bool = false, @ViewBuilder placeholder: () -> V) {
        self.url = url
        self.loader = loader
        self.placeholder = placeholder()
        self._resizable = resizable
    }

    var body: some View {
        ZStack {
            if let image = loader.image {
                if _resizable {
                    image.resizable()
                } else {
                    image
                }
            } else {
                placeholder
            }
        }
        .task(id: url) {
            await loader.load(url)
        }
    }

    func resizable() -> some View {
        var copy = self
        copy._resizable = true
        return copy
    }
}
