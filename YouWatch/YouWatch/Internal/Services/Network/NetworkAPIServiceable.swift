
import Foundation

enum RequestResult<T: Codable> {
    case success (T)
    case failure(Error)
}

protocol APIServiceable {
    func search (videoName:String, key: String, completion: @escaping (RequestResult<Video>) -> Void)
}
