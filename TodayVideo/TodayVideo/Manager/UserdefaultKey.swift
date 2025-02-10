//
//  UserdefaultKey.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import Foundation

enum UserdefaultKey: String {
    case selectContent // 영화, 드라마 선택
    case selectGenre // 선택한 장르
}

final class UserDefault {
    static let shared = UserDefault()
    private init() {}
    
    func setValue(_ value: Any, key: UserdefaultKey) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    func stringForKey(_ key: UserdefaultKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
}
