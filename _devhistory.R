pkg <- "elbow"

usethis::create_package(pkg)

usethis::use_git()
usethis::use_git_ignore(".DS_Store")
system("git add -A")
system("git commit -m ':tada: Init Repository'")

usethis::edit_file("DESCRIPTION")
## ● Edit 'DESCRIPTION'
system("git add -A")
system("git commit -m ':bulb: Edit Package Metadata'")

usethis::use_gpl3_license(name = "Nicolas Casajus")
system("git add -A")
system("git commit -m ':page_facing_up: Add Package License'")

usethis::use_build_ignore("_devhistory.R")
system("git add -A")
system("git commit -m ':see_no_evil: Ignore {_devhistory}'")

usethis::use_roxygen_md()
system("git add -A")
system("git commit -m ':wrench: Roxygen2 Setup'")

# usethis::use_package_doc()
# devtools::document()
# system("git add -A")
# system("git commit -m 'Edit Package Homepage'")

usethis::use_r("elbow")
## ● Edit 'R/elbow.R' (R code)
system("git add -A")
system("git commit -m ':sparkles: Implement Elbow Method'")

usethis::edit_file(file.path("R", "elbow.R"))
## ● Edit 'R/elbow.R' (Code doc)
devtools::document()
system("git add -A")
system("git commit -m ':bulb: Edit Function Documentation'")

usethis::use_package(package = "stats")
usethis::use_package(package = "graphics")
system("git add -A")
system("git commit -m ':heavy_plus_sign: Add {stats} and {graphics} Dependencies'")

x  <- 0:30
y1 <- c(0, 0.5)
y2 <- c(1, 0.5)

for (i in 2:(length(x) - 1)) {
  y1 <- c(y1, y1[i] + (y1[i] - y1[i - 1]) / 2)
  y2 <- c(y2, y2[i] - (y2[i - 1] - y2[i]) / 2)
}

profiles <- data.frame(
  x                    = x,
  concave_down_pos_slo = y1,
  concave_down_neg_slo = y1[length(y1):1],
  concave_up_pos_slo   = y2[length(y2):1],
  concave_up_neg_slo   = y2
)

usethis::use_data(profiles, internal = FALSE)
system("git add -A")
system("git commit -m ':sparkles: Add {profiles} Dataset'")

usethis::use_r("profiles")
## ● Edit 'R/profiles.R' (Dataset doc)
devtools::document()
system("git add -A")
system("git commit -m ':bulb: Edit Dataset Documentation'")

usethis::edit_file(file.path("R", "elbow.R"))
## ● Edit 'R/profiles.R' (Example section)
system("git add -A")
devtools::document()
system("git commit -m ':bulb: Add Example Section'")

devtools::check()

usethis::use_vignette("introduction")
## ● Edit 'vignettes/introduction.Rmd'
system("git add -A")
system("git commit -m ':books: Edit Package Vignette'")

usethis::use_readme_rmd()
## ● Edit 'README.Rmd'
rmarkdown::render("README.Rmd")
usethis::use_git_ignore("README.html")
system("git add -A")
system("git commit -m ':pencil: Edit README'")

usethis::use_code_of_conduct()
## ● Edit 'CODE_OF_CONDUCT.md'
system("git add -A")
system("git commit -m ':page_facing_up: Add Code of Conduct'")

## ● Remove 'inst/doc' from .gitignore
system("git add -A")
system("git commit -m ':see_no_evil: Track inst/doc'")

usethis::use_github(protocol = "https")

usethis::use_travis()
## ● Edit '.travis.yml'
rmarkdown::render("README.Rmd")
system("git add -A")
system("git commit -m ':construction_work: Travis CI Setup'")
system("git push")

usethis::use_appveyor()
## ● Edit 'appveyor.yml'
rmarkdown::render("README.Rmd")
system("git add -A")
system("git commit -m ':construction_work: Appveyor Setup'")
system("git push")

usethis::use_pkgdown()
pkgdown::build_site()
system("git add -A")
system("git commit -m ':wrench: Pkgdown Setup'")
system("git push")

usethis::use_pkgdown_travis()
travis::use_travis_deploy()
## ● Edit '.travis.yml'
system("git add -A")
system("git commit -m ':rocket: Deploy Website (Travis CI)'")
system("git push")

usethis::use_testthat()
usethis::use_test("elbow")
## ● Edit 'tests/testthat/test-elbow.R'
system("git add -A")
system("git commit -m ':white_check_mark: Tests {elbow} Function'")
system("git push")

usethis::use_coverage("codecov")
## ● Wait a few minutes after adding repository on https://codecov.io
rmarkdown::render("README.Rmd")
system("git add -A")
system("git commit -m ':construction_work: Code Coverage Setup'")
system("git push")

usethis::use_version(which = "major")
