# R future cluster test (bootstrapping a GLM)

library(parallelly)
library(future)
library(future.apply)

data <- iris[iris$Species != "setosa", c(1, 5)]
data$Species <- factor(data$Species)

model <- function(i, samp = data) {
  ind <- sample(nrow(samp), nrow(samp), replace = TRUE)
  results <- glm(samp[ind, 2] ~ samp[ind, 1], family = binomial(link = "logit"))
  coef(results)
}

trials <- 100000
cores <- availableWorkers()

cl <- makeClusterPSOCK(cores,
                       revtunnel = FALSE,
                       rscript = c("/apps/generic/apptainer/1.4.5/bin/apptainer",
                                   "exec",
                                   Sys.getenv("R_CONTAINER"),
                                   "Rscript"))

plan(cluster, workers = cl)

coefs <- future_lapply(1:trials, model, future.seed = TRUE)
