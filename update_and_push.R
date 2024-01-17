# update_and_push.R

# Configurar o diretório de bibliotecas local
local_lib <- file.path(Sys.getenv("GITHUB_WORKSPACE"), "R/library")
Sys.setenv(R_LIBS_USER = local_lib)

# Instalar ou carregar os pacotes necessários
if (!requireNamespace("rmarkdown", quietly = TRUE)) install.packages("rmarkdown")
if (!requireNamespace("usethis", quietly = TRUE)) install.packages("usethis")

# Renderize todos os arquivos R Markdown para HTML
files <- list.files(pattern=".Rmd$", recursive=TRUE, full.names = TRUE)
for (file in files) {
  rmarkdown::render(file)
}

# Commit e push para o GitHub
usethis::use_git()
usethis::use_github_action("gh-pages")