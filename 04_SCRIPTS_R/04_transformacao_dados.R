# Etapa 4 - Transformacao
# Converte datas, valida a coerencia entre encomenda e expedicao e deriva
# as variaveis usadas na analise de rentabilidade.

transformar_dados <- function(clean) {
  clean$order_date <- as.Date(clean$order_date, "%m/%d/%Y")
  clean$ship_date  <- as.Date(clean$ship_date,  "%m/%d/%Y")

  if (anyNA(clean$order_date) || anyNA(clean$ship_date)) {
    stop("Transformacao falhou: datas nao interpretaveis.", call. = FALSE)
  }
  if (!all(clean$ship_date >= clean$order_date)) {
    stop("Transformacao falhou: expedicao anterior a encomenda.", call. = FALSE)
  }

  clean$order_year    <- as.integer(format(clean$order_date, "%Y"))
  clean$order_month   <- format(clean$order_date, "%Y-%m")
  clean$prazo_envio   <- as.integer(clean$ship_date - clean$order_date)
  clean$profit_margin <- ifelse(clean$sales == 0, NA_real_, clean$profit / clean$sales)
  clean
}
