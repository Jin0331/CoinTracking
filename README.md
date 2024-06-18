# 🔎 **Coin Tracking - 빠른 암호화폐 추적**

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

    protocol CombineViewModelType : AnyObject, ObservableObject {
        associatedtype Input
        associatedtype Output
        
        var cancellables : Set<AnyCancellable> {get set}
        
        var input : Input {get set}
        var output : Output {get set}
        
        func transform()
    }
    ```

***Reactive Programming***

* 비동기 Event의 관리를 위한 `RxSwift`와 `Combine`를 이용한 Reactive Programming 구현

***Alamofire***

* `URLRequestConvertible`을 활용한 `Router 패턴` 기반의 네트워크 통신 추상화

***UserDefault***

* 사용자의 로그인, 검색, 프로필 기록 저장을 위한 `User Default` 사용

* `propertyWrapper`와 `Generic`의 사용으로 반복되는 코드 사용의 최소화

```swift
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

'''
@UserDefault(key: UDKey.profileImage.rawValue, defaultValue: "")
var profileImage: String

```
