# Instalar o pacote rmarkdown diretamente do CRAN
install.packages("rmarkdown")

# Carregar o token pessoal do arquivo .Renviron
Sys.setenv(GITHUB_PAT = Sys.getenv("GITHUB_PAT"))

# Instalar ou carregar os pacotes necessários
install.packages("usethis")
remotes::install_github("r-lib/usethis")
install.packages("rmarkdown", lib = local_lib, repos = "https://cloud.r-project.org")

# Renderizar todos os arquivos R Markdown para HTML
files <- list.files(pattern=".Rmd$", recursive=TRUE, full.names = TRUE)
for (file in files) {
  rmarkdown::render(file)
}

# Commit e push para o GitHub
usethis::use_git()
usethis::use_github_action("gh-pages")