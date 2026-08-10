# 데이터 표준화 규칙 (Standardization Rule)

이 문서는 연구실 데이터를 다룰 때 따라야 하는 표준입니다.
`data/processed/`, `data/curated/`에 올라가는 모든 데이터는 이 규칙을 따라야 합니다.
(`data/raw/`는 원본 그대로 두고 이 규칙을 적용하지 않습니다.)

> 근거: `07.29 연구 데이터 표준화계획` 검토 및 연구원 피드백 (2026.08.07 기준)

---

## 1. 공통 표준화 (모든 데이터 유형 공통)

### 1.1 파일명 규칙
```
[DataType]_[Source]_[Sample/CellLine]_[ExpressionType]_[Version]
```
예: `RNA_DepMap_TPM_26Q1.csv`

파일명만 보고 데이터 종류·출처·버전을 파악할 수 있어야 합니다.

### 1.2 파일 형식
- **csv로 통일** (Raw 데이터는 예외 — 원본 형식 그대로 유지)
- 이유: 파일 형식이 섞이면 불러오는 방식과 분석 코드가 달라져 혼란이 생기고, csv는 호환성이 가장 높음

### 1.3 Metadata 관리
- Expression 데이터와 **분리**된 `metadata.csv`로 관리
- Sample(열)에 대한 설명은 이 파일에서 통일

### 1.4 Annotation 관리
- Expression 데이터와 **분리**된 `annotation.csv`로 관리
- Gene/Protein(행)에 대한 설명은 이 파일에서 통일

---

## 2. RNA (Public 세포주 데이터)

| 항목 | 표준 | 비고 |
|---|---|---|
| Matrix 방향 | **Gene × Sample (Cell Line)** | 유전자 수가 많아 행으로 두는 게 통계 처리 관례상 유리 |
| Expression 값 | **TPM (Processed 단계 기준)** | Processed 단계에서는 TPM 스케일을 유지. log2 변환·batch correction은 Curated 단계에서 수행. |
| Cell Line ID | **Cell Line Name** (예: `A549`) | 띄어쓰기·특수문자 제거, 대문자 통일. ModelID(ACH)로 받아도 Cell Line Name으로 변환. SIDM은 필요 시 별도 열 추가 |
| Gene 표기 | `[Gene Symbol]_[Entrez ID]` (예: `TP53_7157`) | 동의어/중복 문제를 ID로 방지 |

## 3. RNA (Public 환자 데이터)

| 항목 | 표준 | 비고 |
|---|---|---|
| Sample 표기 | **원본 Sample ID 유지** (예: `GSM2420259`, `TCGA-2F-A9KO-01`) | GEO/TCGA에서 이미 고유하게 관리되므로 변형하지 않음. Source 정보는 Metadata에서 별도 관리 |
| Expression 값 | **TPM (Processed 단계 기준)** | Processed 단계에서는 TPM 스케일을 유지. log2 변환·batch correction은 Curated 단계에서 수행. |
| Gene 표기 | `[Gene Symbol]_[Entrez ID]` | 세포주 패널과 동일 규칙 |

## 4. RNA (Private 데이터)

| 항목 | 표준 |
|---|---|
| Matrix 방향 | Gene × Sample |
| Expression 값 | Raw Count |
| Sample 표기 | `[Cell Line]_[Condition]_[Dose]_[Replicate]` (예: `Lovo_Parental_125_1`) — Cell Line은 약어 대신 풀네임 |
| Replicate 표기 | 이름에 포함 |
| Metadata / Annotation | 분리된 파일로 신규 구축 (현재 없음 → 신규 필요) |

## 5. Protein (Public 데이터)

| 항목 | 표준 |
|---|---|
| Matrix 방향 | Protein Target × Sample (Cell Line)  |
| Cell Line ID | **Cell Line Name** (RNA 규칙과 동일) |
| Protein ID | X 제거  |

## 6. Protein (Private 데이터)

| 항목 | 표준 |
|---|---|
| Sample 표기 | `[Cell Line]_[Condition]_[Time]_[Replicate]` (예: `MDAMB468_Control_1H_1`) |

---

## 7. Metadata 구조

### 공통 필수 컬럼
- `Sample ID` / `Data Type` / `Source`

### RNA/Protein (Public, Cell Line) 추가 컬럼
- `Cell Line Name` / `Cell Line ID` / `Tissue` (예: Lung) / `Disease Type` (예: NSCLC)

### RNA/Protein (Public, Patient) 추가 컬럼
- `Cancer Type` / `Clinical Metadata` (예: Response, Visit, Stage, Survival)

### RNA/Protein (Private) 추가 컬럼
- `Cell Line Name` / `Condition` (예: Control) / `Treatment Detail` (예: Navitoclax_260nM) / `Time` (예: 24H) / `Replicate` (예: 1)

## 8. Annotation 구조

### RNA Annotation
- `Gene Symbol` / `Entrez ID` / `Ensembl ID` / `Gene Type`

### Protein Annotation
- `Uniprot ID` / `Gene Symbol` / `Antibody Target`

---

## 데이터 단계 정의

| 단계 | 설명 | 폴더 |
|---|---|---|
| Raw | 원본, 수정 금지 | `data/raw/` |
| Processed | 위 표준 규칙이 적용된 공용 데이터 | `data/processed/` |
| Curated | 분석 목적에 맞게 processed 데이터를 통합한 분석용 데이터 | `data/curated/` |

## 변경 이력

새로운 표준이 필요하거나 기존 표준을 바꿔야 할 경우, 이 문서를 직접 수정하지 말고 **Branch + Pull Request**로 제안해주세요. (공용 파일 수정 규칙과 동일)
