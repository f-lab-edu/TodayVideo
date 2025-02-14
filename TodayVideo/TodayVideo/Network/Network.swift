//
//  Network.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import Foundation

/*
네트워킹 로직 출처
https://ios-development.tistory.com/719
*/

final class Network {
    func request<R: Decodable, E: RequesteResponsable>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R {
        
        do {
            let urlRequest = try endpoint.getUrlRequest()

            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    self.checkError(with: data, response, error) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success(let data):
                            completion(self.decode(data: data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            }.resume()

        } catch {
            completion(.failure(NetworkError.urlRequest(error)))
        }
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }

        do {
            let response = try checkResponse(response)
            _ = try checkStatusCode(response!.statusCode)
            let data = try checkData(data)
            
            completion(.success((data!)))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func checkResponse(_ response: URLResponse?) throws -> HTTPURLResponse? {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }
        return response
    }
    
    func checkStatusCode(_ code: Int) throws -> Bool {
        guard (200 ... 299).contains(code) else {
            throw NetworkError.invalidHttpStatusCode(code)
        }
        return true
    }
    
    func checkData(_ data: Data?) throws -> Data? {
        guard let data = data else {
            throw NetworkError.emptyData
        }
        return data
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(NetworkError.emptyData)
        }
    }
}
