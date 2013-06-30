#!/usr/bin/Rscript

setwd('/Users/e51141/macsrc/datasci/R/')

#install.package(TraMineR)
require(TraMineR)
data(mvad) 
dim(mvad)
names(mvad)

########################
## simple ex from TraMineR pkg
########################
# create seq object.
mvad.labels = c("employment","further education","higher education","joblessness","school","training");
mvad.scode = c("EM", "FE", "HE", "JL", "SC", "TR");
mvad.seq = seqdef(mvad, 17:86, states = mvad.scode, labels = mvad.labels);
# seq freq plot
seqfplot(mvad.seq, withlegend = F, border = NA, title = "Sequence frequency plot")
# seq dist plot
seqdplot(mvad.seq, withlegend = F, border = NA, title = "State distribution plot");

########################
## Event seq analysis
########################
# first, create sequence event
mvad.seqe <- seqecreate(mvad.seq);
# find freq subseq with min support
fsubseq = seqefsub(mvad.seqe, pMinSupport = 0.05)
fsubseq
