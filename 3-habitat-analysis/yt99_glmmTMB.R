# https://easystats.github.io/easystats/articles/workflow_performance.html

library(performance)
library(parameters)
library(glmmTMB)

################################################################################
# Fit initial model

model1 <- glmmTMB(
  count ~ mined + spp + (1 | site),
  family = poisson,
  data = Salamanders
)

# Summarize model
model_parameters(model1)

# Check model fit
check_model(model1)

check_overdispersion(model1)

check_zeroinflation(model1)

report(model1)
