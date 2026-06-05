# The following code installs extra R packages for SICSS 2026.
# It is meant to be run within the SANE environment.

package_main_folder_path <- "S:/scripts/extra_r_packages_for_sane/downloaded_r_packages"

# Install the CRAN binary packages first
files <- list.files(
  file.path(package_main_folder_path, "cran"),
  pattern = "\\.zip$",
  full.names = TRUE
)

install.packages(
  files,
  repos = NULL,
  type = "win.binary"
)

# Install the `dsl` package, which is only available as a source package
dsl_package_path <- file.path(
  file.path(package_main_folder_path, "source"),
  "dsl.zip"
)

install.packages(
  dsl_package_path,
  repos = NULL,
  type = "source"
)