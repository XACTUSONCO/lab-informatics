# Lab Informatics

## Purpose

이 저장소는 연구실의 데이터 분석 워크플로우를 표준화하고 재현 가능하게 관리하기 위한 공간입니다.

1. 자주 쓰는 연구 데이터를 표준화된 형식으로 관리
2. 재사용 가능한 전처리·QC 코드를 공유
3. 변경 이력을 GitHub로 관리
4. Claude Code를 활용해 코드 리뷰와 문서화를 보조

## Workflow

```
Research Data
      ↓
Standardization Rules   (STANDARDIZATION_RULE.md)
      ↓
Shared R Functions       (R/)
      ↓
Researcher Analysis      (analyses/)
      ↓
Pull Request
      ↓
Automated Review (Claude, GitHub Actions)
      ↓
Human Review
      ↓
Merge
```

## Repository Structure

```
lab-informatics/
├── STANDARDIZATION_RULE.md   # 연구실 데이터 표준 규칙
├── CLAUDE.md                 # Claude Code 리뷰 규칙
├── PROJECT_STATUS.md         # 프로젝트 진행 현황
├── R/                        # 공용 전처리·QC 함수
├── data/
│   ├── raw/                  # 원본 데이터 (수정하지 않음)
│   ├── processed/            # 표준화 적용된 공용 데이터
│   └── metadata/             # metadata.csv, annotation.csv
├── analyses/
│   └── template/             # 새 분석 시작용 템플릿 → 사용법: template/README.md 참고
└── .github/workflows/        # 자동화 (PR 시 Claude 리뷰 실행)
```

## Getting Started

1. GitHub 계정 생성 후 관리자에게 초대 요청 → Organization 참여
2. [GitHub Desktop](https://desktop.github.com) 설치 후 이 저장소를 Clone
3. 작업 전 항상 Pull, 작업 후 Commit + Push
4. 개인 분석을 시작할 때는 `analyses/template/`을 참고 (자세한 방법은 `analyses/template/README.md`)
5. 공용 파일(`R/`, `data/processed/`, `STANDARDIZATION_RULE.md` 등)을 수정할 때는 Branch를 만들고 Pull Request를 통해 반영 — PR을 열면 Claude가 자동으로 리뷰합니다

전체 GitHub 사용법은 `[GitHub 시작하기]` 교육자료를 참고하세요.

## Rules of Thumb

- **Raw 데이터는 수정하지 않습니다.** `data/raw/`는 원본 보존 전용입니다.
- **공용 파일 수정은 Branch + PR을 통해서만** 진행합니다.
- **데이터 표준은 `STANDARDIZATION_RULE.md`를 따릅니다.** 새로운 표준이 필요하면 PR로 제안하세요.
