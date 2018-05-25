
import Foundation

typealias block<T:Codable> = (YouWatchResult<T>) -> ()

enum YouWatchResult<T: Codable> {
    case success (T)
    case failure(Error)
}

class VideoManager {
    private var network = NetworkAPIService()
    var videos : [DetailInfo] = []
    
    func searchVideo(videoName:String, key: String, completion: @escaping block<Video>) {
        network.search(videoName: videoName, key: key) { (requestResult) in
            switch requestResult {
            case .success(let videosInfo):
                self.videos = videosInfo.items
                completion(.success(videosInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
