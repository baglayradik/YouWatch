
import Foundation

enum methodType: String {
    case get = "GET"
    case post = "POST"
}

enum RequestContentProvider {
    
    static let baseURLString = "https://www.googleapis.com/youtube/v3"
    static let videoURLString = "https://www.youtube.com"
    static let key = "AIzaSyCuBInTJZNIGX-xMegSfj2WsK_vAj_NRqs"
    
    case searchVideo(String,String)
    case loadVideo(String)
    
    var method: methodType {
        switch self {
        case .searchVideo:
            return .get
        case .loadVideo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .searchVideo:
            return "/search"
        case .loadVideo:
            return "/watch"
        }
    }
    func queryItems(params: [String:String], urlString: String) -> String {
        let queryItems = params.map({ URLQueryItem(name: $0.key, value: $0.value) })
        var urlComps = URLComponents(string: urlString + path)
        urlComps?.queryItems = queryItems
        return urlComps?.url?.absoluteString ?? ""
    }
    
    var urlString: String {
        switch self {
        case .searchVideo(let videoName, let key):
            let params = ["part":"snippet", "order":"viewCount", "q":"\(videoName)", "key": "\(key)", "type":"video", "maxResults":"50", "regionCode":"RU"]
            return queryItems(params: params, urlString: RequestContentProvider.baseURLString)
        case .loadVideo(let videoID):
            let params = ["v" : "\(videoID)"]
             return queryItems(params: params, urlString:  RequestContentProvider.videoURLString)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .searchVideo:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .loadVideo:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return urlRequest
    }
}

