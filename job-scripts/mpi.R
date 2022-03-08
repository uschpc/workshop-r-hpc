# R multinode test (bootstrapping a GLM)

library(pbdMPI)

init()

trials <- 400000

data <- iris[iris$Species != "setosa", c(1, 5)]
data$Species <- factor(data$Species)

model <- function(i, samp = data) {
  ind <- sample(nrow(samp), nrow(samp), replace = TRUE)
  results <- glm(samp[ind, 2] ~ samp[ind, 1], family = binomial(link = "logit"))
  coef(results)
}

coefs <- pbdLapply(1:trials, model, pbd.mode = "spmd")

comm.print(coefs[[1]])

finalize()
