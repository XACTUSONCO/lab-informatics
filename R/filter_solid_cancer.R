library(data.table)

# Pilot input
model <- fread("data/raw/26Q1_Model.csv")
expr <- fread(
  "data/raw/OmicsExpressionTPMLogp1HumanProteinCodingGenes_pilot.csv"
)

# Solid cancer filtering
model_solid <- model[
  !OncotreeLineage %in% c("Lymphoid", "Myeloid") &
    OncotreePrimaryDisease != "Non-Cancerous"
]

solid_ids <- model_solid$ModelID

# Metadata source
meta <- model_solid[, .(
  ModelID,
  StrippedCellLineName,
  OncotreeCode,
  OncotreeLineage,
  OncotreePrimaryDisease
)]

# Default entry
expr_default <- expr[IsDefaultEntryForModel == "Yes"]

# Solid cancer
expr_solid <- expr_default[ModelID %in% solid_ids]

# Metadata merge
expr_solid <- merge(
  meta,
  expr_solid,
  by = "ModelID"
)

# ----------------------------------------------------
# 1. Metadata 분리
# ----------------------------------------------------

metadata <- expr_solid[, .(
  `Sample ID` = StrippedCellLineName,
  `Data Type` = "RNA",
  Source = "DepMap 26Q1",
  `Cell Line Name` = StrippedCellLineName,
  `Cell Line ID` = StrippedCellLineName,
  Tissue = OncotreeLineage,
  `Disease Type` = OncotreePrimaryDisease
)]

# ----------------------------------------------------
# 2. Expression에 필요 없는 metadata / index 컬럼 제거
# ----------------------------------------------------

drop_expr_cols <- intersect(
  c(
    "V1",
    "row_index",
    "ModelID",
    "SequencingID",
    "ModelConditionID",
    "IsDefaultEntryForMC",
    "IsDefaultEntryForModel",
    "OncotreeCode",
    "OncotreeLineage",
    "OncotreePrimaryDisease"
  ),
  names(expr_solid)
)

expr_solid[, (drop_expr_cols) := NULL]

setnames(
  expr_solid,
  "StrippedCellLineName",
  "CELL_LINE_NAME"
)

# ----------------------------------------------------
# 3. Gene 표기: "TP53 (7157)" -> "TP53_7157"
# ----------------------------------------------------

gene_cols <- setdiff(
  names(expr_solid),
  "CELL_LINE_NAME"
)

setnames(
  expr_solid,
  gene_cols,
  gsub(
    "^(.*?)\\s*\\((\\d+)\\)$",
    "\\1_\\2",
    gene_cols
  )
)

# ----------------------------------------------------
# 4. Annotation 생성
# ----------------------------------------------------

gene_names <- setdiff(
  names(expr_solid),
  "CELL_LINE_NAME"
)

annotation <- data.table(
  `Gene Symbol` = sub("_(\\d+)$", "", gene_names),
  `Entrez ID` = sub("^.*_(\\d+)$", "\\1", gene_names),
  `Ensembl ID` = NA_character_,
  `Gene Type` = NA_character_
)

# ----------------------------------------------------
# 5. Matrix 방향: Cell Line x Gene -> Gene x Sample
# ----------------------------------------------------

expr_long <- melt(
  expr_solid,
  id.vars = "CELL_LINE_NAME",
  variable.name = "Gene",
  value.name = "Expression"
)

expr_processed <- dcast(
  expr_long,
  Gene ~ CELL_LINE_NAME,
  value.var = "Expression"
)

# ----------------------------------------------------
# 6. Processed output 저장
# ----------------------------------------------------

dir.create(
  "data/processed",
  showWarnings = FALSE,
  recursive = TRUE
)

fwrite(
  expr_processed,
  "data/processed/RNA_DepMap_CellLine_TPMLogp1_26Q1.csv"
)

fwrite(
  metadata,
  "data/processed/metadata.csv"
)

fwrite(
  annotation,
  "data/processed/annotation.csv"
)