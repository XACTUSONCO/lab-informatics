# 분석 시작 가이드 (analyses/template)

**현재 이 폴더에는 이 README.md만 있습니다.** 아직 팀 공통 템플릿 파일이 준비되지 않은 상태라, 지금은 "복사"가 아니라 아래 안내를 참고해서 **본인 폴더를 새로 만들어** 시작하시면 됩니다.

## 시작하는 법

1. `analyses/` 아래에 **본인 이름으로 새 폴더**를 만듭니다.
   - 예: `analyses/신예은/`
2. 그 안에서 아래 최소 구조로 분석을 시작합니다.
3. 분석은 RStudio, 엑셀 등 평소 쓰는 프로그램 그대로 사용하시면 됩니다.

```
analyses/
├── template/           ← 지금은 이 README만 있음
└── 신예은/              ← 새로 생성, 여기서 작업 시작
    ├── analysis.R (또는 analysis.Rmd)   # 분석 스크립트 (`STANDARDIZATION_RULE.md` 참고해서 파일명 짓기)
    ├── notes.md                          # 분석 목적, 사용한 데이터 버전, 결론 요약
    └── output/                           # 그림, 표 등 결과물
```

- `analysis.R` 상단에 어떤 데이터를 썼는지 명시하세요 (예: `data/curated/` 어느 파일, 표준 버전 몇 인지)
- `data/raw/`를 직접 분석에 쓰지 마세요 — `data/processed/` 또는 `data/curated/`를 우선 사용하세요
- 표준화 규칙은 저장소 최상위 `STANDARDIZATION_RULE.md`를 참고

## 작업 시 지켜야 할 것

- 작업 시작 전 **항상 Pull** 먼저 (GitHub Desktop → Fetch/Pull origin)
- 개인 분석 폴더 안에서의 작업은 Branch 없이 **main에서 바로** Commit + Push 가능
- 공용 파일(`R/`, `data/processed/`, 표준 규칙 등)을 함께 수정해야 한다면, 그 부분만 별도 Branch + PR로 분리해서 진행

## 반복되는 코드가 보이면 → template에 채워주세요

분석을 하다 반복되는 코드 발견 시 (예: `data/curated/` 불러오는 코드, `R/` 공용 함수 `source()` 하는 부분, 자주 쓰는 QC 코드 등).

`analyses/template/`에 그 뼈대를 채워서 **Pull Request로 제안**해주세요. 이후엔 다른 연구원들이 이 폴더를 실제로 **복사해서** 시작할 수 있게 됩니다. 

## 헷갈릴 때

- "template 폴더를 복사해야 하나요?" → 지금은 비어있어서 복사할 게 없습니다. 위 최소 구조로 새로 만드세요.
- "표준 데이터는 어디 있나요?" → `data/processed/` 또는 `data/curated/`를 확인하세요.
- "공용 함수는 어디 있나요?" → `R/` 폴더의 함수를 불러와 사용하세요.
