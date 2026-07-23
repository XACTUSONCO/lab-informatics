# Lab Informatics Repository

## 목적
본 Repository는 연구실 공통 데이터 관리 및 분석 환경을 표준화하기 위해 구축되었습니다.
연구원 개인별로 다르게 관리되던 데이터 전처리, 분석 코드, 문서를 하나의 체계로 통합하여
- 재현 가능한 분석 (Reproducibility)
- 데이터 이력 추적 (Traceability)
- 신규 연구원 Onboarding 용이성

을 확보하는 것을 목표로 합니다.

## Repository 구조
```
lab-informatics/
├── README.md                  ← 본 문서
├── CONTRIBUTING.md            ← 협업 규칙 (Branch, PR, Code Review)
├── DATA_DICTIONARY.md         ← 데이터 컬럼/변수 정의
├── STANDARDIZATION_RULE.md    ← Disease 명칭, Gene ID 등 표준화 규칙
├── CLAUDE.md                  ← Claude Enterprise 운영 가이드
├── CHANGELOG.md               ← 월간 변경 이력 기록
├── data_manifest/             ← 데이터 출처/버전/샘플 정보
├── data/
│   ├── raw/                   ← 원본 데이터 (수정 금지)
│   ├── processed/             ← 표준화 규칙 적용된 공용 데이터
│   └── curated/                ← 목적별 통합 분석용 데이터
├── R/                          ← 공통 함수
├── analyses/                   ← 연구원별 분석 프로젝트
│   ├── template/
│   └── project_A/
├── tests/                      ← 공통 함수 테스트 (testthat)
└── .github/                    ← GitHub 협업/자동화 설정
    ├── pull_request_template.md
    └── workflows/
```

## 데이터 관리 원칙 (3단계)
| 단계 | 설명 | 수정 가능 여부 |
|---|---|---|
| Raw | 외부에서 받은 원본 데이터 | 절대 수정 금지 |
| Processed | Raw를 연구실 표준으로 정제한 공용 데이터 | 표준화 규칙 변경 시에만 재생성 |
| Curated | 여러 Processed를 목적에 맞게 통합한 분석용 데이터 | 분석 목적에 따라 갱신 |

모든 연구원은 반드시 **Processed 또는 Curated 단계**에서 분석을 시작합니다.

## 시작하기 (신규 연구원)
1. 본 Repository를 clone (GitHub의 코드를 내 컴퓨터로 복사)
2. `renv::restore()` 로 분석 환경 복원 (연구실 표준 R 패키지 버전 자동 설치)
3. `analyses/template/` 을 복사하여 본인 프로젝트 시작 
4. `DATA_DICTIONARY.md`, `STANDARDIZATION_RULE.md` 필독 (컬럼 의미·규칙 확인 후 작업 시작)

## 문서 갱신 주기
본 Repository의 모든 표준 문서는 **매월 1회** 갱신됩니다. 
자세한 절차는 `CONTRIBUTING.md`의 "월간 유지보수 절차" 항목을 참고하세요.








