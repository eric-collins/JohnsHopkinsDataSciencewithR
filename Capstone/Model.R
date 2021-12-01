library(tidyverse)
library(tidytext)
library(markovchain)

source("./helpers.R")


#gram_creation()


unigrams <- read_csv("./unigram.csv") %>%
        slice_max(n, n = 10000)
bigrams <- read_csv("./bigram.csv") %>%
        slice_max(n, n = 10000)
trigrams <- read_csv("./trigram.csv") %>%
        slice_max(n, n = 10000)

models <- train_models()

saveRDS("./models.RDS")




