## based on https://gist.github.com/mages/1544009
cdir <- setwd("./inst/app/tools/help")

## remove all local png files
list.files("./figures/", pattern = "*.png")
unlink("figures/*.png")
check <- list.files("./figures/", pattern = "*.png")
stopifnot(length(check) == 0)
cat("--", file = "figures/place_holder.txt")

fn <- list.files(pattern = "\\.(md|Rmd)$")
for (f in fn) {
  org <- readLines(f, warn = FALSE)
  changed <- gsub("figures_model/", "https://radiant-rstats.github.io/docs/model/figures_model/", org)
  cat(changed, file = f, sep = "\n")
}

setwd(cdir)

## get package checked
devtools::check_win_devel()

## submit package to CRAN
devtools::submit_cran()

## use the git-tab to manually revert all changes to docs and
## deletion of images

## remove after revering the changes from the code above
unlink("inst/app/tools/help/figures/place_holder.txt")
