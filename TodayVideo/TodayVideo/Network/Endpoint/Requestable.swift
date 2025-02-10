//
//  Requestable.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/3/25.
//

import Foundation

protocol Requestable {
    var path: String { get }
    var method: HttpMethod { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var sampleData: Data? { get }
}

extension Requestable {
    func getUrlRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)

        // httpBody
        urlRequest.httpBody = try httpBody()
        
        // httpMethod
        urlRequest.httpMethod = method.rawValue

        // header
        return httpHeader(urlRequest: &urlRequest)
    }

    private func httpBody() throws -> Data? {
        if let bodyParameters = try bodyParameters?.toDictionary() {
            if !bodyParameters.isEmpty {
                return try? JSONSerialization.data(withJSONObject: bodyParameters)
            }
        }
        return nil
    }
    
    private func httpHeader(urlRequest: inout URLRequest) -> URLRequest {
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue(Bundle.main.authrization, forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    func url() throws -> URL {
        // baseURL + path
        var urlComponents = try makeURL()
        
        // (baseURL + path) + queryParameters
        urlComponents = try makeQueryParameter(urlComponents: &urlComponents)
        
        guard let url = urlComponents.url else { throw NetworkError.components }
        return url
    }
    
    private func makeURL() throws -> URLComponents {
        let baseUrl = Bundle.main.baseUrl
        let fullPath = "\(baseUrl)\(path)"
        guard let urlComponents = URLComponents(string: fullPath) else { throw NetworkError.components }
        
        return urlComponents
    }
    
    private func makeQueryParameter(urlComponents: inout URLComponents) throws -> URLComponents{
        var urlQueryItems = [URLQueryItem]()
        
        if let queryParameters = try queryParameters?.toDictionary() {
            queryParameters.forEach {
                urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
            }
        }
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        
        return urlComponents
    }
}
