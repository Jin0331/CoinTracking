# 🪙 **Coin Tracking - 암호화폐 추적**

![merge](https://github.com/Jin0331/CoinTracking/assets/42958809/0b39e0ee-67e8-4959-996e-5bc73ca144a7)

> 출시 기간 : 2024.02.27 - 03.14 (약 3주)
>
> 개발 1인
>
> 프로젝트 환경 - iPhone 전용(iOS 15.0+), 라이트 모드 고정

---

## 🔎 **한줄소개**

***가볍고, 빠른 암호화폐 추적***

<br>

## 🔎 **핵심 기능**

* **실시간 암호화폐 가격 및 변동폭 조회**

* **변동폭 그래프를 통한 실시간 고가, 저가, 신고점, 신저점 조회**

* **암호화폐 즐겨찾기**

<br>


## 🔎 **적용 기술**

* ***프레임워크***

  ​	UIKit

* ***아키텍쳐***

  ​	MVVM

* ***오픈 소스***

  ​	RxSwift / Realm / Alamofire / Kingfisher / SnapKit / DGChart

* ***버전 관리***

  ​	Git / Github

<br>

## 🔎 **적용 기술 소개**

***MVVM***

* View 및 Business 로직을 분리하기 위한 `MVVM` 아키텍처를 도입

* `Input-Output 패턴`의 Protocol을 채택함으로써 User Interaction과 View Data 핸들링

    ```swift
    protocol ViewModelType {
        var disposeBag : DisposeBag { get }
        associatedtype Input
        associatedtype Output
        func transform(input : Input) -> Output
    }
    ```

***Reactive Programming***

* 비동기 Event의 관리를 위한 `RxSwift`를 이용한 Reactive Programming 구현

***Realm***

* Repository Pattern 기반의 데이터 로직 추상화

* 아래와 같은 Database Schema 구성 (**1:1, 1:N**)

  ![Untitled](https://github.com/Jin0331/CoinTracking/assets/42958809/d2adee0f-eec0-4743-9164-bb73c026ec3b)

***Alamofire***

* `URLRequestConvertible`을 활용한 `Router 패턴` 기반의 네트워크 통신 추상화

<br>

## 🪙 트러블슈팅

### 1. CoinGecko API(Public plan)의 호출 Limit 대응

* **문제 상황**

  > ​	CoinGecko의 Public API는 분당 5~15회 호출로 제한되어 있음. 상위 API Plans을 비용을 지불할 경우 간단하게 해결될 수 있지만, $129 ~ $499/mo의 비용으로 분포됨
  >
  > 해당 앱의 경우, 사용자에게 빠른 검색과 조회를 제공함에 따라 사용자의 앱 사용 유지시간이 길지 않으므로, 해당 API Plans을 사용하여 지속적으로 API 호출하는 것은 부담되는 상황

* **해결 방법**

  1. ``Realm``을 활용하여, API 호출이 정상적으로 이루어졌을 때, 해당 정보를 ``Market``, ``CoinChange`` Table에 해당 정보를 저장하며, ``lastUpdated`` Column에 API가 정상적으로 호출된 시점을 저장

  2. ``Custom Toast View``를 활용하여, API Rate Limit이 Error가 발생했을 경우, Toast View를 통하여 사용자에게 알림 전송하며, API가 정상적으로 호출되었을 때의 데이터를 나타냄

  <p align="center">
      <img src="https://github.com/Jin0331/CoinTracking/assets/42958809/a6ef4d3f-8491-4aab-8351-883ec7344310" width="30%" height="30%"/>
  </p>
