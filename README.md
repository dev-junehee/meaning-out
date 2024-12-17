# 🐬 스윔즈 (SwiMZ) - 수영하는 MZ들을 위한 스웸웨어 쇼핑 플랫폼

<br />

<div align="center">
  <img width=180" src="https://github.com/user-attachments/assets/a6b417d5-c83d-45bd-8744-7d3b61e51768" />
  <br /><br />
  <img src="https://img.shields.io/badge/Swift-v5.1-F05138?logo=swift" />
  <img src="https://img.shields.io/badge/Xcode-v15.4-147EFB?logo=Xcode" />
  <img src="https://img.shields.io/badge/iOS-15.0+-000000?logo=apple" />

</div>

<br /><br />

## 기획의도 (Intention)
> ### 수영하는 MZ들이 모이는 공간을 만들어보자!
- "혹시 수영복 어디에서 사세요?", "이 수영복 어떤 브랜드인가요?"
- 다양한 스윔웨어 브랜드를 한 눈에 모아보고 검색할 수 있는 플랫폼이 필요하다고 생각했습니다.
- 스윔즈는 MZ세대를 위한 스윔웨어 쇼핑 플랫폼으로 다양한 스타일과 브랜드를 쉽게 검색하고 비교 할 수 있는 공간입니다.
- 트렌드에 민감한 MZ들을 위해 맞춤형 스윔웨어 검색 결과를 통해 새로운 쇼핑 경험을 제공합니다.

<br />

## 프로젝트 소개 (Description)
> **개발 기간** : 2024. 06. 13 ~ 2024. 06. 18 (약 6일)<br />
> **개발 인원** : 1명 (기획·디자인·개발)<br />
> **최소 버전** : iOS 15.0+<br />
> **지원 모드** : 세로 모드, 라이트 모드

<br />

<div align="center">
  <img width="19%" src="https://github.com/user-attachments/assets/703d3e3f-1534-4af4-9916-a0065f3e566c" />
  <img width="19%" src="https://github.com/user-attachments/assets/2d3a5d8b-f926-4d15-98c9-d06ef000ae38" />
  <img width="19%" src="https://github.com/user-attachments/assets/db06655e-3872-4876-8fbe-d74fbb7ab577" />
  <img width="19%" src="https://github.com/user-attachments/assets/328f54b1-0463-46ba-9f0a-6c8f4b86a3b6" />
  <img width="19%" src="https://github.com/user-attachments/assets/317e0a26-d5d0-4ffb-8c4e-a2cfca065908" />
</div>

<br /><br />

## 사용 기술 및 개발 환경 (Tech Stack & Environment)
- **Language & Tool** : Swift 5.1, Xcode 15.4
- **iOS** : UIKit, WebKit
- **Library** : Kingfisher, SnapKit, TextFieldEffects
- **Architecture** : MVVM
- **Design Pattern** : Observer, Repository, Singleton
- **Network** : Alamofire
- **Local DB** : Realm
- **Management** : Git, GitHub

<br />

## 개발 방식 및 브랜치 전략 (Development & Branch Strategy)
### Issue, Pull Request(PR) 템플릿 활용한 프로젝트 관리
- 개발 시작 전 새로운 Issue 생성 후, Issue와 브랜치를 연결하고 이슈 번호를 브랜치명에 활용하여 일관된 작업 내용 기록
- Issue와 PR 생성 시 레이블을 표기하여 작업 종류와 진행사항을 한 눈에 알 수 있도록 처리
- PR 생성 시 템플릿에 맞게 작업 내용과 스크린샷을 상세히 기록하여 추후에도 프로젝트 진행 현황을 알 수 있도록 문서화

### 작업 단위별 브랜치 관리
- **`main`**
  - 실제 서비스 배포용 브랜치
  - 큰 기능 단위 개발 작업이 완료된 후 병합 (Version Realese)
- **`develop`**
  - 개발 및 QA 작업용 브랜치 (Main 브랜치에서 분기)
  - 각 기능 단위 브랜치 작업이 완료된 후 병합
- **`feat`** , **`design`**, **`fix`**, **`refactor`**...
  - 작은 기능 단위 브랜치 (develop 브랜치에서 분기)
  - Issue, PR, Commit 컨벤션과 동일한 Prefix 사용하여 일관된 작업 구분
- 각 브랜치별 작업 내용 확인을 위해 브랜치명 컨벤션 도입
  - 이슈번호-prefix--작업설명
  - `1-feat-main-search`

<br />

## 주요 기능 (Main Feature)
### 스윔웨어 상품 검색 & 상세 정보
> 최근 검색어, 상품 정렬
- Naver Shopping API 기반의 스윔웨어 상품 검색 기능
- 상품 검색 결과 정렬 옵션 제공 (정확도/날짜순/가격순)
- 웹뷰를 활용한 상품 상세 페이지 조회
- 사용자가 검색한 내용을 저장하여 최근 검색어 목록 제공 & 검색어 클릭 시 검색 결과 연결

### 상품 찜하기
- 사용자가 찜한 상품을 로컬 데이터베이스에 저장
- 찜한 상품을 모아볼 수 있는 목록 기능 제공

### 사용자 설정
- 프로필 설정 및 수정 (프로필 아바타, 닉네임)
- 닉네임 유효성 검사

<br />

## 주요 기술 구현 내용 (Implementation Details)
### Observer 패턴을 적용한 MVVM 아키텍쳐 설계
- 데이터를 관찰하여 값이 변하는지 여부에 따른 데이터 바인딩 처리
- Observable 제네릭 클래스 구현하여 핸들링할 값과 클로저 선언
- 초기화 시점에 데이터를 받아 값에 할당하고, 값이 변할 때 마다 클로저를 호출하여 외부에서 변경된 값을 반영

<br />

### Realm 데이터베이스를 활용해 찜 카테고리와 찜한 상품 기능 구현
- 앱에서 사용할 찜 카테고리와 찜 상품(Item)모델을 정의하고 List 타입을 통해 1:N 관계 설정
- Repository 패턴을 활용해 찜 카테고리 생성/삭제, 찜 상품 저장/삭제 등의 메서드를 구현하고 ViewModel에서 인스턴스 생성하여 메서드 실행

<br />

### Naver Shopping API와 WebKit를 활용한 상품 검색 및 상품 상세 정보 기능 구현
- Singleton 패턴으로 NetworkManager 구현하여 Query 기반 스윔웨어 상품 검색
- 사용자가 입력한 검색어를 기반으로 Default Query를 적용하여 컨셉에 맞는 검색 결과 노출
- URLSession.shared.dataTask를 사용해 네트워크 요청하고 클로저 구문과 Result Type을 통해 네트워크 성공/실패 처리

<br />

### Reusable 프로토콜 구현
- AnyObject를 상속 받는 Reusable 프로토콜 구현
- UIView extension을 활용해 Reuseable을 채택하여 id값 반환하도록 처리
- UIView를 상속받는 클래스는 클래스명을 id로 반환

<br />

### View 객체를 확장하여 공통적으로 활용 가능한 메서드 구현
- BarButton 설정, Alert/ActionSheet 처리, popViewControlle 등 모든 ViewController에서 사용 가능한 기능에 대한 메서드 구현
- 다양한 뷰 객체 Extension을 활용해 기본적인 UI 초기 세팅 함수 정의하여 활용

<br />

### PropertyWrapper를 사용해 간편한 UserDefaults 관리
- UserDefaults로 관리할 속성을 열거형을 활용해 정의
- PropertyWrapper를 사용하여 UserDefaultsWrapper를 구현, 키와 기본값 관리
- UserDefaults 핸들링을 위한 구조체를 구현하고 각 속성을 타입 프로퍼티로 정의하여 간편한 접근 처리

<br />
                                                                                                        
### Base 코드, 공통 컴포넌트, 리소스 관리
- 여러 View에서 공통적으로 활용하는 Base 코드 정의, 필요한 메서드를 오버라이딩하여 사용
- 반복적으로 사용되는 UI를 재사용과 커스텀이 가능하도록 컴포넌트화하여 활용
- 열거형과 타입 프로퍼티를 통해 앱에서 사용하는 문자열, 폰트, 이미지 등의 리소스 코드를 데이터로 인식하여 관리

<br />

### 성능 최적화 & 메모리 누수 방지   
- final, private 키워드를 사용하여 서브클래싱과 오버라이딩을 방지,  파일 외부에서 접근하지 않는 프로퍼티에 대해 접근 제한 처리
- Static Dispatch로 동작하도록 처리함으로써 컴파일 최적화
- 클로저 내부에서 외부 데이터를 참조할 때 [weak self] 처리하여 강한 순환 참조 문제 해결
