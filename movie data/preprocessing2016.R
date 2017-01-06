# movie data preprocessing by b03901052
library(dplyr)

# convert tag in title to {pos, neg, poor, other}
get_tag <- function(x) {
  if(grepl("\\[.*好.*\\]", x)) return("pos");
  if(grepl("\\[.*負.*\\]", x)) return("neg");
  if(grepl("\\[.*普.*\\]", x)) return("poor");
  return("other");
}

# convert number of reply to integer number
get_nreply <- function(x) {
  if(is.na(x)) return(0);
  if(x == "爆") return(100);
  if(substr(x, 1, 1) == "X") {
    if(substr(x, 2, 2) == "X") {
      return(-100);
    }
    else {
      return(-10 * as.integer(substr(x, 2, 2)));
    }
  }
  return(as.integer(toString(x)));
}

# convert date to day
get_day <- function(x, y) {
  x <- paste0("2016/", x);
  y <- paste0("2016/", y);
  diff <- as.integer(as.Date(x))-as.integer(as.Date(y));
  if(diff < -330) {
    diff <- diff + 365;
  }
  return(diff);
}
get_day2 <- function(x, y) {
  x <- paste0("2016/", x);
  diff <- as.integer(as.Date(x))-as.integer(as.Date(y,"%Y.%m.%d"));
  if(diff < -330) {
    diff <- diff + 365;
  }
  return(diff);
}

# convert to format of further processing and ML
movies <- read.csv("boxoffice2016.csv", header = F, stringsAsFactors = F); #read movie data
colnames(movies) <- c("title", "boxoffice", "date", "domestic");
for(i in c(1:26)) {
  infilename <- paste0("2016/n", i, ".csv");
  df <- read.csv(infilename, header = F, skip = 1, na.strings = "");
  df <- df[,c(2,4,5)];
  colnames(df) <- c("tag", "day", "rate");
  df$tag <- sapply(df$tag, get_tag);
  df$day <- sapply(df$day, get_day2, movies$date[i]);
  df$rate <- sapply(df$rate, get_nreply);
  write.csv(df, paste0("2016/processed/n", i, ".csv"), row.names = F, na = "");
}

ntitle0 <- list();
ntitle1 <- list();
ntitle2 <- list();
popularity0 <- list();
popularity1 <- list();
popularity2 <- list();
rating <- list();
weightedrating <- list();
for(i in c(1:26)) {
  infilename <- paste0("2016/processed/n", i, ".csv");
  df <- read.csv(infilename, header = T, na.strings = "");
  ntitle0[[i]] <- nrow(filter(df, day >= -7 & day < 0)); # 1 week before
  ntitle1[[i]] <- nrow(filter(df, day >= 0 & day < 7)); # first week
  ntitle2[[i]] <- nrow(filter(df, day >= 7 & day < 14)); # second week
  popularity0[[i]] <- sum(unlist(sapply(filter(df, day >= -7 & day < 0)$rate, abs)));
  popularity1[[i]] <- sum(unlist(sapply(filter(df, day >= 0 & day < 7)$rate, abs)));
  popularity2[[i]] <- sum(unlist(sapply(filter(df, day >= 7 & day < 14)$rate, abs)));
  rating[[i]] <- nrow(filter(df, tag == "pos")) / nrow(filter(df, tag != "other"));
  weightedrating[[i]] <- (sum(filter(df, tag == "pos")$rate)-sum(filter(df, tag == "neg")$rate))/sum(sapply(filter(df, tag != "other")$rate, abs))
}
movies$ntitle0 <- unlist(ntitle0);
movies$ntitle1 <- unlist(ntitle1);
movies$ntitle2 <- unlist(ntitle2);
movies$popularity0 <- unlist(popularity0);
movies$popularity1 <- unlist(popularity1);
movies$popularity2 <- unlist(popularity2);
movies$rating <- unlist(rating);
movies$weightedrating <- unlist(weightedrating);
write.csv(movies, "2016/processed movie data2016.csv", row.names = F, na = "");
