load_models <- function(){
        
        readRDS("./models.RDS")
}

make_prediction <- function(phrase, number_of_words = 1){
        
        library(dplyr)
        library(tidytext)
        library(markovchain)
        
        
        phrase <- tolower(phrase)
        
        grams <- tibble(text = phrase) %>%
                unnest_tokens(word, text)
        
        bigram <- tibble(text = phrase) %>%
                unnest_tokens(bigram, text, token = 'ngrams', n = 2)
        
        trigram <- tibble(text = phrase) %>%
                unnest_tokens(trigram, text, token = 'ngrams', n = 3)
        
        
        num_words <- nrow(grams)
        
        num_bis <- nrow(bigram)
        
        num_tris <- nrow(trigram)
        
        
        one_check <- function(){
                suggestions <- models$Unigram$estimate[ grams$word[num_words], ] %>%
                        sort(decreasing = T) %>%
                        head(number_of_words) %>%
                        names()
                
        }
        
        two_check <- function(){
                suggestions <- models$Bigram$estimate[ bigram$bigram[num_bis], ] %>%
                        sort(decreasing = T) %>%
                        head(number_of_words) %>%
                        names()
                
                suggestions <- tibble(text = suggestions) %>%
                        unnest_tokens(word, text)
                
                return(suggestions$word[1])
        }
        
        three_check <- function(){
                suggestions <- models$Trigram$estimate[ trigram$trigram[num_tris], ] %>%
                        sort(decreasing = T) %>%
                        head(number_of_words) %>%
                        names()
                
                suggestions <- tibble(text = suggestions) %>%
                        unnest_tokens(word, text)
                
                return(suggestions$word[1])
        }
        
        
        length = nrow(grams)
        
        if(length == 3){
                
                suggestion <- try(three_check(), silent = FALSE)
                if(class(suggestion) != "try-error"){
                        return(suggestion)
                }
                
        } 
        
        else if(length == 2){
                
                suggestion <- try(two_check(), silent = FALSE)
                if(class(suggestion) != "try-error"){
                        return(suggestion)
                }
                
        } 
        
        else if(length == 1){
                suggestion <- try(one_check(), silent = FALSE)
                if(class(suggestion) != "try-error"){
                        return(suggestion)
                }
                
                
        }
        
        try(one_check(), silent = FALSE)
        
        
}


gram_creation <- function(){
        library(tm)
        library(tidyverse)
        library(tidytext)
        library(stringi)
        library(ggwordcloud)
        library(ggthemes)
        library(qdapDictionaries)
        
        print("Started")
        
        replacePunctuation <- function(x){ gsub("[^[:alnum:][:space:]'`]", " ", x)}
        
        blogs <- './Coursera-SwiftKey/final/en_US/en_US.blogs.txt'
        
        blog_con <- file(blogs, encoding = 'latin1')
        
        blog_lines <- tibble(readLines(con = blog_con, encoding = 'latin1'))
        
        blog_lines <- blog_lines %>%
                rename(text = `readLines(con = blog_con, encoding = "latin1")`)
        
        
        
        news <- './Coursera-SwiftKey/final/en_US/en_US.news.txt'
        
        news_con <- file(news, encoding = 'latin1')
        
        news_lines <- tibble(readLines(con = news_con, encoding = "latin1"))
        
        news_lines <- news_lines %>%
                rename(text = `readLines(con = news_con, encoding = "latin1")`)
        
        
        
        twitter <- './Coursera-SwiftKey/final/en_US/en_US.twitter.txt'
        
        twitter_con <- file(twitter, encoding = 'latin1')
        
        twitter_lines <- tibble(readLines(con = twitter_con, encoding = "latin1"))
        
        twitter_lines <- twitter_lines %>%
                rename(text = `readLines(con = twitter_con, encoding = "latin1")`)
        
        
        set.seed(1337)
        
        blog_lines <- blog_lines %>%
                slice_sample(prop = .10)
        
        twitter_lines <- twitter_lines %>%
                slice_sample(prop = .05)
        
        corpus <- bind_rows(blog_lines, twitter_lines, news_lines)
        
        
        rm(blog_lines, news_lines, twitter_lines)
        
        
        badwords <- readLines("./badwords.txt")
        
        print("Lines read")
        
        unigram <- corpus %>%
                ungroup() %>%
                unnest_tokens(word, text) %>%
                mutate(word = stri_trans_general(word, 'latin-ascii'),
                       word = removeNumbers(word),
                       word = replacePunctuation(word)) %>%
                filter(!(word %in% badwords),
                       (word != "" ),
                       !(word %in% c('s', 't', 'ia', 'u', 'd'))) %>%
                count(word) %>%
                slice_max(n, n = 5000)
                
        
        print("Unigrams Created")
        
        
        bigram <- corpus %>%
                unnest_tokens(bigram, text, token = 'ngrams', n = 2) %>%
                separate(bigram, c('word1', 'word2'), sep = " ") %>%
                mutate(word1 = stri_trans_general(word1, 'latin-ascii'),
                       word2 = stri_trans_general(word2, 'latin-ascii'),
                       word1 = removeNumbers(word1),
                       word2 = removeNumbers(word2),
                       word1 = replacePunctuation(word1),
                       word2 = replacePunctuation(word2)) %>%
                filter(!(word1 %in% badwords),
                       !(word2 %in% badwords),
                       (word1 != ""),
                       (word2 != ""),
                       !(word1 %in% c('s','t', 'ia', 'u', 'd', 'youa')),
                       !(word2 %in% c('s' ,'t', 'ia', 'u', 'd'))) %>%
                unite(bigram, word1, word2, sep = " ", remove = FALSE) %>%
                count(bigram) %>%
                slice_max(n, n = 2500)
        
        print("Bigrams Created")
        
        
        trigram <- corpus %>%
                unnest_tokens(trigram, text, token = 'ngrams', n = 3) %>%
                separate(trigram, c('word1', 'word2', 'word3'), sep = " ") %>%
                mutate(word1 = stri_trans_general(word1, 'latin-ascii'),
                       word2 = stri_trans_general(word2, 'latin-ascii'),
                       word3 = stri_trans_general(word3, 'latin-ascii'),
                       word1 = removeNumbers(word1),
                       word2 = removeNumbers(word2),
                       word3 = removeNumbers(word3),
                       word1 = replacePunctuation(word1),
                       word2 = replacePunctuation(word2),
                       word3 = replacePunctuation(word3)) %>%
                filter(!(word1 %in% badwords),
                       !(word2 %in% badwords),
                       !(word3 %in% badwords),
                       (word1 != ""),
                       (word2 != ""),
                       (word3 != ""),
                       !(word1 %in% c('s','t', 'ia', 'u', 'd')),
                       !(word2 %in% c('s' ,'t', 'ia', 'u', 'd')),
                       !(word3 %in% c('s' ,'t', 'ia', 'u', 'd'))) %>%
                unite(trigram, word1 , word2, word3, sep = " ", remove = FALSE) %>%
                count(trigram) %>%
                slice_max(n, n = 1000)
        
        print("Trigrams Created")
        
        write_csv(unigram, "unigram.csv")
        write_csv(bigram, "bigram.csv")
        write_csv(trigram, "trigram.csv")
}

train_models <- function() {
        library(tidyverse)
        library(markovchain)
        library(doParallel)
        registerDoParallel()
        
        unigrams <- read_csv("./unigram.csv")
        bigram <- read_csv("./bigram.csv")
        trigram <- read_csv("./trigram.csv")
        
        
        fit1 <- markovchainFit(unigrams$word, method = "laplace", laplacian = 1)
        
        print("Unigram Model Trained")
        
        fit2 <- markovchainFit(bigram$bigram, method = "laplace", laplacian = 1)
        
        print("Bigram Model Trained")
        
        fit3 <- markovchainFit(trigram$trigram, method = "laplace", laplacian = 1)
        
        print("Trigram Model Trained")
        
        models <- tibble("Unigram" = fit1, "Bigram" = fit2, "Trigram" = fit3)
        
        models


}
















