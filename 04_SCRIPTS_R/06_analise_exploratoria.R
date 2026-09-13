# Etapa 6 - Analise exploratoria
# Rentabilidade por categoria, sub-categoria, regiao e segmento, evolucao
# mensal e concentracao de prejuizo por nivel de desconto.

analisar_dados <- function(clean) {
  resultado <- list()

  for (g in c("category", "sub_category", "region", "segment")) {
    z <- aggregate(cbind(sales, profit, quantity) ~ clean[[g]], clean, sum)
    names(z)[1] <- g
    z$profit_margin <- z$profit / z$sales
    resultado[[paste0("performance_by_", g)]] <- z[order(z$profit_margin), ]
  }

  resultado$performance_monthly <- aggregate(cbind(sales, profit) ~ order_month, clean, sum)

  perdas <- clean[clean$profit < 0, ]
  resultado$loss_concentration <-
    aggregate(cbind(sales, profit, quantity) ~ sub_category + region + discount, perdas, sum)

  resultado$impact_of_discount <- local({
    z <- aggregate(cbind(sales, profit) ~ discount, clean, sum)
    z$profit_margin <- z$profit / z$sales
    z$orders <- as.integer(table(clean$discount)[as.character(z$discount)])
    z
  })

  resultado
}
