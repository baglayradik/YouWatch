
import Foundation
import UIKit
extension UIImage {
    
    static func loadImage(url: URL) -> UIImage? {
        var image: UIImage?
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf:url)
                image = UIImage(data: data)!
            }
            catch {
                print("error")
            }
        }
        return image ?? nil
    }
}
