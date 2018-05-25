
import Foundation


class RequestManager {
    
    func runTask<T>(_ task: APITask<T>) {
        URLSession.shared.dataTask(with: task.urlRequest) { (data, response, error) in
            guard let data = data else { return }
            var parseObject: T
            do {
                parseObject =  try JSONDecoder().decode(T.self, from: data)
                task.completion(.success(parseObject))
            }
            catch {
                task.completion(.failure(error))
                print(error)
            }
        }.resume()
    }
}

