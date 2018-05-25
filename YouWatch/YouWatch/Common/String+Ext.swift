
import Foundation

extension String {
    
    static func dateforString(string: String) -> String {
        let myDate = string
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // edited
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:myDate)!
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from:date)
        return dateString
    }
}



