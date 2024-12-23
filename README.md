# 

 <img src="https://github.com/user-attachments/assets/81215a04-dcc8-4d39-b486-ca786fab685a">

#### **원하는 조건을 설정하여 랜덤하게 작품을 추천해주는 앱.** 



<img src="https://github.com/user-attachments/assets/13c637dc-29a8-4688-92b1-4dddc88bbc05">

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

  -> https://developer.themoviedb.org/reference/genre-movie-list

  Genres에서 영화 장르 json 데이터를 가져옵니다.

  -> https://developer.themoviedb.org/reference/genre-tv-list

  Genres에서 TV 장르 json 데이터를 가져옵니다.

  -> https://developer.themoviedb.org/reference/discover-movie

  Discover의 movie api에서 파라미터 값들로 필터를 준 영화 정보 json 데이터를 가져옵니다.

  -> https://developer.themoviedb.org/reference/genre-tv-list

  Discover의 TV api에서 파라미터 값들로 필터를 준 TV 정보 json 데이터를 가져옵니다.

<br>

## 🧷 Git 브랜치 전략

- Github-flow

  소규모 개인 프로젝트에는 훨씬 간단하면서 추후 확장성을 고려했을 때 편리한 **Github-flow**를 적용했습니다. 

<br>

## ⚙️ 아키텍처

- VIPER