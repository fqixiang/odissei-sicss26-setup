# The following code downloads the extra R packages for SICSS 2026.
# It is meant to be run on your local machine with Internet access.

# Download CRAN packages and their dependencies
pkgs <- c("grf", "estimatr", "SuperLearner", "arm", "matrixcalc",
          "sf", "terra", "tidyterra", "lwgeom", "tmap", "leaflet",
          "mapview", "spdep", "spatialreg", "sfdep")

main_pkg_dir_name <- "downloaded_r_packages"
main_pkg_dir_path <- here::here("extra_r_packages_for_sane", main_pkg_dir_name)
cran_pkg_dir_path <- file.path(main_pkg_dir_path, "cran")
source_pkg_dir_path <- file.path(main_pkg_dir_path, "source")
dir.create(cran_pkg_dir_path, showWarnings = FALSE)
dir.create(source_pkg_dir_path, showWarnings = FALSE)

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
  destdir = cran_pkg_dir_path,
  repos = "https://cloud.r-project.org",
  type = "win.binary"
)

# Download the `dsl` package from GitHub
download.file(
  "https://github.com/naoki-egami/dsl/archive/refs/heads/master.zip",
  destfile = file.path(source_pkg_dir_path, "dsl.zip"),
  mode = "wb"
)
