
import Foundation

struct Thumbnails: Codable {
    let defaults: ThumbnailsDetail
    let medium: ThumbnailsDetail
    let high: ThumbnailsDetail
    
    enum CodingKeys: String, CodingKey {
        case defaults = "default"
        case medium = "medium"
        case high = "high"
    }
}
