//
//  NetworkError.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/3/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case invalidHttpStatusCode(Int)
    case components
    case urlRequest(Error)
    case parsing(Error)
    case emptyData
    case decodeError

    var errorDescription: String? {
        switch self {
        case .unknownError: 
            return "일시적인 오류가 발생하였습니다.\n나중에 다시 시도해주세요."
        case .invalidHttpStatusCode: // status코드가 200~299가 아닙니다.
            return "서버에서 오류가 발생했습니다.\n잠시 후 다시 시도해주세요."
        case .components: 
            return "components를 생성 에러가 발생했습니다."
        case .urlRequest:
            return "URL request 관련 에러가 발생했습니다."
        case .parsing:
            return "데이터 parsing 중에 에러가 발생했습니다."
        case .emptyData: // data가 비어있습니다.
            return "서버에서 오류가 발생했습니다.\n잠시 후 다시 시도해주세요."
        case .decodeError:
            return "decode 에러가 발생했습니다."
        }
    }
}
