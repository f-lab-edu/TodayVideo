//
//  Encodable+Extensions.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/3/25.
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
