# The following code installs the extra R packages for SICSS 2026.
# It is meant to be run within the SANE environment.

files <- list.files(
  "S:/scripts/install_extra_r_packages_for_sicss26/extra_r_packages_for_sane",
  pattern = "\\.zip$",
  full.names = TRUE
)

install.packages(
  files,
  repos = NULL,
  type = "win.binary"
)
