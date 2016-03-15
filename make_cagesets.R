require(combinat)

make_cagesets <- function(nbirds, bnames = LETTERS, batts = 1:99) {
  
  if (nbirds > length(bnames) | nbirds > length(batts)) {
    stop("number of birds exceeds length of attributes! \n")
  }
  birdnames <- bnames[1:nbirds]
  birdatts <- batts[1:nbirds]
  
  attperms <- permn(birdatts)
  nperms <- length(attperms)
  birdsets <- t(matrix(paste(rep(birdnames,nperms),unlist(attperms),sep="."),nrow=nbirds))
  
  # for each birdset, cageset is made by adding "|" to set and finding all perms
  minbin <- 1
  maxbin <- nbirds-1
  
  cagesets <- c()
  for (i in 1:nrow(birdsets)) {
    bset <- birdsets[i,]
    for (k in minbin:maxbin) {
      topcagesets <- combn(bset,k)
      for (j in 1:ncol(topcagesets)) {
        cagesets <- rbind(cagesets,c(topcagesets[,j],"|",setdiff(bset,topcagesets[,j])))
      }
    }
  }
  return(cagesets)
  
}
