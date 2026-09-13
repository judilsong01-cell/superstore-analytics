# Etapa 1 - Importacao
# Le o CSV original de 01_DADOS_BRUTOS sem o modificar.

PROJETO   <- "02_SUPERSTORE_ANALYTICS"
FICHEIRO_LIMPO <- "superstore_limpo.csv"

importar_dados <- function(project_root) {
  pasta <- file.path(project_root, "01_DADOS_BRUTOS")
  csv <- list.files(pasta, pattern = "[.]csv$", full.names = TRUE)
  if (length(csv) == 0L) stop("Importacao falhou: nenhum CSV em ", pasta, call. = FALSE)

  raw <- read.csv(csv[1], check.names = FALSE, stringsAsFactors = FALSE, fileEncoding = "Latin1")
  if (nrow(raw) == 0L || ncol(raw) == 0L) stop("Importacao falhou: dataset vazio.", call. = FALSE)

  message(sprintf("Importado: %s (%d linhas, %d colunas)", basename(csv[1]), nrow(raw), ncol(raw)))
  raw
}
