# The following code downloads the extra R packages for SICSS 2026.
# It is meant to be run on your local machine with Internet access.

pkgs <- c("grf", "estimatr", "SuperLearner", "arm", "matrixcalc",
          "sf", "terra", "tidyterra", "lwgeom", "tmap", "leaflet",
          "mapview", "spdep", "spatialreg", "sfdep")

dir_name <- "extra_r_packages_for_sane"
dir.create(dir_name, showWarnings = FALSE)

ap <- available.packages(
  repos = "https://cloud.r-project.org",
  type = "win.binary"
)

deps <- tools::package_dependencies(
  pkgs,
  db = ap,
  which = c("Depends", "Imports", "LinkingTo"),
  recursive = TRUE
)

all_pkgs <- unique(c(pkgs, unlist(deps)))
all_pkgs <- setdiff(all_pkgs, rownames(installed.packages(priority = "base")))

download.packages(
  all_pkgs,
  destdir = dir_name,
  repos = "https://cloud.r-project.org",
  type = "win.binary"
)
