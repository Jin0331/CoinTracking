# 🪙 **Coin Tracking - 빠른 암호화폐 추적**

![merge](https://github.com/Jin0331/CoinTracking/assets/42958809/0b39e0ee-67e8-4959-996e-5bc73ca144a7)

> 출시 기간 : 2024.01.17 - 01.22 (약 2주)
>
> 개발 1인
>
> 프로젝트 환경 - iPhone 전용(iOS 15.0+), 라이트 모드 고정

---

## 🔎 **한줄소개**

***가볍고, 빠른 암호화폐 추적***

<br>

## 🔎 **핵심 기능**

* **실시간 가격 및 변동폭 조회**

* **변동폭 그래프를 통한실시간 고가, 저가, 신고점, 신저점 조회**

* **즐겨찾기 기능**

<br>


## 🔎 **적용 기술**

* ***프레임워크***

  ​	UIKit

* ***아키텍쳐***

  ​	MVVM

* ***오픈 소스***(Cocoapods)

  ​	RxSwift / Realm / Alamofire / Kingfisher / SnapKit / UserDefault

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
