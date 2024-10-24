# Workflow


## Introduction

## Methods

### 1. Data preparation

The objective to create an analysis-ready database consisting of caribou
location data and covariate rasters. The steps include:

- Telemetry data:
  - Acquire, clean, and save caribou location data
  - Examine track outliers, telemetry errors, and autocorrelation
    timescales of GPS tracks
  - Define seasons i.e., early winter, late winter, fall rut, spring,
    summer
- Covariate data:
  - Acquire and prepare a set of covariate rasters that have the same
    resolution, extent, project, and are aligned
  - Acquire and prepare normal and projected bioclimate data

### 2. Movement analysis

Home range estimation

The objective to estimate the autocorrelated home ranges for caribou at
the individual and population levels. The steps include:

- ctmm can help us account for telemetry error, autocorrelation and
  irregular sampling frequencies in animal tracking data
- Convert caribou location data to telemetry objects (include:
  individual.local.identifier (or tag.local.identifier), timestamp,
  location.long and location.lat)
- Select appropriate model(s) for the autocorrelation structure of the
  data
  - Examine the autocorrelation structure of the telemetry data using
    variogram analysis
  - Fit and select model based on the initial parameter value guess
    identified above
- Use model(s) to estimate home range using the autocorrelated kernel
  density estimator (AKDE)
- Save various models as geopackage

### 3. Habitat analysis

The steps include:

- Develop habitat models: population and individual-levels
- Use models to identify
  - What landscape features do animals seek or avoid during their
    movements?
  - In which areas of the landscape are animals at risk of predation or
    disease transmission?
- Interpret models (https://easystats.github.io/report/)
- Terra random forest models:
  https://rspatial.org/analysis/5-global_regression.html
- Terra gradient boosting models: https://rspatial.org/sdm/index.html

### 4. Connectivity analysis

The steps include:

- Develop a permeability/resistance surface using the previously fitted
  habitat model.
- Develop a probability of connectivity map using omniscape
- Identify key (seasonal) movement corridors

## Visualizing results

The objective is to develop a (shiny) dashboard to view the results of
the various analyses and allow users to explorer the sensitivity of some
of the parameters. Functionality includes:

- View estimated seasonal home ranges (present)
- View seasonal probability of occurrence maps (present, future)
- View potential seasonal movement corridors (present, future)

## Resources

Habitat analysis

- Example using `glm`:
  <https://jcoliver.github.io/learn-r/011-species-distribution-models.html>
- Example using `randomForest`:
  <https://rspatial.org/analysis/5-global_regression.html>
- Example using `gbm`: <https://rspatial.org/sdm/index.html>
- Example using `gbm`:
  [https://bookdown.org/mcwimberly/gdswr-book/application—species-distribution-modeling.html](https://bookdown.org/mcwimberly/gdswr-book/application---species-distribution-modeling.html)
