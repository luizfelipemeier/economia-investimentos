# update_and_push.R

# Configurar o diretório de bibliotecas local
local_lib <- file.path(Sys.getenv("GITHUB_WORKSPACE"), "R/library")
if (!dir.exists(local_lib)) dir.create(local_lib, recursive = TRUE)
.libPaths(c(local_lib, .libPaths()))

# Carregar o token pessoal do arquivo .Renviron
Sys.setenv(GITHUB_PAT = Sys.getenv("GITHUB_PAT"))

# Instalar ou carregar os pacotes necessários
install.packages(c("curl",
                   "credentials",
                   "httr2", 
                   "gert", 
                   "gh",
                   "rmarkdown",
                   "usethis",
                   "bookdown",
                   "GetBCBData",
                   "sidrar",
                   "ggplot2",
                   "tidyverse",
                   "dplyr",
                   "lubridate",
                   "knitr",
                   "kableExtra",
                   "forcats",
                   "DT",
                   "plotly",
                   "highcharter",
                   "GetBCBData"), lib = local_lib, repos = "https://cloud.r-project.org")

# Renderizar todos os arquivos R Markdown para HTML
files <- list.files(pattern=".Rmd$", recursive=TRUE, full.names = TRUE)
for (file in files) {
  rmarkdown::render(file)
}

# Commit e push para o GitHub
usethis::use_git()
usethis::use_github_action("gh-pages")