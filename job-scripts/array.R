# R script to process data (job array)

library(data.table)

files <- list.files("./data", full.names = TRUE)
task <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID"))
file <- files[task]
file

data <- fread(file)

summary(data)
