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
                self.checkError(with: data, response, error) { [weak self] result in
                    guard let self = self else { return }

                    switch result {
                    case .success(let data):
                        completion(self.decode(data: data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }.resume()

        } catch {
            completion(.failure(NetworkError.urlRequest(error)))
        }
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Data, Error>) -> ()) {
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.unknownError))
            return
        }

        guard (200 ... 299).contains(response.statusCode) else {
            completion(.failure(NetworkError.invalidHttpStatusCode(response.statusCode)))
            return
        }

        guard let data = data else {
            completion(.failure(NetworkError.emptyData))
            return
        }

        completion(.success((data)))
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
