# R mclapply() test (bootstrapping a GLM)

library(parallel)

data <- iris[iris$Species != "setosa", c(1, 5)]
data$Species <- factor(data$Species)

model <- function(i, samp = data) {
  ind <- sample(nrow(samp), nrow(samp), replace = TRUE)
  results <- glm(samp[ind, 2] ~ samp[ind, 1], family = binomial(link = "logit"))
  coef(results)
}

trials <- 100000
cores <- as.numeric(Sys.getenv("SLURM_CPUS_PER_TASK"))

coefs <- mclapply(1:trials, model, mc.cores = cores)
