//
//  Date + Extension.swift
//  CoinMarket
//
//  Created by JinwooLee on 2/28/24.
//

import Foundation

extension String {
    func toDate(dateFormat format : String) -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

extension Double {
    func toNumber(digit : Int, percentage : Bool) -> String? {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = digit

        let result: String = numberFormatter.string(for: self)!
        
        return percentage == true ? "\(result)%" : "₩\(result)"
    }
    
    
}

extension Date {
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        let current = Calendar.current
        return current.isDateInToday(self) ? "Today" : "\(dateFormatter.string(from: self))-❗️최신이 아닙니다."
    }
    
    func toStringKST( dateFormat format: String ) -> String {
        return self.toString(dateFormat: format)
    }
    
    func toStringUTC(_ timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:m"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return dateFormatter.string(from: self)
    }
}
