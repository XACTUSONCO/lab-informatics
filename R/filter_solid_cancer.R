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

# Annotation
annot <- model_solid[, .(
  ModelID,
  StrippedCellLineName,
  OncotreeCode,
  OncotreeLineage
)]

# Default entry
expr_default <- expr[IsDefaultEntryForModel == "Yes"]

# Solid cancer
expr_solid <- expr_default[ModelID %in% solid_ids]

# Annotation merge
expr_solid <- merge(
  annot,
  expr_solid,
  by = "ModelID"
)

# 기존 연구원 처리 유지 -----------------------------

drop_expr_cols <- intersect(
  c(
    "row_index",
    "ModelID",
    "SequencingID",
    "ModelConditionID",
    "IsDefaultEntryForMC",
    "IsDefaultEntryForModel"
  ),
  names(expr_solid)
)

expr_solid[, (drop_expr_cols) := NULL]

setnames(
  expr_solid,
  "StrippedCellLineName",
  "CELL_LINE_NAME"
)

setcolorder(
  expr_solid,
  c(
    "CELL_LINE_NAME",
    "OncotreeCode",
    "OncotreeLineage"
  )
)

# 기존 연구원 방식:
# "TP53 (7157)" → "TP53"
setnames(
  expr_solid,
  gsub("\\s*\\(\\d+\\)$", "", names(expr_solid))
)