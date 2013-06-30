require(tm)
require(wordcloud)

# Build corpus and pre-process data
c = Corpus(DirSource("/home/qian/Work/IPO_S1"), readerControl=list(language="en")) # put the prospectuses in the directory; build a corpus by reading the files
c = tm_map(c, removeNumbers) # remove numbers
c = tm_map(c, removePunctuation) # remove punctuations
c = tm_map(c, removeWords, stopwords("en")) # remove stop words
c = tm_map(c, tolower) # to lower case
f = c[1] # facebook
g = c[2] # google
l = c[3] # linkedin

# plot the facebook word cloud
tdm = TermDocumentMatrix(f)
m = as.matrix(tdm)
freq = rowSums(m)
words = rownames(m)
wordcloud(words,freq,min.freq=100,col='blue')

# plot the facebook-google comparison word cloud
tdm = TermDocumentMatrix(c(f,g))
m = as.matrix(tdm)
comparison.cloud(m,max.words=100) 