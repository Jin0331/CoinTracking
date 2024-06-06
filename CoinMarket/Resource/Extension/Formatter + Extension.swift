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
    
    func toPoint() -> String? {
        return self >= 10 ? self.toNumber(digit: 0, percentage: false) : "₩\(String(format:"%.5f", self))"
    }
    
    func toPointUSD() -> String? {
        return "$\(String(format:"%.4f", self))"
    }
    
    
    
}

extension Date {
    func toString( dateFormat format: String, raw : Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        
        let current = Calendar.current
        
        if raw {
            return dateFormatter.string(from: self)
        } else {
            return current.isDateInToday(self) ? "Today" : "\(dateFormatter.string(from: self))-❗️최신이 아닙니다."
        }
    }
    
    func toStringKST( dateFormat format: String ) -> String {
        return self.toString(dateFormat: format, raw: true)
    }
    
    func toStringUTC(_ timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:m"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return dateFormatter.string(from: self)
    }
}
