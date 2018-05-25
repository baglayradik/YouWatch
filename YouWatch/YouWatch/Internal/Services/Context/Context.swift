protocol Contextual {
    var context: Context? { get set }
}

// 'ServiceLocator' pattern
class Context {
    let videoManager: VideoManager

        init(videoManager: VideoManager) {
            self.videoManager = videoManager
        }
}

extension Context {
    
        static func createStorageContext() -> Context? {
            let context = Context(
                videoManager: VideoManager()
            )
            return context
        }
}
