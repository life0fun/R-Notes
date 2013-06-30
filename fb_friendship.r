# the code uses 'facebook' function from the previous gist (https://gist.github.com/1634662) or 
# see the original http://romainfrancois.blog.free.fr/index.php?post/2012/01/15/Crawling-facebook-with-R

# scrape the list of friends
friends <- facebook( path="me/friends" , access_token=access_token)
# extract Facebook IDs
friends.id <- sapply(friends$data, function(x) x$id)
# extract names 
friends.name <- sapply(friends$data, function(x)  iconv(x$name,"UTF-8","ASCII//TRANSLIT"))
# short names to initials 
initials <- function(x) paste(substr(x,1,1), collapse="")
friends.initial <- sapply(strsplit(friends.name," "), initials) 

# friendship relation matrix
N <- length(friends.id)
friendship.matrix <- matrix(0,N,N)
for (i in 1:N) {
  tmp <- facebook( path=paste("me/mutualfriends", friends.id[i], sep="/") , access_token=access_token)
  mutualfriends <- sapply(tmp$data, function(x) x$id)
  friendship.matrix[i,friends.id %in% mutualfriends] <- 1
}

require(Rgraphviz)
# convert relation matrix to graph
g <- new("graphAM", adjMat=friendship.matrix)

# ellipse graph with initials
pdf(file="facebook1.pdf", width=25, height=25)
  attrs <- list(node=list(shape="ellipse", fixedsize=FALSE))
  nAttrs <- list(label=friends.initial)
  names(nAttrs$label) <- nodes(g)
  plot(g, "neato", attrs=attrs, nodeAttrs=nAttrs)
dev.off()


require(pixmap)
# download small profile picture of each friend
dir.create("photos")
for (i in 1:length(friends.id))
  download.file(paste("http://graph.facebook.com", friends.id[i], "picture", sep="/"), 
                destfile=paste("photos/",friends.id[i],".jpg",sep=""))
system('for i in `ls photos/*.jpg`; do j=${i%.*}; convert $j.jpg $j.pnm; done', wait=TRUE)

# customized node plotting function
makeNodeDrawFunction <- function(x) {
 force(x)
 function(node, ur, attrs, radConv) {
    photo <- read.pnm(paste("photos/", x, ".pnm", sep=""))
    nc <- getNodeCenter(node)
    addlogo(photo, c(getX(nc)-25, getX(nc)+25), c(getY(nc)-25, getY(nc)+25))
  }
}
drawFuns <- apply(as.array(friends.id), 1, makeNodeDrawFunction)

# a graph with photos
pdf(file="facebook2.pdf", width=25, height=25)
  attrs <- list(node=list(shape="box", width=0.75, height=0.75))
  plot(g, "neato", attrs=attrs, drawNode=drawFuns)
dev.off()

