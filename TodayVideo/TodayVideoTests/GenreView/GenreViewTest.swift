//
//  GenreViewTest.swift
//  TodayVideoTests
//
//  Created by iOS Dev on 2/5/25.
//

import XCTest
@testable import TodayVideo

final class GenreViewTest: XCTestCase {
    
    func test_genre_decoding() {
        let jsonString = """
            {
                "genres": [
                    {
                        "id": 1,
                        "name": "코미디"
                    },
                    {
                        "id": 2,
                        "name": "공포"
                    }
                ]
            }
            """
        let jsonData = jsonString.data(using: .utf8)!
        
        do {
            let genres = try JSONDecoder().decode(GenresResponse.self, from: jsonData)
            let expected = GenresResponse(
                genres: [
                    Genre(id: 1, name: "코미디"),
                    Genre(id: 2, name: "공포")
                ]
            )
            XCTAssertEqual(genres, expected, "디코딩된 Genre 객체가 예상과 다릅니다.")
            
        } catch {
            XCTFail("디코딩 실패: \(error)")
        }
    }

    func testAPIResponseStatus200() {
        let expectation = self.expectation(description: "API 응답이 200 OK인지 확인")
        let endpoint = APIEndpoint.shared.getMovieGenres()
        
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
