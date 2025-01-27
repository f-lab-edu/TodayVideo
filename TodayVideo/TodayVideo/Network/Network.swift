//
//  Network.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import Foundation

class Network {
    private enum BaseUrl: String {
        case movieGenre = "https://api.themoviedb.org/3/genre/movie/list"
        case TVGenre = "https://api.themoviedb.org/3/genre/tv/list"
    }
    
    func request<T: Decodable>(url: String, queryItems: [URLQueryItem], type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            debugPrint("URL is not correct")
            return
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZmMxODJjOWZkZmQ4YjE5YWY4NTQyMmIzMDI2MTRmNCIsIm5iZiI6MTczMzE4MzU3OS40NTEsInN1YiI6IjY3NGU0ODViNjc5ZWMxNTMyODgyNTI1OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3DXb6FTXQ5ibVAeYuqUUnI0Mh-Z8mUKCWyRIPRMa9g4"
        ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let response = try JSONDecoder().decode(type, from: data)
                    completion(.success(response))
                } catch(let error) {
                    print("Decoding Error")
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func requestGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        // url
        let selectedContent = UserDefaults.standard.string(forKey: UserdefaultKey.selectContent.rawValue)
        var url = ""
        if selectedContent == Content.movie.rawValue {
            url = BaseUrl.movieGenre.rawValue
        } else {
            url = BaseUrl.TVGenre.rawValue
        }
        
        // queryItems
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "ko")
        ]
        
        // api
        request(url: url, queryItems: queryItems, type: GenresResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

