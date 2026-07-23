# Standardization Rule

연구실 데이터의 일관성을 위해 아래 표준화 규칙을 정의합니다.
모든 Processed/Curated 데이터는 본 규칙을 따라야 합니다.

> ⚠️ 규칙 변경 시 버전(v2026.MM)을 태깅하고 CHANGELOG.md에 기록할 것

## 개정 이력
| 버전 | 날짜 | 변경 내용 | 작성자 |
|---|---|---|---|
| v2026.07 | 2026-07-XX | 초안 작성 | |

## 1. Disease 명칭 표준
- 표준 용어집: (예: MONDO, ICD-10 등 채택 기준 명시)
- 명명 규칙: (예: 소문자, 공백은 `_` 로 대체)

| 원본 표기 예시 | 표준 명칭 | 근거/출처 |
|---|---|---|
| | | |

## 2. Gene ID 표준
- 채택 기준: (예: Entrez Gene ID / HGNC Symbol / Ensembl ID 중 택1)
- 변환 규칙: (예: Symbol → Entrez ID 매핑 시 사용하는 참조 파일)
- 매핑 함수: `R/standardize_ids.R`

## 3. Sample ID 표준
- 명명 규칙: (예: `{Project}_{Batch}_{SampleNumber}`)
- 중복/결측 처리 규칙:

## 4. 결측치/이상치 처리 규칙
- 결측치 표기: (예: `NA`로 통일, 빈 문자열 금지)
- 이상치 정의 및 QC 기준: `R/qc_checks.R` 참조

## 5. 파일/버전 명명 규칙
- Raw 데이터: `raw_{source}_{YYYYMMDD}.csv`
- Processed 데이터: `processed_{dataset}_{vYYYY.MM}.csv`
- Curated 데이터: `curated_{project}_{vYYYY.MM}.csv`
