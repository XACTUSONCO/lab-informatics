# CLAUDE.md

이 저장소의 PR을 리뷰할 때 지키는 규칙입니다. 표준의 세부 근거는 @STANDARDIZATION_RULE.md 참고.

## IMPORTANT: 절대 규칙
- `data/raw/`의 기존 파일이 수정·삭제된 diff는 반드시 차단하고 사유를 묻는다. 새 파일 추가는 허용.
- `data/processed/`, `data/curated/`에 csv가 아닌 파일(xlsx, txt, tsv 등)이 추가되면 지적한다.

## 파일명
`data/processed/`, `data/curated/`의 파일명은 다음 형식을 따라야 한다:
`[DataType]_[Source]_[Sample/CellLine]_[ExpressionType]_[Version].csv`
벗어나면 어떤 부분이 안 맞는지 구체적으로 짚는다.

## ID / 네이밍
- Cell Line ID는 **Cell Line Name 단독** (예: `A549`). `Name_SIDM`처럼 결합된 형태로 쓰였으면 지적한다.
- Gene 표기: `[Gene Symbol]_[Entrez ID]` (예: `TP53_7157`)
- Protein ID: X 접두어 없어야 한다

## Expression 값 / Matrix 방향
- RNA (Public): Processed 단계는 TPM 스케일 유지. log 변환·배치보정 값이 processed/curated에 원본 대신 들어가 있으면 의도된 것인지 질문한다.
- RNA (Private): Raw Count가 표준. 변환된 값이 들어있으면 지적한다.
- Matrix 방향: RNA는 Gene × Sample, Protein은 Protein Target × Sample. `t()` 등으로 방향이 바뀌었는데 후속 코드가 반영 안 됐으면 지적한다.

## Metadata / Annotation
`metadata.csv`, `annotation.csv`를 새로 만들거나 수정하면 @STANDARDIZATION_RULE.md 7·8절의 필수 컬럼이 빠지지 않았는지 확인한다.

## 저장소 에티켓
- 개인 분석(`analyses/{이름}/`)과 공용 파일(`R/`, `data/processed/`, `data/curated/`, `*.md`)이 같은 PR에 섞여 있으면 분리해서 올리도록 제안한다.
- 개인 분석 폴더 안의 코드 스타일·분석 방법론에는 개입하지 않는다.

## 리뷰 코멘트 스타일
- 위반 사항은 STANDARDIZATION_RULE.md 해당 절을 인용해서 설명한다.
- 의도적 변경인지 확신이 안 서면 단정하지 말고 질문한다.
- 한국어로 작성한다.

## 수동 요청
PR/이슈에서 `@claude`로 멘션되면 그 요청 내용에 집중해서 답한다.
