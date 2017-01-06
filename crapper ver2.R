#movie crapper ver2 modified by b03901052

rm(list=ls(all.names=TRUE))
library(XML)
library(RCurl)
library(httr)
library(dplyr)
require(dplyr)
require(tidytext)
Sys.setlocale(category = "LC_ALL", locale = "cht")
joblist = list()
startpage <- 3595
endpage <- 4976
for(a in c(startpage:endpage))
{
urlPath <- paste("https://www.ptt.cc/bbs/movie/index" ,toString(a),".html",sep = "")
temp <- getURL(urlPath, encoding = "big5")
xmldoc <- htmlParse(temp)
title <- xpathSApply(xmldoc, "//div[@class=\"title\"]", xmlValue)
title <- gsub("\n", "", title)
title <- gsub("\t", "", title)
author <- xpathSApply(xmldoc, "//div[@class='author']", xmlValue)
date <- xpathSApply(xmldoc, "//div[@class='date']", xmlValue)
response<- xpathSApply(xmldoc, "//div[@class='nrec']", xmlValue)

joblist[[a-startpage+1]]<-data.frame(title=title,author=author,date=date,response=response, stringsAsFactors = FALSE)
}

movie <- bind_rows(joblist)
write.table(movie,file="movie2016.csv",sep = ",")

movielist <- read.csv("movielist2016.csv", header = F, stringsAsFactors = F)[,1]

for(i in c(1:length(movielist))) {
  No1<-grep(movielist[i],movie$title,fixed=TRUE)
  a<-movie[No1,]
  write.table(a,file=paste0("2016/n", i, ".csv"),sep = ",")
}
