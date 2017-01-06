#movie版爬蟲 #2366~3595
library("XML")
library("RCurl")
library("httr")
library("dplyr")

rm(list=ls(all.names=TRUE))
library(XML)
library(RCurl)
library(httr)
library(dplyr)
require(dplyr)
require(tidytext)
Sys.setlocale(category = "LC_ALL", locale = "cht")
joblist = list()
for(a in c(2366:3675))
{
urlPath <- paste("https://www.ptt.cc/bbs/movie/index" ,toString(a),".html",sep = "")
temp <- getURL(urlPath, encoding = "big5")
xmldoc <- htmlParse(temp)
title <- xpathSApply(xmldoc, "//div[@class=\"title\"]", xmlValue)
title <- gsub("\n", "", title)
title <- gsub("\t", "", title)
author <- xpathSApply(xmldoc, "//div[@class='author']", xmlValue)
##path <- xpathSApply(xmldoc, "//div[@class='title']/a//@href")
date <- xpathSApply(xmldoc, "//div[@class='date']", xmlValue)
response<- xpathSApply(xmldoc, "//div[@class='nrec']", xmlValue)
alldata <- data.frame(title, author, date, response)
write.table(alldata, file = "movie.csv")
##suburlPath <- "https://www.ptt.cc"
##for( i in 1:length(alldata[,1]) )
##{
  ##ipath <- paste(suburlPath, alldata$path[i], sep='')
  ##content <- getURL(ipath, encoding = "big5")
  ##xmldoc <- htmlParse(content)
  ##article <- xpathSApply(xmldoc, "//div[@id=\"main-content\"]", xmlValue)
  ##filename<- paste("./data/", i, ".csv", sep='')
  ##write.csv(article, filename)
##}

joblist[[a]]<-data.frame(title=title,author=author,date=date,response=response, stringsAsFactors = FALSE)
}

movie <- bind_rows(joblist)

write.table(movie,file="movie.csv",sep = ",")

No1<-grep("侏儸紀世界",movie$title,fixed=TRUE)
(a<-movie[No1,])
write.table(a,file="n01.csv",sep = ",")

No2<-grep("玩命關頭",movie$title,fixed=TRUE)
(b<-movie[No2,])
write.table(b,file="n02.csv",sep = ",")

No3<-grep("復仇者聯盟",movie$title,fixed=TRUE)
(c<-movie[No3,])
write.table(c,file="n03.csv",sep = ",")

No4<-grep("我的少女時代",movie$title,fixed=TRUE)
(d<-movie[No4,])
write.table(d,file="n04.csv",sep = ",")

No5<-grep("不可能的任務",movie$title,fixed=TRUE)
(e<-movie[No5,])
write.table(e,file="n05.csv",sep = ",")

No6<-grep("金牌特務",movie$title,fixed=TRUE)
(f<-movie[No6,])
write.table(f,file="n06.csv",sep = ",")

No7<-grep("蟻人",movie$title,fixed=TRUE)
(g<-movie[No7,])
write.table(g,file="n07.csv",sep = ",")

No8<-grep("小小兵",movie$title,fixed=TRUE)
(h<-movie[No8,])
write.table(h,file="n08.csv",sep = ",")

No9<-grep("高年級實習生",movie$title,fixed=TRUE)
(i<-movie[No9,])
write.table(i,file="n09.csv",sep = ",")

No10<-grep("星際大戰",movie$title,fixed=TRUE)
(j<-movie[No10,])
write.table(j,file="n010.csv",sep = ",")

No11<-grep("加州大地震",movie$title,fixed=TRUE)
(k<-movie[No11,])
write.table(k,file="n011.csv",sep = ",")

No12<-grep("移動迷宮",movie$title,fixed=TRUE)
(l<-movie[No12,])
write.table(l,file="n012.csv",sep = ",")

No13<-grep("007",movie$title,fixed=TRUE)
(m<-movie[No13,])
write.table(m,file="n013.csv",sep = ",")

No14<-grep("絕地救援",movie$title,fixed=TRUE)
(n<-movie[No14,])
write.table(n,file="n014.csv",sep = ",")

No15<-grep("腦筋急轉彎",movie$title,fixed=TRUE)
(o<-movie[No15,])
write.table(o,file="n015.csv",sep = ",")

No16<-grep("飢餓遊戲",movie$title,fixed=TRUE)
(p<-movie[No16,])
write.table(p,file="n016.csv",sep = ",")

No17<-grep("即刻救援",movie$title,fixed=TRUE)
(q<-movie[No17,])
write.table(q,file="n017.csv",sep = ",")

No18<-grep("葉問",movie$title,fixed=TRUE)
(r<-movie[No18,])
write.table(r,file="n018.csv",sep = ",")

No19<-grep("麻辣賤諜",movie$title,fixed=TRUE)
(s<-movie[No19,])
write.table(s,file="n019.csv",sep = ",")

No20<-grep("美國狙擊手",movie$title,fixed=TRUE)
(t<-movie[No20,])
write.table(t,file="n020.csv",sep = ",")

No21<-grep("大囍臨門",movie$title,fixed=TRUE)
(u<-movie[No21,])
write.table(u,file="n021.csv",sep = ",")

No22<-grep("魔鬼終結者",movie$title,fixed=TRUE)
(v<-movie[No22,])
write.table(v,file="n022.csv",sep = ",")

No23<-grep("格雷",movie$title,fixed=TRUE)
(w<-movie[No23,])
write.table(w,file="n023.csv",sep = ",")

No24<-grep("歌喉讚",movie$title,fixed=TRUE)
(x<-movie[No24,])
write.table(x,file="n024.csv",sep = ",")

No25<-grep("熊麻吉",movie$title,fixed=TRUE)
(y<-movie[No25,])
write.table(y,file="n025.csv",sep = ",")

No26<-grep("模仿遊戲",movie$title,fixed=TRUE)
(z<-movie[No26,])
write.table(z,file="n026.csv",sep = ",")

No27<-grep("分歧者",movie$title,fixed=TRUE)
(aa<-movie[No27,])
write.table(aa,file="n027.csv",sep = ",")

No28<-grep("瘋狂麥斯",movie$title,fixed=TRUE)
(bb<-movie[No28,])
write.table(bb,file="n028.csv",sep = ",")

No29<-grep("聖母峰",movie$title,fixed=TRUE)
(cc<-movie[No29,])
write.table(cc,file="n029.csv",sep = ",")

No30<-grep("紳士密令",movie$title,fixed=TRUE)
(dd<-movie[No30,])
write.table(dd,file="n030.csv",sep = ",")

No31<-grep("追婚日記",movie$title,fixed=TRUE)
(ee<-movie[No31,])
write.table(ee,file="n031.csv",sep = ",")

No32<-grep("破風",movie$title,fixed=TRUE)
(ff<-movie[No32,])
write.table(ff,file="n032.csv",sep = ",")

No33<-grep("明日世界",movie$title,fixed=TRUE)
(gg<-movie[No33,])
write.table(gg,file="n033.csv",sep = ",")

No34<-grep("小王子",movie$title,fixed=TRUE)
(hh<-movie[No34,])
write.table(hh,file="n034.csv",sep = ",")

No35<-grep("紅衣小女孩",movie$title,fixed=TRUE)
(ii<-movie[No35,])
write.table(ii,file="n035.csv",sep = ",")

No36<-grep("獵巫行動",movie$title,fixed=TRUE)
(jj<-movie[No36,])
write.table(jj,file="n036.csv",sep = ",")

No37<-grep("成人世界",movie$title,fixed=TRUE)
(kk<-movie[No37,])
write.table(kk,file="n037.csv",sep = ",")

No38<-grep("朱比特",movie$title,fixed=TRUE)
(ll<-movie[No38,])
write.table(ll,file="n038.csv",sep = ",")

No39<-grep("刺客聶隱娘",movie$title,fixed=TRUE)
(mm<-movie[No39,])
write.table(mm,file="n039.csv",sep = ",")

No40<-grep("角頭",movie$title,fixed=TRUE)
(nn<-movie[No40,])
write.table(nn,file="n040.csv",sep = ",")

No41<-grep("玩命快遞",movie$title,fixed=TRUE)
(oo<-movie[No41,])
write.table(oo,file="n041.csv",sep = ",")

No42<-grep("間諜橋",movie$title,fixed=TRUE)
(pp<-movie[No42,])
write.table(pp,file="n042.csv",sep = ",")

No43<-grep("仙履奇緣",movie$title,fixed=TRUE)
(qq<-movie[No43,])
write.table(qq,file="n043.csv",sep = ",")

No44<-grep("天菜大廚",movie$title,fixed=TRUE)
(rr<-movie[No44,])
write.table(rr,file="n044.csv",sep = ",")

No45<-grep("翻轉幸福",movie$title,fixed=TRUE)
(ss<-movie[No45,])
write.table(ss,file="n045.csv",sep = ",")

No46<-grep("馬達加斯加",movie$title,fixed=TRUE)
(tt<-movie[No46,])
write.table(tt,file="n046.csv",sep = ",")

No47<-grep("白鯨傳奇",movie$title,fixed=TRUE)
(uu<-movie[No47,])
write.table(uu,file="n047.csv",sep = ",")

No48<-grep("魔法黑森林",movie$title,fixed=TRUE)
(vv<-movie[No48,])
write.table(vv,file="n048.csv",sep = ",")

No49<-grep("尖叫旅社",movie$title,fixed=TRUE)
(ww<-movie[No49,])
write.table(ww,file="n049.csv",sep = ",")

No50<-grep("一夜狂奔",movie$title,fixed=TRUE)
(xx<-movie[No50,])
write.table(xx,file="n050.csv",sep = ",")
