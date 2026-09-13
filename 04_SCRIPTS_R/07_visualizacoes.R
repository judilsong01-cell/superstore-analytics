# Etapa 7 - Visualizacoes
# Graficos PNG reproduziveis gravados em 06_GRAFICOS (R base, sem dependencias).

criar_graficos <- function(clean, analise, project_root) {
  dir.create(file.path(project_root, "06_GRAFICOS"), FALSE, TRUE)
  grafico <- function(nome) file.path(project_root, "06_GRAFICOS", nome)

  z <- analise$performance_by_sub_category
  png(grafico("profit_by_sub_category.png"), 1440, 900, res = 150)
  par(mar = c(5, 9, 4, 2))
  barplot(z$profit, names.arg = z$sub_category, horiz = TRUE, las = 1,
          col = ifelse(z$profit < 0, "#C0392B", "#2471A3"),
          xlab = "Lucro (USD)", main = "Lucro por sub-categoria")
  abline(v = 0, col = "grey40")
  dev.off()

  d <- analise$impact_of_discount
  png(grafico("margin_by_discount.png"), 1440, 900, res = 150)
  par(mar = c(5, 5, 4, 2))
  plot(d$discount * 100, d$profit_margin * 100, type = "b", pch = 19, lwd = 2,
       col = "#B9770E", xlab = "Desconto aplicado (%)", ylab = "Margem de lucro (%)",
       main = "Margem de lucro por nivel de desconto")
  abline(h = 0, col = "#C0392B", lty = 2)
  dev.off()

  m <- analise$performance_monthly
  png(grafico("monthly_sales_profit.png"), 1440, 900, res = 150)
  par(mar = c(6, 5, 4, 2))
  plot(seq_len(nrow(m)), m$sales, type = "l", lwd = 2, col = "#2471A3", xaxt = "n",
       xlab = "", ylab = "USD", main = "Vendas e lucro por mes")
  lines(seq_len(nrow(m)), m$profit, lwd = 2, col = "#1E8449")
  eixo <- seq(1, nrow(m), by = 3)
  axis(1, at = eixo, labels = m$order_month[eixo], las = 2, cex.axis = 0.7)
  legend("topleft", c("Vendas", "Lucro"), col = c("#2471A3", "#1E8449"), lwd = 2, bty = "n")
  dev.off()
}
