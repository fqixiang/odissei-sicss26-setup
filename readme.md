# SANE Software Setup for ODISSEI-SICSS 2026
This repository documents the software setup for SANE machines used at ODISSEI-SICSS 2026, including the Python and R environments, as well as the LLM models served via Ollama.

By following the instructions in this README, you can:

- Install additional R packages in your SANE machine environment, ensuring you have the necessary tools for your analyses and projects.
- Reproduce the exact software environment of SANE on your local machine, allowing you to develop and test code that will run seamlessly on SANE.

## Install Extra R Packages (SANE Machines)
The default R environment on SANE machines does not include the following packages, which are required for some of the analyses and projects you will be working on: `sf` `terra` `tidyterra` `lwgeom` `tmap` `leaflet` `mapview` `spdep` `spatialreg` `sfdep` `dsl`. To install these packages, follow the steps below:

1. Navigate to `S:/scripts/extra_r_packages_for_sane/` in your SANE machine.
2. Open the `install_extra_r_packages_in_sane.R` script in an R environment (e.g., RStudio).
3. Run the script to install the required packages. 


> If you need to install additional R packages beyond those listed above, you can ask your course instructors for assistance. They can update the "extra_r_packages_for_sane" folder, so that you can install them in your SANE machine by running the updated installation script.


## Reproduce the Software Environment on Your Local Machine
Follow the steps below to reproduce the Python and R environments, as well as the required Ollama LLM models.

### Python 3.8.18 with uv

> All commands in this section are run in a **terminal** (Terminal on macOS; Command Prompt or PowerShell on Windows).

1. Install [uv](https://docs.astral.sh/uv/getting-started/installation/) if not already present:
    ```bash
    # macOS
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Windows
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```

2. Inside your project directory, create the project environment using:
    ```bash
    # macOS
    brew install geos proj pkg-config
    uv sync

    # Windows
    uv sync
    ```

3. Use `uv run` to run your Python scripts, which will ensure they execute within the virtual environment with the correct dependencies:
    ```bash
    uv run python [script].py
    ```

4. [Optional] Start JupyterLab for interactive work with notebooks:
    ```bash
    uv run jupyter lab
    ```

### R 4.5.3 with renv

> Steps 1–2 are GUI installers. Steps 3 onwards are run in the **R console** (e.g., RStudio or a terminal with `R` started).

1. Install `R 4.5.3`.
    - MacOS (Apple Silicon): [Download](https://cran.r-project.org/bin/macosx/big-sur-arm64/base/R-4.5.3-arm64.pkg)
    - MacOS (Intel): [Download](https://cran.r-project.org/bin/macosx/big-sur-x86_64/base/R-4.5.3-x86_64.pkg)
    - Windows: [Download](https://cran.r-project.org/bin/windows/base/old/4.5.3/R-4.5.3-win.exe)

2. Install [RStudio](https://posit.co/download/rstudio-desktop/).

3. In RStudio, open this repository as a project, and verify that `R 4.5.3` is the R version being used:
   ```r
   R.version.string
   ```

4. Install renv if not already present:
   ```r
   if (!requireNamespace("renv", quietly = TRUE)) {
       install.packages("renv")
   }
   ```

5. Restore the exact package versions from `renv.lock`:
    ```r
    renv::restore()
    ```

    When asked `Do you want to proceed? [Y/n]:`, type `Y` and press Enter.

### Local LLMs with Ollama

> All commands in this section are run in a **terminal** (Terminal on macOS/Linux; Command Prompt or PowerShell on Windows).

1. Install [Ollama](https://ollama.com/download):
    ```bash
    # macOS / Linux
    curl -fsSL https://ollama.com/install.sh | sh

    # Windows: download and run the installer from https://ollama.com/download/windows
    ```

2. Verify Ollama is installed:
    ```bash
    ollama --version
    ```

3. Pull each model (this will download several GB per model, so ensure sufficient disk space):
    ```bash
    ollama pull qwen2.5-coder:7b
    ollama pull qwen2.5:7b
    ollama pull qwen2.5:14b
    ollama pull qwen2.5-coder:14b
    ollama pull gpt-oss:20b
    ```

4. Verify the models are available:
    ```bash
    ollama list
    ```

5. To run a model, use:
    ```bash
    ollama run [model-name]
    ```

6. To stop a running model, use:
    ```bash
    ollama stop [model-name]
    ```

7. To check which models are currently running, use:
    ```bash
    ollama ps
    ```

## Package and Model Reference
### Python Packages
See file [requirements.in](./requirements.in).

### R Packages
- CRAN: `data.table` `tidyverse` `lubridate` `jsonlite` `httr` `DBI` `RSQLite` `cli` `ellmer` `irr` `rmarkdown` `renv` `devtools` `gridExtra` `rlang` `here` `sf` `terra` `tidyterra` `lwgeom` `tmap` `leaflet` `mapview` `spdep` `spatialreg` `sfdep`
- Others: [`dsl`](https://naokiegami.com/dsl/)

### Ollama Models
- `qwen2.5:7b`
- `qwen2.5:14b`
- `qwen2.5-coder:7b`
- `qwen2.5-coder:14b`
- `gpt-oss:20b`

## How to Update Python Dependencies (for Instructors)
### Step 1: Update SANE Setup
1. Modify the `requirements.in` file
To update the Python dependencies, edit the [`requirements.in`](./requirements.in) file in the project root. This file lists the top-level dependencies for the project. 

2. Generate `requirements.txt` files for each platform
To generate the `requirements.txt` files for each platform, run the following commands in the terminal from the project root:

```bash
# macOS
uv pip compile requirements.in  --python-version 3.8.18 --python-platform macos --no-annotate --no-header -o requirements_macos.txt

# Windows
uv pip compile requirements.in  --python-version 3.8.18 --python-platform windows --no-annotate --no-header -o requirements.txt
```

The `requirements.txt` file is used by SURF to set up the Python environment in SANE automatically. Make sure to update it whenever you modify the `requirements.in` file. For more information, see SURF's [official documentation](https://servicedesk.surf.nl/wiki/spaces/WIKI/pages/109576466/Adding+Python+packages+to+Tinker+SANE). 

### Step 2: Update Local Environment
1. For every new package you add to `requirements.in`, install it in your local Python environment using `uv add`:
    ```bash
    uv add [package-name]
    ```
2. After installing all the new packages, run `uv sync` to be sure that all the new dependencies are properly installed and the lock file is updated:
    ```bash
    uv sync
    ```
3. Commit and push the changes to the repository, so that others can restore the same environment.

## How to Update R Dependencies (for Instructors)
### Step 1: Update SANE Setup
1. Follow the official [SURF instructions](https://servicedesk.surf.nl/wiki/spaces/WIKI/pages/282134071/Adding+R+packages+to+Tinker+SANE).
2. Update the "R Packages" section in this README with the new packages you have added.

### Step 2: Update Local Environment
1. Install the new packages in your local R environment.
2. Add the new packages to the `packages.R` script.
3. Run `renv::snapshot()` in the R console to update the `renv.lock` file with the new package versions.
4. Commit and push the updated `renv.lock` file to the repository, so that others can restore the same environment.

## How to Add New R Packages to SANE (for Instructors)
1. Use the `./extra_r_packages_for_sane/download_extra_r_packages_for_sane.R` script to download any new package (and its dependencies) to the `extra_r_packages_for_sane/cran` or `extra_r_packages_for_sane/source` folder, depending on whether it's a binary from CRAN or a source package.
2. Update the `install_extra_r_packages_in_sane.R` script to include the installation of the new package, following the existing structure of the script.
3. Upload the downloaded package files and updated installation script via `SANE Data Provider Portal SICSS 2026 Group 1` on [Research Cloud](https://portal.live.surfresearchcloud.nl/dashboard). Make sure to place the packages in the correct folder (`cran` for binary packages from CRAN, `source` for source packages). Alternatively, simply upload the entire `extra_r_packages_for_sane` folder to overwrite the existing one `S:/scripts/extra_r_packages_for_sane` in SANE.