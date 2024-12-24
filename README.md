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

## 🧷 Git

### 브랜치 전략

- Github-flow

  소규모 개인 프로젝트에는 훨씬 간단하면서 추후 확장성을 고려했을 때 편리한 **Github-flow**를 적용했습니다. 

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

  스플래시 화면

  ​	데이터 없이 일정 시간 후 rootViewController를 선택 화면 1로 변경

  <img width=500 src="https://github.com/user-attachments/assets/4b152766-a4ae-44a1-a298-6db2bc020860">

  선택 화면 1

  ​	데이터 없이 선택된 카테고리를 내부 저장하고 선택 화면 2로 이동

  <img width=500 src="https://github.com/user-attachments/assets/35cc7e85-85b2-4ecd-90d2-3dca8b5b27aa">

  선택 화면 2

  ​	TMDB - Genres - Movie/TV Series 에서 데이터를 받아 장르 카테고리 노출

  ​	선택된 장르를 내부 저장하여 추천작 화면으로 이동

  <img width=500 src="https://github.com/user-attachments/assets/d5dbce29-0285-4be2-8d59-d543e808cb51">

  추천작 화면

  ​	TMDB - Discover - Movie/TV Series 에서 데이터를 받아 추천작 노출

  ​	작품이 선택되면 상세 화면으로 이동

  <img width=500 src="https://github.com/user-attachments/assets/d5dbce29-0285-4be2-8d59-d543e808cb51">

  상세 화면

  ​	TMDB - Movies/TV Series

  ​	Details, Credits, ReleaseDates/ContentRatings, Videos 동시 호출하여 받은 데이터 노출

  <img width=500 src="https://github.com/user-attachments/assets/6fa0182a-777d-4fc5-85a5-0665392b8994">

  

