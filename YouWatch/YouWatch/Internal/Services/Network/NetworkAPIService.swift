
import Foundation


class NetworkAPIService: APIServiceable {
    func search(videoName: String, key: String, completion: @escaping (RequestResult<Video>) -> Void) {
        let apiTask = APITask<Video>(urlRequest: try!
            RequestContentProvider.searchVideo(videoName, key).asURLRequest(), completion: completion)
        let requestManager = RequestManager()
        requestManager.runTask(apiTask)
    }
}

private extension NetworkAPIService {
    func runRequest<T>(task: APITask<T>) {
        let requestManager = RequestManager()
        requestManager.runTask(task)
    }
}
