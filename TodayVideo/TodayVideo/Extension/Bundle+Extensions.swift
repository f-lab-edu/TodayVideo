//
//  Bundle+Extensions.swift
//  TodayVideo
//
//  Created by 김지나 on 2/2/25.
//

import Foundation

extension Bundle {
    private var secretPlistDict: NSDictionary {
        guard let filePath = Bundle.main.path(forResource: "Secret", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: filePath) else {
            print("Couldn't find file 'Secure.plist'.")
            return [:]
        }
        
        return plistDict
    }
    
    private func secretValue(_ key: String) -> String? {
        return secretPlistDict.object(forKey: key) as? String
    }
    
    var baseUrl: String {
        return secretValue("BASE_URL") ?? ""
    }
    
    var authrization: String {
        return secretValue("AUTH_TOKEN") ?? ""
    }
}
