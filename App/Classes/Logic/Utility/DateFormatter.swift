//
//  DateFormatter.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 23/03/2020.
//

import Foundation

public enum DateFormat: String {
    /// yyyy-MM-dd
    case date = "yyyy-MM-dd"
    
    // dd MMMM yyyy
    case longDate = "dd MMMM yyyy"
    // dd
    case year = "yyyy"
    
    var value: String {
       return self.rawValue
    }
}

private class DateUtils {
    
    // MARK: - Properties
    
    private let dateFormatter: DateFormatter
    
    // MARK: - Lifecycle
    
    static let shared = DateUtils()
    
    init() {
        dateFormatter = DateFormatter()
    }
    
    // MARK: - Methods
    
    /// Returns the string representation of a date
    ///
    /// - Parameters:
    ///   - date: the date object
    ///   - format: the requested date format
    /// - Returns: the formatted string representation of the date
    func format(date: Date, with format: DateFormat) -> String {
        dateFormatter.dateFormat = format.value
        return dateFormatter.string(from: date)
    }
    
      /// Returns the date representation of a string
      ///
      /// - Parameters:
      ///   - date: the date string representation
      ///   - format: the requested date format
      /// - Returns: the date representation of the date string
      func format(date: String, with format: DateFormat) -> Date? {
          dateFormatter.dateFormat = format.value
          return dateFormatter.date(from: date)
      }
}

public extension Date {
    
    func format(with format: DateFormat) -> String {
        return DateUtils.shared.format(date: self, with: format)
    }
}

public extension String {
    
    func date(with format: DateFormat) -> Date? {
        return DateUtils.shared.format(date: self, with: format)
    }
    
}
