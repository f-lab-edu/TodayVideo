//
//  RecommendViewTest.swift
//  TodayVideoTests
//
//  Created by iOS Dev on 2/6/25.
//

import XCTest
@testable import TodayVideo

final class RecommendViewTest: XCTestCase {
        
    func test_recommendRequest_decoding() {
        var jsonString = """
            {
                "language": "ko-KR",
                "page": 1,
                "vote_count.gte": 7,
                "watch_region": "KR",
                "with_genres": "28,35,10751",
                "with_watch_providers": "8"
            }
            """
        
        jsonString = jsonString.replacingOccurrences(of: "\"with_genres\": \"28,35,10751\"",
                                                     with: "\"with_genres\": \"28%2C35%2C10751\"")

        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let request = try JSONDecoder().decode(RecommendRequest.self, from: jsonData)
            let expected = RecommendRequest(page: 1, withGenres: "28%2C35%2C10751")
            
            XCTAssertEqual(request, expected, "디코딩된 request 객체가 예상과 다릅니다.")
        } catch {
            XCTFail("디코딩 실패: \(error)")
        }
    }
    
    func test_recommendMovieResponse_decoding() {
        let jsonString = """
            {
              "page": 1,
              "results": [
                {
                  "adult": false,
                  "backdrop_path": "/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg",
                  "genre_ids": [
                    28,
                    878,
                    35,
                    10751
                  ],
                  "id": 939243,
                  "original_language": "en",
                  "original_title": "Sonic the Hedgehog 3",
                  "overview": "Sonic, Knuckles, and Tails reunite against a powerful new adversary, Shadow, a mysterious villain with powers unlike anything they have faced before. With their abilities outmatched in every way, Team Sonic must seek out an unlikely alliance in hopes of stopping Shadow and protecting the planet.",
                  "popularity": 3264.78,
                  "poster_path": "/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg",
                  "release_date": "2024-12-19",
                  "title": "Sonic the Hedgehog 3",
                  "video": false,
                  "vote_average": 7.79,
                  "vote_count": 1528
                },
                {
                  "adult": false,
                  "backdrop_path": "/v9Du2HC3hlknAvGlWhquRbeifwW.jpg",
                  "genre_ids": [
                    28,
                    12,
                    53
                  ],
                  "id": 539972,
                  "original_language": "en",
                  "original_title": "Kraven the Hunter",
                  "overview": "Kraven Kravinoff's complex relationship with his ruthless gangster father, Nikolai, starts him down a path of vengeance with brutal consequences, motivating him to become not only the greatest hunter in the world, but also one of its most feared.",
                  "popularity": 1919.768,
                  "poster_path": "/nrlfJoxP1EkBVE9pU62L287Jl4D.jpg",
                  "release_date": "2024-12-11",
                  "title": "Kraven the Hunter",
                  "video": false,
                  "vote_average": 6.6,
                  "vote_count": 1043
                }
              ],
              "total_pages": 198,
              "total_results": 3943
            }
            """

        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let response = try JSONDecoder().decode(RecommendMovieResponse.self, from: jsonData)
            let expected = RecommendMovieResponse(results:
                                                    [
                                                        RecommendMovieResponse.Items(
                                                            genreIds: [28,878,35,10751],
                                                            id: 939243,
                                                            posterPath: "/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg",
                                                            title: "Sonic the Hedgehog 3",
                                                            releaseDate: "2024-12-19"),
                                                        RecommendMovieResponse.Items(
                                                            genreIds: [28,12,53],
                                                            id: 539972,
                                                            posterPath: "/nrlfJoxP1EkBVE9pU62L287Jl4D.jpg",
                                                            title: "Kraven the Hunter",
                                                            releaseDate: "2024-12-11")
                                                    ],
                                                  totalPages: 198)
            
            XCTAssertEqual(response, expected, "디코딩된 객체가 예상과 다릅니다.")
        } catch {
            XCTFail("디코딩 실패: \(error)")
        }
    }

    func test_recommendTVResponse_decoding() {
        let jsonString = """
            {
              "page": 1,
              "results": [
                {
                  "adult": false,
                  "backdrop_path": "/3hOxwqn1P2AY0d20VVtxN2f3Lfh.jpg",
                  "genre_ids": [
                    35,
                    10767
                  ],
                  "id": 6809,
                  "origin_country": [
                    "ES"
                  ],
                  "original_language": "es",
                  "original_name": "El hormiguero",
                  "overview": "",
                  "popularity": 2123.499,
                  "poster_path": "/sc7Uy9ynFn3FLbVldF64Izi9RSD.jpg",
                  "first_air_date": "2006-09-24",
                  "name": "El hormiguero",
                  "vote_average": 4.9,
                  "vote_count": 33
                },
                {
                  "adult": false,
                  "backdrop_path": "/mu3lEhGovyhKHPJzb7HNYtZUCDT.jpg",
                  "genre_ids": [
                    10766
                  ],
                  "id": 206559,
                  "origin_country": [
                    "ZA"
                  ],
                  "original_language": "af",
                  "original_name": "Binnelanders",
                  "overview": "",
                  "popularity": 3435.158,
                  "poster_path": "/3bzECfllho8PphdYujLUIuhncJD.jpg",
                  "first_air_date": "2005-10-13",
                  "name": "Binnelanders",
                  "vote_average": 5.7,
                  "vote_count": 88
                }
              ],
              "total_pages": 835,
              "total_results": 16695
            }
            """

        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let response = try JSONDecoder().decode(RecommendTVResponse.self, from: jsonData)
            let expected = RecommendTVResponse(results:
                                                    [
                                                        RecommendTVResponse.Items(genreIds: [35,10767],
                                                                                  id: 6809,
                                                                                  posterPath: "/sc7Uy9ynFn3FLbVldF64Izi9RSD.jpg",
                                                                                  name: "El hormiguero",
                                                                                  firstAirDate: "2006-09-24"),
                                                        RecommendTVResponse.Items(genreIds: [10766],
                                                                                  id: 206559,
                                                                                  posterPath: "/3bzECfllho8PphdYujLUIuhncJD.jpg",
                                                                                  name: "Binnelanders",
                                                                                  firstAirDate: "2005-10-13")
                                                    ],
                                                  totalPages: 198)
            
            XCTAssertEqual(response, expected, "디코딩된 객체가 예상과 다릅니다.")
        } catch {
            XCTFail("디코딩 실패: \(error)")
        }
    }
    
    func test_movieDiscoverAPIResponse_Status200() {
        let expectation = self.expectation(description: "API 응답이 200 OK인지 확인")
        let recommendRequest = RecommendRequest(page: 1, withGenres: "28%2C35%2C10751")
        let endpoint = APIEndpoint.shared.getMovieDiscover(with: recommendRequest)
        
        Network.shared.request(with: endpoint) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "status코드가 200~299가 아닙니다.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
