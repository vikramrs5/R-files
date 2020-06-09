View(SMSSpamCollection)
str(SMSSpamCollection)
smsspam_analysis=SMSSpamCollection
smsspam_analysis$V1=factor(smsspam_analysis$V1)
table(smsspam_analysis$V1)
library(NLP)
library(tm)
sms_corpus=Corpus(VectorSource(smsspam_analysis$V2))
#we used vector sourse for storing the character variable in R bin library
print(sms_corpus)
inspect(sms_corpus[1:3])
#we use inspect function to view the data stored in vector source
Corpus_clean=tm_map(sms_corpus,tolower)
#tm_map function is used for cleaning the data characater clean
inspect(Corpus_clean[1:10])
Corpus_clean=tm_map(sms_corpus,removeNumbers)
inspect(Corpus_clean[1:5])
Corpus_clean=tm_map(Corpus_clean,removeWords,stopwords())
Corpus_clean=tm_map(Corpus_clean,removePunctuation)
Corpus_clean=tm_map(Corpus_clean,stripWhitespace)
sms_dtm=DocumentTermMatrix(Corpus_clean)
#we use document term matrix to assign corpus clean as a single matrix
library(caTools)
sample_wdcloud=sample.split(Corpus_clean,SplitRatio = 0.8)
sample_wdcloud
sms_corpus_train=subset(Corpus_clean,sample_wdcloud=="TRUE")
sms_corpus_train
sms_corpus_test=subset(Corpus_clean,sample_wdcloud=="FALSE")
sms_corpus_test
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)
library(ColorPalette)
pal=brewer.pal(12,"Set3")
wordcloud(sms_corpus_train,min.freq = 40,random.order = FALSE,random.color=TRUE,colors=pal)
