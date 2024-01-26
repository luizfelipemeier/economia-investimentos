library(dplyr)

# Exemplo fictício de dados com múltiplos picos e vales
set.seed(123)
df <- data.frame(data = seq(as.Date("2022-01-01"), as.Date("2022-04-10"), by = "days"),
                 preco = cumsum(rnorm(100)))

# Adiciona mais picos e vales
df[c(10, 30, 50), "preco"] <- df[c(10, 30, 50), "preco"] + 10
df[c(20, 40, 60), "preco"] <- df[c(20, 40, 60), "preco"] - 5

# Inicializar variáveis
pico_vale_info <- data.frame()

i <- 1
ultimo_pico <- -Inf

while (i < nrow(df)) {
  # Encontrar pico
  pico <- df[i, "preco"]
  data_pico <- df[i, "data"]
  
  while (i < nrow(df) && df[i, "preco"] >= pico) {
    pico <- df[i, "preco"]
    data_pico <- df[i, "data"]
    i <- i + 1
  }
  
  if (pico > ultimo_pico) {
    # Encontrar vale
    vale <- df[i, "preco"]
    data_vale <- df[i, "data"]
    
    while (i < nrow(df) && df[i, "preco"] <= vale) {
      vale <- df[i, "preco"]
      data_vale <- df[i, "data"]
      i <- i + 1
    }
    
    # Calcular drawdown
    drawdown_info <- data.frame(data_pico = data_pico,
                                data_vale = data_vale,
                                valor_pico = pico,
                                valor_vale = vale,
                                valor_drawdown = ((pico - vale)/pico))
    
    pico_vale_info <- bind_rows(pico_vale_info, drawdown_info)
    
    # Atualizar último pico histórico
    ultimo_pico <- pico
  }
}

# Se a última observação não foi um pico, considerar o último pico histórico
if (i == nrow(df) && df[i, "preco"] != ultimo_pico) {
  data_pico <- df[i, "data"]
  vale <- df[i, "preco"]
  data_vale <- df[i, "data"]
  
  drawdown_info <- data.frame(data_pico = data_pico,
                              data_vale = data_vale,
                              valor_pico = ultimo_pico,
                              valor_vale = vale,
                              valor_drawdown = ultimo_pico - vale)
  
  pico_vale_info <- bind_rows(pico_vale_info, drawdown_info)
}

# Renomear as colunas conforme solicitado
colnames(pico_vale_info) <- c("data do primeiro pico", "data do vale deste período", "valor do pico", "valor do vale", "valor do drawdown")

# Exibir o resultado
print(pico_vale_info)


