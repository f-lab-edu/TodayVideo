

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

## ⚙️ 아키텍처

- VIPER

  <img align="left" width="200" src="https://github.com/user-attachments/assets/fc337395-208a-4687-b480-0cb250b7b6a8">
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>
  <br>

  > 스플래시 화면

  ​	데이터 없이 일정 시간 후 rootViewController를 선택 화면 1로 변경

  <img width=400 src="https://github.com/user-attachments/assets/4b152766-a4ae-44a1-a298-6db2bc020860">
  <br>
  <br>

  > 선택 화면 1

  ​	데이터 없이 선택된 카테고리를 내부 저장하고 선택 화면 2로 이동

  <img width=400 src="https://github.com/user-attachments/assets/35cc7e85-85b2-4ecd-90d2-3dca8b5b27aa">
  <br>
  <br>

  > 선택 화면 2 / 추천작 화면

  ​	TMDB - Genres - Movie/TV Series 에서 데이터를 받아 장르 카테고리 노출

  ​	선택된 장르를 내부 저장하여 추천작 화면으로 이동
  ​ <br>
  <br>


  ​        TMDB - Discover - Movie/TV Series 에서 데이터를 받아 추천작 노출

  ​        작품이 선택되면 상세 화면으로 이동    

  <img width=400 src="https://github.com/user-attachments/assets/d5dbce29-0285-4be2-8d59-d543e808cb51">
  <br>
  <br>

  > 상세 화면

  ​	TMDB - Movies/TV Series

  ​	Details, Credits, ReleaseDates/ContentRatings, Videos 동시 호출하여 받은 데이터 노출
  <img width=400 src="https://github.com/user-attachments/assets/6fa0182a-777d-4fc5-85a5-0665392b8994">

<br>

- 코드 컨벤션
  SwiftLint 적용

<br>

- Unit Test

<br>

## 💾 API

- TMDB

  -> https://developer.themoviedb.org/reference/intro/getting-started

  <br>
  Base URL -> https://api.themoviedb.org/3
  <br>
  Image Base URL -> https://image.tmdb.org/t/p/w500/
  <br>
  HTTP Method -> GET
  <br>
  <br>
  
  - 장르 선택 화면
  
    -> /genre/movie/list
  
    -> /genre/tv/list
  
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
  
    -> /discover/movie
  
    -> /discover/tv
  
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
    | poster_path                 | String |  |
    | title/name                  | String |                                                              |
    | release_date/first_air_date | String |                                                              |
    | total_pages                 | Int    |                                                              |
  
    <br>
  
  - 상세 화면
  
    -> /movie/{movie_id}
  
    -> /tv/{series_id}
  
    **request**
  
    | parameter          | value                          |
    | :----------------- | :----------------------------- |
    | movie_id/series_id | 추천작 화면에서 터치된 작품 ID |
    | language           | ko-KR                          |
  
    **response**
  
    | key                         | type   |                                |
    | --------------------------- | ------ | ------------------------------ |
    | backdrop_path               | String | Image Base URL/{backdrop_path} |
    | genres                      | Array  |                                |
    | homepage                    | String |                                |
    | id                          | Int    |                                |
    | overview                    | String |                                |
    | release_date/first_air_date | String |                                |
    | title/name                  | String |                                |
    | runtime                     | Int    | 영화 상세 화면용               |
    | productionCountries         | Object | 영화 상세 화면용               |
    | last_episode_to_airruntime  | Object | TV 시리즈 상세 화면용          |
  
    *genres
    
    | key  | type   |
    | ---- | ------ |
    | id   | Int    |
    | name | String |
  
    *productionCountries
    
    | key        | type   |
    | ---------- | ------ |
    | iso_3166_1 | String |
    | name       | String |
    
    *last_episode_to_airruntime
    
    | key     | type |
    | ------- | ---- |
    | runtime | Int  |
    
    <br>
    
    - 영상
    
    -> /movie/{movie_id}/videos
  
    -> /tv/{series_id}/videos
  
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
| REFACT | 리펙토링               |
| DOCS   | 문서 수정                |
| STYLE  | 기능 외 수정             |
| TEST   | 테스트 코드 추가 및 수정 |
| RENAME | 파일 및 폴더명 수정      |
| REMOVE | 파일 및 폴더 삭제        |
