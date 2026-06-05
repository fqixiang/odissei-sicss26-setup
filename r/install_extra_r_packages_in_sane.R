# The following code installs extra R packages for SICSS 2026.
# It is meant to be run within the SANE environment.

package_folder_path <- "S:/scripts/install_extra_r_packages_for_sicss26/extra_r_packages_for_sane"

# Install the CRAN binary packages first
files <- list.files(
  package_folder_path,
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
  package_folder_path,
  "dsl.zip"
)

install.packages(
  dsl_package_path,
  repos = NULL,
  type = "source"
)