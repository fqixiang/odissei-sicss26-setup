This repository documents the standard software setup for Tinker SANE machines used at ODISSEI-SICSS 2026, including the Python and R environments and the LLM models served via Ollama.

# Setup Instructions
Follow the steps below to reproduce the Python and R environments and pull the required LLM models via [Ollama](https://ollama.com/).

## Python 3.8.18 with uv

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

## R 4.5.3 with renv

> Steps 1–2 are GUI installers. Steps 3 onwards are run in the **R console** (e.g., RStudio or a terminal with `R` started).

1. Install `R 4.5.3`.
    - MacOS (Apple Silicon): [Download](https://cran.r-project.org/bin/macosx/big-sur-arm64/base/R-4.5.3-arm64.pkg)
    - MacOS (Intel): [Download](https://cran.r-project.org/bin/macosx/big-sur-x86_64/base/R-4.5.3-x86_64.pkg)
    - Windows: [Download](https://cran.r-project.org/bin/windows/base/old/4.5.3/R-4.5.3-win.exe)

2. Install [RStudio](https://posit.co/download/rstudio-desktop/) (optional but recommended).

3. Open an R session in the project root and verify that `R 4.5.3` is the R version being used:
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

    If no `renv.lock` exists yet (first-time machine setup), install the packages listed below and then snapshot:
    ```r
    # Install CRAN packages
    required_cran_packages <- c(
        "data.table",
        "dplyr",
        "ggplot2",
        "readr",
        "tidyr",
        "stringr",
        "lubridate",
        "tibble",
        "purrr",
        "jsonlite",
        "httr",
        "DBI",
        "RSQLite",
        "cli",
        "ellmer",
        "irr",
        "tidyverse",
        "rmarkdown",
        "devtools",
        "gridExtra",
        "rlang",
        "here"
    )

    installed_packages <- rownames(installed.packages())
    missing_packages <- setdiff(required_cran_packages, installed_packages)

    if (length(missing_packages) > 0) {
        install.packages(missing_packages, dependencies = TRUE)
    } else {
        message("All required packages are already installed.")
    }

    # Install dsl package from GitHub
    if (!requireNamespace("dsl", quietly = TRUE)) {
        devtools::install_github("naokiegami/dsl")
    }

    # Snapshot package versions into renv.lock
    renv::snapshot()
    ```

## LLM models with Ollama

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

# How to Update Python dependencies
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

# Package and Model Reference
## Python packages
See file [requirements.in](./requirements.in).

## R packages
- CRAN: `data.table`, `dplyr`, `ggplot2`, `readr`, `tidyr`, `stringr`, `lubridate`, `tibble`, `purrr`, `jsonlite`, `httr`, `DBI`, `RSQLite`, `cli`, `ellmer`, `irr`, `tidyverse`, `rmarkdown`, `renv`, `devtools`, `gridExtra`, `rlang`, `here`, `grf`, `estimatr`, `SuperLearner`, `arm`, `matrixcalc`
- Others: [`dsl`](https://naokiegami.com/dsl/), which depends on `grf`, `estimatr`, `SuperLearner`, `arm`, and `matrixcalc`

## Ollama models
- `qwen2.5:7b`
- `qwen2.5:14b`
- `qwen2.5-coder:7b`
- `qwen2.5-coder:14b`
- `gpt-oss:20b`