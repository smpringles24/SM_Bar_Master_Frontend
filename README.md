# 파일 정리 방법
- MVVM을 기반으로 provider를 사용

## 폴더구조
- lib
  - main.dart

  - assets : 이미지, 폰트 등의 파일
    - images : 이미지 파일

  - data : 백엔드와 관련된 코드
    - datasource : 백엔드와 통신하는 메소드
    - model : 백엔드 기반 데이터모델

  - ui : 프론트엔드와 관련된 코드 MVVM패턴 적용
    - album 페이지
    - memory 페이지
    - new_album 페이지

  - utils : 유틸리티 코드
    - types : 타입 정의(enum)
    - 기타 convert : 타입 변환 메소드