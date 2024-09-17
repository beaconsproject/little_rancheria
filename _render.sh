quarto render index.qmd
quarto render workflow.qmd
quarto render references.qmd
quarto render appendices.qmd

# Data preparation
quarto render 1-data-preparation/1.1-prepare-caribou.qmd
quarto render 1-data-preparation/1.1-prepare-caribou-bc.qmd
quarto render 1-data-preparation/1.2-prepare-covariates.qmd
quarto render 1-data-preparation/1.3-extract-values.qmd

# Movement analysis

# Habitat analysis
quarto render 3-habitat-analysis/overview.qmd
quarto render 3-habitat-analysis/3.1-glm-models.qmd
quarto render 3-habitat-analysis/3.1-glmm-models.qmd
quarto render 3-habitat-analysis/3.3-random-forest-models.qmd

# Dashboard
quarto render 6-dashboard/index.qmd
