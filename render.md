# Dashboard

quarto render dashboard/index.qmd

# Shiny app

shinylive::export('app', 'docs/app')
httpuv::runStaticServer('docs/app')

## Main docs (fast - 15 seconds)
quarto render workbook/index.qmd
quarto render workbook/workflow.qmd
quarto render workbook/references.qmd
quarto render workbook/appendices.qmd

# Data preparation
quarto render workbook/1-data-preparation/index.qmd
quarto render workbook/1-data-preparation/1.1-prepare-caribou.qmd
quarto render workbook/1-data-preparation/1.2-prepare-covariates.qmd
quarto render workbook/1-data-preparation/1.3-extract-values.qmd

# Movement analysis
quarto render 2-movement-analysis/index.qmd
quarto render 2-movement-analysis/2.1-movement-rates.qmd
quarto render 2-movement-analysis/2.2-generate-mcp.qmd
quarto render 2-movement-analysis/2.3-estimate-hr-amt.qmd

# Habitat analysis
quarto render 3-habitat-analysis/index.qmd
quarto render 3-habitat-analysis/3.0-covariates-eda.qmd
quarto render 3-habitat-analysis/3.1-glm-models.qmd
quarto render 3-habitat-analysis/3.2-glmm-models.qmd
quarto render 3-habitat-analysis/3.3-random-forest-models.qmd

# Connectivity analysis
quarto render 4-connectivity-analysis/index.qmd
quarto render 4-connectivity-analysis/4.1-resistance-surface.qmd
quarto render 4-connectivity-analysis/4.2-omniscape.qmd
