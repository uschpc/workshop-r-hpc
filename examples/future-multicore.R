# R future multicore test (bootstrapping a GLM)

library(parallelly)
library(future)
library(future.apply)

trials <- 100000
cores <- as.numeric(Sys.getenv("SLURM_CPUS_PER_TASK"))

data <- iris[iris$Species != "setosa", c(1, 5)]
data$Species <- factor(data$Species)

model <- function(i, samp = data) {
  ind <- sample(nrow(samp), nrow(samp), replace = TRUE)
  results <- glm(samp[ind, 2] ~ samp[ind, 1], family = binomial(link = "logit"))
  coef(results)
}

plan(multicore, workers = cores)

coefs <- future_lapply(1:trials, model, future.seed = TRUE)
