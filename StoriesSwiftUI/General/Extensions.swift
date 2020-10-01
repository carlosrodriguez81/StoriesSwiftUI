//
//  Extensions.swift
//  StoriesSwiftUI
//
//  Created by Carlos Rodriguez on 9/29/20.
//

import Foundation
import UIKit

extension DateFormatter {
    static func forJSONDecoder() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return formatter
    }
}

extension Date {
    func timeAgo() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "s"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "m"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "h"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "d"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "w"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        return "\(quotient)\(unit)"
    }
}

extension Bundle {
    func getDataJSON(url: String, completion: @escaping ([StoryJSON]?) ->()) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            if error != nil {
                print("JSON Error:", error!.localizedDescription as Any)
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.forJSONDecoder())
                let json = try decoder.decode(JSONData.self, from: data!)
                let stories: [StoryJSON] = json.hits
                completion(stories)
            } catch {
                print("Error JSONDecoder: ",error)
                completion(nil)
            }
        }.resume()
    }
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.forJSONDecoder())
        
        guard let json = try? decoder.decode(JSONData.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return json.hits as! T
    }
}
