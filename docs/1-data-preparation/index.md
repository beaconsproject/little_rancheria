# Data Preparation


## Predictor variables

Describe predictor variable: - Distribution and abundance (maps, plots,
range of values) - Scale of effect - Hypotheses related to caribou

Table 2. Covariates.

| **Category** | **Variable** | **Type** | **Resolution (m)** | **Context (m)** | **Code** | **Note** |
|----|----|----|----|----|----|----|
| Topography | Elevation | Continuous | 30 | na | 1 |  |
|  | Slope or roughness | Continuous | 30 | na | 1 |  |
|  | Aspect | Continuous | 30 | na | 1 |  |
|  | Eastness | Continuous | 30 | na | 1 |  |
|  | Northness | Continuous | 30 | na | 1 |  |
| Landcover | Forest | Categorical | 30 | na | 1 |  |
|  | Conifer | Categorical | 30 | na | 1 |  |
|  | Deciduous | Categorical | 30 | na | 1 |  |
|  | Mixedwood | Categorical | 30 | na | 1 |  |
|  | Wetland | Categorical | 30 | na | 1 |  |
|  | Shrubland | Categorical | 30 | na | 1 |  |
|  | Grassland | Categorical | 30 | na | 1 |  |
|  | Barren | Categorical | 30 | na | 1 |  |
|  | Snowice | Categorical | 30 | na | 1 |  |
| Landscape context | Proportion of conifer forest | Continuous | 30 | 1000 | 0 | Scale of effect? |
|  | Proportion of mixedwood & deciduous | Continuous | 30 | 1000 | 0 | Scale of effect? |
|  | Proportion shrubland | Continuous | 30 | 1000 | 0 | Scale of effect? |
|  | Proportion grassland | Continuous | 30 | 1000 | 0 | Scale of effect? |
|  | Proportion barren | Continuous | 30 | 1000 | 0 | Scale of effect? |
| Disturbance (natural) | Proportion recent burned area (0-40 yrs) | Continuous | 30 | 1000 | 0 | Scale of effect? |
| Disturbance (human) | Linear feature density | Continuous | 30 | 1000 | 0 | Not sure |
|  | Distance to linear disturbance | Continuous | 30 | na | 1 |  |
|  | Distance to areal disturbance | Continuous | 30 | na | 1 |  |
|  | Distance to linear & areal disturbance | Continuous | 30 | na | 1 |  |
| Bioclimate | BIO1 = Annual Mean Temperature | Continuous | 1000 | na | 1 | Projections only |
|  | BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp)) | Continuous | 1000 | na | 1 | Projections only |
|  | BIO3 = Isothermality (BIO2/BIO7) (?100) | Continuous | 1000 | na | 1 | Projections only |
|  | BIO4 = Temperature Seasonality (standard deviation ?100) | Continuous | 1000 | na | 1 | Projections only |
|  | BIO5 = Max Temperature of Warmest Month | Continuous | 1000 | na | 1 | Projections only |
|  | BIO6 = Min Temperature of Coldest Month | Continuous | 1000 | na | 1 | Projections only |
|  | BIO7 = Temperature Annual Range (BIO5-BIO6) | Continuous | 1000 | na | 1 | Projections only |
|  | BIO8 = Mean Temperature of Wettest Quarter | Continuous | 1000 | na | 1 | Projections only |
|  | BIO9 = Mean Temperature of Driest Quarter | Continuous | 1000 | na | 1 | Projections only |
|  | BIO10 = Mean Temperature of Warmest Quarter | Continuous | 1000 | na | 1 | Projections only |
|  | BIO11 = Mean Temperature of Coldest Quarter | Continuous | 1000 | na | 1 | Projections only |
|  | BIO12 = Annual Precipitation | Continuous | 1000 | na | 1 | Projections only |
|  | BIO13 = Precipitation of Wettest Month | Continuous | 1000 | na | 1 | Projections only |
|  | BIO14 = Precipitation of Driest Month | Continuous | 1000 | na | 1 | Projections only |
|  | BIO15 = Precipitation Seasonality (Coefficient of Variation) | Continuous | 1000 | na | 1 | Projections only |
|  | BIO16 = Precipitation of Wettest Quarter | Continuous | 1000 | na | 1 | Projections only |
|  | BIO17 = Precipitation of Driest Quarter | Continuous | 1000 | na | 1 | Projections only |
|  | BIO18 = Precipitation of Warmest Quarter | Continuous | 1000 | na | 1 | Projections only |
|  | BIO19 = Precipitation of Coldest Quarter | Continuous | 1000 | na | 1 | Projections only |
