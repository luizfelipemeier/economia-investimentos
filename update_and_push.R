# update_and_push.R

# Instale ou carregue os pacotes necessários
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

# Verificar se o diretório de bibliotecas local existe
local_lib <- file.path(Sys.getenv("GITHUB_WORKSPACE"), "R/library")

if (!dir.exists(local_lib)) {
  dir.create(local_lib, recursive = TRUE)
}

# Instalar o pacote rmarkdown no diretório local
install.packages("rmarkdown", lib = local_lib, repos = "https://cloud.r-project.org")

# Resto do seu código (se houver)