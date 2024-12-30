# 

 <img src="https://github.com/user-attachments/assets/81215a04-dcc8-4d39-b486-ca786fab685a">

#### **원하는 조건을 설정하여 랜덤하게 작품을 추천해주는 앱.** 



<img src="https://github.com/user-attachments/assets/38c14767-65ef-49d7-974a-7b5a7fbb8b10">

### 넷플릭스는 볼 건 많은데 볼 만한게 없어...

- 주변에서 많이 듣던 농담 같은 진담, 

  그래서 만들어 보았습니다.

<br>

디자인 레퍼런스

[ProtoPie Cloud - movie ticketing app concept](https://cloud.protopie.io/p/e618c220f0?sceneId=c347bb39-8daf-453b-846d-2e16532d04b0)

[ProtoPie Cloud - Movie rating app](https://cloud.protopie.io/p/b27743f254f06b69e02b8175)

[ProtoPie Cloud - Cinema booking app](https://cloud.protopie.io/p/39162ab9c8391d5d462fc075?sceneId=9f5bdf92-6304-4279-a4c1-b6cb0eb67d01)

<br>

## 💾 API

- TMDB

  -> https://developer.themoviedb.org/reference/intro/getting-started
  
  <br>
  
  - 장르 선택 화면
  
    -> https://developer.themoviedb.org/reference/genre-movie-list
  
    -> https://developer.themoviedb.org/reference/genre-tv-list
  
    **request**
  
    | parameter | value |
    | :-------- | :---- |
    | language  | ko    |
  
    **response**
  
    | key    | type  |
    | ------ | ----- |
    | genres | Array |
  
    | key  | type   |
    | ---- | ------ |
    | id   | Int    |
    | name | String |
  
    <br>
  
  - 추천작 화면
  
    -> https://developer.themoviedb.org/reference/discover-movie
  
    -> https://developer.themoviedb.org/reference/discover-tv
  
    **request**
  
    | parameter            | value             |
    | :------------------- | :---------------- |
    | language             | ko-KR             |
    | page                 | 랜덤 숫자 넣기    |
    | vote_count.gte       | 7                 |
    | watch_region         | KR                |
    | with_genres          | 장르 필터 값 넣기 |
    | with_watch_providers | 8                 |
  
    **response**
  
    | key     | type  |
    | ------- | ----- |
    | results | Array |
  
    | key                         | type   |                                                              |
    | --------------------------- | ------ | ------------------------------------------------------------ |
    | genre_ids                   | [Int]  |                                                              |
    | id                          | Int    |                                                              |
    | poster_path                 | String | [https://image.tmdb.org/t/p/w500/](https://image.tmdb.org/t/p/w500/){poster_path} |
    | title/name                  | String |                                                              |
    | release_date/first_air_date | String |                                                              |
    | total_pages                 | Int    |                                                              |
  
    <br>
  
  - 상세 화면
  
    -> https://developer.themoviedb.org/reference/movie-details
  
    -> https://developer.themoviedb.org/reference/tv-series-details
  
    **request**
  
    | parameter          | value                          |
    | :----------------- | :----------------------------- |
    | movie_id/series_id | 추천작 화면에서 터치된 작품 ID |
    | language           | ko-KR                          |
  
    **response**
  
    | key                         | type   |                                                 |
    | --------------------------- | ------ | ----------------------------------------------- |
    | backdrop_path               | String | https://image.tmdb.org/t/p/w500/{backdrop_path} |
    | genres                      | Array  |                                                 |
    | id                          | Int    |                                                 |
    | overview                    | String |                                                 |
    | release_date/first_air_date | String |                                                 |
    | title/name                  | String |                                                 |
    | runtime                     | Int    | 영화 상세 화면용                                |
    | last_episode_to_airruntime  | Object | TV 시리즈 상세 화면용                           |
  
    *genres
  
    | key  | type   |
    | ---- | ------ |
    | id   | Int    |
    | name | String |
  
    *last_episode_to_airruntime
  
    | key     | type |
    | ------- | ---- |
    | runtime | Int  |
  
    <br>
  
    -> https://developer.themoviedb.org/reference/movie-credits
  
    -> https://developer.themoviedb.org/reference/tv-series-credits
  
    출연진
  
    **request**
  
    | parameter          | value                          |
    | :----------------- | :----------------------------- |
    | movie_id/series_id | 추천작 화면에서 터치된 작품 ID |
    | language           | ko-KR                          |
  
    **response**
  
    | key  | type  |
    | ---- | ----- |
    | cast | Array |
  
    | key          | type   |                                                |
    | ------------ | ------ | ---------------------------------------------- |
    | name         | String |                                                |
    | profile_path | String | https://image.tmdb.org/t/p/w500/{profile_path} |
    | character    | String |                                                |
  
    <br>
  
    -> https://developer.themoviedb.org/reference/movie-release-dates
  
    -> https://developer.themoviedb.org/reference/tv-series-content-ratings
  
    시청 연령
  
    **request**
  
    | parameter          | value                          |
    | :----------------- | :----------------------------- |
    | movie_id/series_id | 추천작 화면에서 터치된 작품 ID |
  
    **response**
  
    | key     | type  |
    | ------- | ----- |
    | results | Array |
  
    | key          | type   |                       |
    | ------------ | ------ | --------------------- |
    | iso_3166_1   | String | KR인 것만 사용        |
    | release_date | Array  | 영화 상세 화면용      |
    | rating       | String | TV 시리즈 상세 화면용 |
  
    *release_date
  
    | key           | type   |
    | ------------- | ------ |
    | certification | String |
  
    <br>
  
    -> https://developer.themoviedb.org/reference/movie-videos
  
    -> https://developer.themoviedb.org/reference/tv-series-videos
  
    영상
  
    **request**
  
    | parameter          | value                          |
    | :----------------- | :----------------------------- |
    | movie_id/series_id | 추천작 화면에서 터치된 작품 ID |
    | language           | ko-KR                          |
  
    **response**
  
    | key     | type  |                          |
    | ------- | ----- | ------------------------ |
    | results | Array | 비어있으면 view 숨김처리 |
  
    | key  | type   |                                       |
    | ---- | ------ | ------------------------------------- |
    | site | String | YouTube인 것만 사용                   |
    | key  | String | https://www.youtube.com/watch?v={key} |
  
    <br>

## 🧷 Git

### 브랜치 전략

- Github-flow 적용
  - 이유
    - 소규모 프로젝트
    - QA 없음
    - 추후 확장성 고려
  

### 커밋 메세지 규칙

| 타입   | 사용                     |
| ------ | ------------------------ |
| FEAT   | 새로운 기능 추가         |
| FIX    | 오류 및 버그 수정        |
| DOCS   | 문서 수정                |
| STYLE  | 기능 외 수정             |
| TEST   | 테스트 코드 추가 및 수정 |
| RENAME | 파일 및 폴더명 수정      |
| REMOVE | 파일 및 폴더 삭제        |

<br>

## ⚙️ 아키텍처

- VIPER

  <img align=left width=200 src="https://github.com/user-attachments/assets/fc337395-208a-4687-b480-0cb250b7b6a8">

  <br>

  ### 스플래시 화면

  ​	데이터 없이 일정 시간 후 rootViewController를 선택 화면 1로 변경

  <img width=500 src="https://github.com/user-attachments/assets/4b152766-a4ae-44a1-a298-6db2bc020860">

  ### 선택 화면 1

  ​	데이터 없이 선택된 카테고리를 내부 저장하고 선택 화면 2로 이동

  <img width=500 src="https://github.com/user-attachments/assets/35cc7e85-85b2-4ecd-90d2-3dca8b5b27aa">

  ### 선택 화면 2

  ​	TMDB - Genres - Movie/TV Series 에서 데이터를 받아 장르 카테고리 노출

  ​	선택된 장르를 내부 저장하여 추천작 화면으로 이동

  <img width=500 src="https://github.com/user-attachments/assets/d5dbce29-0285-4be2-8d59-d543e808cb51">

  ```swift
  struct GenresRequest: Encodable {
    let language: String = "ko"
  }
  ```

  ```swift
  struct GenresResponse: Decodable {
    let id: Int
    let name: String
  }
  ```
  
  <br>
  
  ### 추천작 화면
  
  ​	TMDB - Discover - Movie/TV Series 에서 데이터를 받아 추천작 노출
  
  ​	작품이 선택되면 상세 화면으로 이동
  
  <img width=500 src="https://github.com/user-attachments/assets/d5dbce29-0285-4be2-8d59-d543e808cb51">
  
  ```swift
  struct RecommendRequest: Encodable {
    let language: String = "ko-KR"
    let page: Int
    let voteCount: Int = 7
    let watchRegion: String = "KR"
    let withGenres: Int
    let withWatchProviders: Int = 8
  }
  ```
  
  ```swift
  struct RecommendMovieResponse: Decodable {
    let results: [RecommendMovieResultsResponse]
  }
  struct RecommendMovieResultsResponse: Decodable {
      let gnereIds: [Int]
      let id: Int
      let posterPath: String
      let title: String
      let releaseDate: String
      let totlaPages: Int
  }
  
  
  struct RecommendTVResponse: Decodable {
    let results: [RecommendTVResultsResponse]
  }
  struct RecommendTVResultsResponse: Decodable {
      let gnereIds: [Int]
      let id: Int
      let posterPath: String
      let name: String
      let firstAirDate: String
      let totlaPages: Int
  }
  ```
  
  <br>
  
  ### 상세 화면
  
  ​	TMDB - Movies/TV Series
  
  ​	Details, Credits, ReleaseDates/ContentRatings, Videos 동시 호출하여 받은 데이터 노출
  
  <img width=500 src="https://github.com/user-attachments/assets/6fa0182a-777d-4fc5-85a5-0665392b8994">
  
  ```swift
  struct DetailMovieRequest: Encodable {
    let movieId: Int
    let language: String = "ko-KR"
  }
  
  struct DetailTVRequest: Encodable {
    let seriesId: Int
    let language: String = "ko-KR"
  }
  ```
  
  ```swift
  struct DetailMovieResponse: Decodable {
    let backDropPath: String
    let genres:[DetailMovieGenresResponse]
    let id: Int
    let overview: String
    let releaseDate: String
    let title: String
    let runtime: Int
  }
  struct DetailMovieGenresResponse: Decodable {
    let id: Int
    let name: String
  }
  
  
  struct DetailTVResponse: Decodable {
    let backDropPath: String
    let genres:[DetailTVGenresResponse]
    let id: Int
    let overview: String
    let firstAirDate: String
    let name: String
    let lastEpisodeToAirruntime: DetailTVLastEpisodeToAirruntimeResponse
  }
  struct DetailTVGenresResponse: Decodable {
    let id: Int
    let name: String
  }
  struct DetailTVLastEpisodeToAirruntimeResponse: Decodable {
    let runtime: Int
  }
  ```
  
  <br>
  
  출연진 조회
  
  ```swift
  struct CreditsMovieRequest: Encodable {
    let movieId: Int
    let language: String = "ko-KR"
  }
  
  struct CreditsTVRequest: Encodable {
    let seriesId: Int
    let language: String = "ko-KR"
  }
  ```
  
  ```swift
  struct CreditsResponse: Decodable {
    let cast: [CreditsCastResponse]
  }
  struct CreditsCastResponse: Decodable {
    let name: String
    let profielPath: String
    let character: String
  }
  ```
  
  <br>
  
  시청 연령 조회
  
  ```swift
  struct CertificationMovieRequest: Encodable {
    let movieId: Int
  }
  
  struct CertificationTVRequest: Encodable {
    let seriesId: Int
  }
  ```
  
  ```swift
  struct CertificationMovieResponse: Decodable {
    let results: [CertificationMovieResultsResponse]
  }
  struct CertificationMovieResultsResponse: Decodable {
    let iso: String
    let releaseDates: [CertificationMovieReleaseDatesResponse]
  }
  struct CertificationMovieReleaseDatesResponse: Decodable {
    let certification: String
  }
    
  
  struct CertificationTVResponse: Decodable {
    let results: [CertificationTVResultsResponse]
  }
  struct CertificationTVResultsResponse: Decodable {
    let iso: String
    let rating: String
  }
  ```
  
  <br>
  
  영상 조회
  
  ```swift
  struct VideoMovieRequest: Encodable {
    let movieId: Int
    let language: String = "ko-KR"
  }
  
  struct VideoTVRequest: Encodable {
    let seriesId: Int
    let language: String = "ko-KR"
  }
  ```
  
  ```swift
  struct VideoMovieResponse: Decodable {
    let results: [VideoMovieResultsResponse]
  }
  struct VideoMovieResultsResponse: Decodable {
    let site: String
    let key: String
  }
  ```
