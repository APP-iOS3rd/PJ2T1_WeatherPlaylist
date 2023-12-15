# 하늘이노래
>
> 개발기간 : 2023.12.07 ~ 2023.12.14

# 배포주소

> [Firebase 배포](https://appdistribution.firebase.dev/i/e11c50d822e09f64)
> 테스트 계정 : spotifytester12312@gmail.com
> 테스트 비번 : 1q2w3e4r1!
# 목차

- 프로젝트 설명
- 사용 기술
- 팀원
- 화면
- 주요 기능
- 아키텍처

# 프로젝트 설명

🕶️  **“날씨도 선선한데 미뤘던 방청소나 해볼까나!”**

☔  **파전이 땡기는 오늘, 이 노래 어때요?**

👾  **쌀쌀한 날엔 홈카페 오픈, 행복지수 높아주는 데일리 팝은 어때요?**

🎄  **눈 없는 크리스마스인데 눈오는 노래 들어볼래요?**

오늘 이 노래는 더운 여름엔 시원하고 청량한 노래들을, 추운 겨울에는 포근하고 따뜻한 노래들을 담은 플레이리스트를 불러와 추천해주는 앱이에요!

# Contributer
| 김태훈             | 김성엽                                   | 여현서                             | 정정욱                                                       | 이명섭                                   | 김소혜     |
| ------------------ | ---------------------------------------- | ---------------------------------- | ------------------------------------------------------------ | ---------------------------------------- | ---- |
| 프로젝트 구성하기  | Start뷰 구현                             | 플레이리스트 뷰 구현               | MainView 구현                                                | 플레이리스트 뷰 구현                     |  앱 디자인    |
| API 프로토콜 제작  | Webkit을 이용해 token값 받아오기(로그인) | CMTime을 이용한 실시간 뷰 업데이트 | WeatherAPI 사용자 날씨, 현위치 데이터 가져오기               | AVPlayer를 이용한 음악재생 플레이어 구현 |PlayMusic 뷰 구현      |
| 마이페이지 뷰 구현 |                                          |                                    | 사용자 날씨 데이터를 가지고 SpotifyAPI에 알맞은 쿼리로 PlayList 가져오기 구현 |                                          |Bottom Drawer 기능 구현      |
| API 연결 기능 구현 |                                          |                                    |                                                              |                                          |      |
| 앱 배포 및 관리    |                                          |                                    |                                                              |                                          |      |

# API

[OpenWeather](https://openweathermap.org/current)

[Spotify](https://developer.spotify.com/documentation/web-api)

# **사용 기술**

| 이름         | 설명                          |
| ------------ | ----------------------------- |
| CLLocation   | 위치 정보 얻어오기            |
| AVFoundation | 음악 재생 정지 등의 기능 구현 |
| SwiftUI      | 뷰 구현                       |
| URLSession   | HTTP 통신                     |
| WebKit       | 로그인 구현                   |

# 화면

|                로그인 뷰                 |
| :--------------------------------------: |
|  <img src="https://p.ipic.vip/c6prwb.gif" alt="image-20231214150246412"  />  |

|                           메인 뷰                            |
| :----------------------------------------------------------: |
| <img src="https://p.ipic.vip/yvj7k4.gif" alt="image-20231214150246412"  /> |

|                       플레이리스트 뷰                        |
| :----------------------------------------------------------: |
| <img src="https://p.ipic.vip/hrdwew.gif" alt="image-20231214150441517" width="200" height="432" /> |

|                        마이페이지 뷰                         |
| :----------------------------------------------------------: |
| <img src="https://p.ipic.vip/ce6443.png" alt="image-20231214151635373" width="200" height="432"  /> |

|                        뮤직플레이 뷰                         |
| :----------------------------------------------------------: |
| <img src="https://p.ipic.vip/y0wzbd.png" alt="image-20231214151542384" width="200" height="432" /><img src="https://p.ipic.vip/x2fg89.png" alt="image-20231214151601936"  width="200" height="432" /> |



#  기능



1. 오늘의 날씨에 맞는 단어들을 조합해 다양한 플레이리스트를 사용자에게 추천 및 재생해준다.
2. 마음에 드는 플레이리스트를 언제든 들을수있는 저장기능을 제공한다.
3. 

# 프로젝트 구조

```
📦WeatherPlaylist
 ┣ 📂Assets.xcassets
 ┣ 📂Models
 ┃ ┣ 📂NetworkDTO
 ┃ ┃ ┣ 📜SearchResponse.swift
 ┃ ┃ ┣ 📜TrackListResponse.swift
 ┃ ┃ ┣ 📜UserInfoResponse.swift
 ┃ ┃ ┣ 📜UserPlaylistDTO.swift
 ┃ ┃ ┗ 📜UserPlaylistResponse.swift
 ┃ ┣ 📜MusicModel.swift
 ┃ ┣ 📜RecommendedPlayListModel.swift
 ┃ ┗ 📜UserInformationModel.swift
 ┣ 📂Preview Content
 ┃ ┣ 📂Preview Assets.xcassets
 ┃ ┃ ┗ 📜Contents.json
 ┃ ┗ 📜ApiKeys.plist
 ┣ 📂Resource
 ┃ ┣ 📂Configuration
 ┃ ┃ ┗ 📜SpotifyAPI.xcconfig
 ┃ ┣ 📂Font
 ┃ ┗ 📜Launch Screen.storyboard
 ┣ 📂Source
 ┃ ┣ 📂Extensions
 ┃ ┃ ┣ 📜Alignment+Extensions.swift
 ┃ ┃ ┣ 📜Color+Extensions.swift
 ┃ ┃ ┣ 📜Font+Extensions.swift
 ┃ ┃ ┣ 📜HorizontalAlignment+Extensions.swift
 ┃ ┃ ┣ 📜Sequence+Extensions.swift
 ┃ ┃ ┣ 📜String+Extensions.swift
 ┃ ┃ ┣ 📜UIkit+Extensions.swift
 ┃ ┃ ┣ 📜VerticalAlignment+Extensions.swift
 ┃ ┃ ┗ 📜View+Extensions.swift
 ┃ ┣ 📂PlayerManager
 ┃ ┃ ┗ 📜PlayerManager.swift
 ┃ ┣ 📂Singleton
 ┃ ┃ ┣ 📂Weather
 ┃ ┃ ┃ ┣ 📂Model
 ┃ ┃ ┃ ┃ ┗ 📜WeatherModel.swift
 ┃ ┃ ┃ ┣ 📜LocationManager.swift
 ┃ ┃ ┃ ┣ 📜WeatherAPI.swift
 ┃ ┃ ┃ ┣ 📜WeatherLogic.swift
 ┃ ┃ ┃ ┗ 📜WeatherTestView.swift
 ┃ ┃ ┣ 📜HapticManager.swift
 ┃ ┃ ┗ 📜SigningManager.swift
 ┃ ┣ 📂ViewModifier
 ┃ ┃ ┗ 📜ImageModifier.swift
 ┃ ┣ 📜APIProtocol.swift
 ┃ ┣ 📜CachedImage.swift
 ┃ ┗ 📜UserRequest.swift
 ┣ 📂Views
 ┃ ┣ 📂Components
 ┃ ┃ ┣ 📂BadgeView
 ┃ ┃ ┃ ┣ 📜BadgeButton.swift
 ┃ ┃ ┃ ┣ 📜BadgeModel.swift
 ┃ ┃ ┃ ┣ 📜BadgeView.swift
 ┃ ┃ ┃ ┗ 📜BadgeViewModel.swift
 ┃ ┃ ┣ 📂BottomDrawer
 ┃ ┃ ┃ ┣ 📜BottomDrawer.swift
 ┃ ┃ ┃ ┣ 📜BottomDrawerModifier.swift
 ┃ ┃ ┃ ┣ 📜CustomCorners.swift
 ┃ ┃ ┃ ┗ 📜DrawerExtension.swift
 ┃ ┃ ┣ 📂HeaderView
 ┃ ┃ ┃ ┗ 📜HeaderView.swift
 ┃ ┃ ┣ 📂PlayFooterCell
 ┃ ┃ ┃ ┣ 📜CustomSlider.swift
 ┃ ┃ ┃ ┗ 📜PlayFooterCell.swift
 ┃ ┃ ┗ 📜Border+Shape.swift
 ┃ ┣ 📂MainView
 ┃ ┃ ┣ 📂MainViewModel
 ┃ ┃ ┃ ┣ 📜MainPageViewModel.swift
 ┃ ┃ ┃ ┗ 📜RecommendedViewModel.swift
 ┃ ┃ ┣ 📜MainPageView.swift
 ┃ ┃ ┣ 📜PlaylistHorizontal.swift
 ┃ ┃ ┗ 📜PlaylistVertical.swift
 ┃ ┣ 📂MypageView
 ┃ ┃ ┣ 📂MyPageSubView
 ┃ ┃ ┃ ┣ 📜PlaylistScrollView.swift
 ┃ ┃ ┃ ┗ 📜ProfileView.swift
 ┃ ┃ ┣ 📜MyPageView.swift
 ┃ ┃ ┣ 📜ProfileModel.swift
 ┃ ┃ ┗ 📜ProfileViewModel.swift
 ┃ ┣ 📂PlayMusicView
 ┃ ┃ ┣ 📜PlayMusicListModel.swift
 ┃ ┃ ┣ 📜PlayMusicModel.swift
 ┃ ┃ ┣ 📜PlayMusicView.swift
 ┃ ┃ ┗ 📜PlayMusicViewModel.swift
 ┃ ┣ 📂PlaylistView
 ┃ ┃ ┣ 📂PlaylistSubView
 ┃ ┃ ┃ ┣ 📜NavigationHeaderView.swift
 ┃ ┃ ┃ ┣ 📜PlaylistControllerView.swift
 ┃ ┃ ┃ ┣ 📜PlaylistCoverImageSmallView.swift
 ┃ ┃ ┃ ┣ 📜PlaylistCoverImageView.swift
 ┃ ┃ ┃ ┣ 📜PlaylistHeader.swift
 ┃ ┃ ┃ ┗ 📜PlaylistRowView.swift
 ┃ ┃ ┣ 📜PlaylistModel.swift
 ┃ ┃ ┣ 📜PlaylistView.swift
 ┃ ┃ ┗ 📜PlaylistViewModel.swift
 ┃ ┣ 📂StartView
 ┃ ┃ ┣ 📂StartSubViews
 ┃ ┃ ┃ ┣ 📜AuthView.swift
 ┃ ┃ ┃ ┣ 📜LaunchView.swift
 ┃ ┃ ┃ ┗ 📜LoginView.swift
 ┃ ┃ ┣ 📜AuthManager.swift
 ┃ ┃ ┣ 📜RootView.swift
 ┃ ┃ ┣ 📜StartView.swift
 ┃ ┃ ┣ 📜StartViewModel.swift
 ┃ ┃ ┗ 📜WeatherPlaylist-Bridging-Header.h
 ┣ 📜ApiKeys.plist
 ┣ 📜Info.plist
 ┗ 📜WeatherPlaylistApp.swift
```
# 협업 방식

저희 팀은 크게 두 가지 방식으로 협업을 진행했습니다!

1. Discord를 통한 소통

   저희 팀은 소통 채널로 디스코드를 선택했습니다! 기존에 사용하고 있기도 했었고, 다양한 기능들로 소통을 할 수 있어 보였습니다. 대표적으로 깃허브 알리미가 있는데요, 웹후크를 걸어 두어서 모든 Commit, PR등이 생성되었을 때 알림을 주어 바로 바로 코드리뷰를 진행할 수 있었습니다.

   ![image-20231214160935473](https://p.ipic.vip/t00a8c.png)

2. Notion 워크스페이스를 통한 일정관리와 문서화

   저희 팀은 노션 워크스페이스를 활용하여 문서화와 일정 및 작업 관리를 했습니다. 크게 작업/회의/문서 세 가지 기능으로 나누어 사용했습니다.

   1. 작업 탭 - 내가 할 일을 발급해서 관리해보자!

      작업 탭에서는 회의를 통해 나눈 일감들을 문서화 하여 `시작 전` `진행 중` `완료` 세 가지 상태를 가지게 만들었습니다!

      ![image-20231214161455608](https://p.ipic.vip/d7xc1g.png)

   2. 회의 탭 -

       매일 오전/오후 회의를 통해서 1일별 회고와 그날 할 일을 나누는 작업을 하였고, 그걸 문서화 하였습니다.

      ![image-20231214161747743](https://p.ipic.vip/6rko28.png)

   3. 문서 탭

      문서 탭에서는 프로젝트에서 사용될 API문서에 대한 정리와 더불어, Code convention과 팀 룰들 문서를 작성해 보았습니다.
      ![image-20231214162119907](https://p.ipic.vip/0gqylm.png)
