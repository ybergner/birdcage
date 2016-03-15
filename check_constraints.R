check_constraints <- function(cagesets, constraints) {
  rows_satisfying_const <- 1:nrow(cagesets)
  for (const in constraints) {
    if (length(grep("top_",const))) { # size of cage
      topsize <- as.integer(strsplit(const,"top_")[[1]][2])
      ok_rows <- which(apply(cagesets, 1, function(c) {which(c == "|") == (topsize+1)}))
    }
    else if (length(grep("[.]",const))) { # simple match of birdname and birdatt
      ok_rows <- which(apply(cagesets, 1, function(c) {length(grep(const, c)) > 0}))
    }
    else if (length(grep("[!]",const))) { # simple match of birdname and birdatt
      const <- gsub("!",".",const)
      ok_rows <- which(apply(cagesets, 1, function(c) {length(grep(const, c)) == 0}))
    }
    else if (length(grep("_andnot_",const))) {
      birdvars <- strsplit(const,"_andnot_")[[1]]
      tmp1 <- apply(cagesets, 1, function(c) {grep(birdvars[1],c) < which(c == "|")})
      tmp2 <- apply(cagesets, 1, function(c) {grep(birdvars[2],c) < which(c == "|")})
      ok_rows <- which((tmp1 & !tmp2) | (!tmp1 & tmp2))
    }
    else if (length(grep("_and_",const))) {
      birdvars <- strsplit(const,"_and_")[[1]]
      tmp1 <- apply(cagesets, 1, function(c) {grep(birdvars[1],c) < which(c == "|")})
      tmp2 <- apply(cagesets, 1, function(c) {grep(birdvars[2],c) < which(c == "|")})
      ok_rows <- which((tmp1 & tmp2) | (!tmp1 & !tmp2))
    }
    else if (length(grep("^[|]",const))) { 
      birdvar <- strsplit(const, "[|]")[[1]][2]
      ok_rows <- which(apply(cagesets, 1, function(c) {grep(birdvar,c) > which(c == "|")}))
    }
    else if (length(grep("[|]$",const))) { 
      birdvar <- strsplit(const, "[|]")[[1]]
      ok_rows <- which(apply(cagesets, 1, function(c) {grep(birdvar,c) < which(c == "|")}))
    } else {
      cat ("unknown constraint \n")
      ok_rows <- 1:nrow(cagesets)
    }
    rows_satisfying_const <- intersect(rows_satisfying_const, ok_rows)
  }
  return(rows_satisfying_const)
}
