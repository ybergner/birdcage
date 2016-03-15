# Pet Shop Display
# 
# Arturo is planning the parakeet display for his pet shop.  He has five parakeets, Alice, Bob, Carla, Diwakar, and Etria.  Each is a different color; not necessarily in the same order, they are white, speckled, green, blue, and yellow.  Arturo has two cages.  The top cage holds three birds, and the bottom cage holds two.  The display must meet the following additional conditions:
#   
# Alice is in the bottom cage.
# Bob is in the top cage and is not speckled. 
# Carla cannot be in the same cage as the blue parakeet.
# Etria is green.
# The green parakeet and the speckled parakeet are in the same cage.
# 
# If Carla is in the top cage, which of the following must be true?
# a)  The green parakeet is in the bottom cage.
# b)  The speckled parakeet is in the bottom cage.
# c)  Diwakar is in the top cage.
# d)  Diwakar is in the bottom cage.
# e)  The blue parakeet is in the top cage.

# problem constraints
# 5 birds in 2 bins (obviously numbers can vary)
# each bird has a name and an attribute
# constraints take one of these forms:
#     specificy attribute of named parakeet (or vice versa) -- denote B.3 or B!3
#     specify bin/!bin for bird by attribute or name -- denote A| or |A
#     specify colocation/!colocation for two birds  -- denote A_and_B or A_andnot_3
#         NB: tricks are possible in that A_and_3 does not require A!3

# a) given some constraints and ask for which MUST be true
# b) given some constraints, ask for cage assignments

# Combinatorics
# 5 birds with names {A,B,C,D,E} and attributes {1,2,3,4,5}
# 5! = 120 ways to assign attributes to birds
# If at least one bird must be in each cage then 
# 5C1 + 5C2 + 5C3 + 5C4 = 30 ways to distrubute birds in 2 cages
# So 3600 cage sets

source("make_cagesets.R")
source("check_constraints.R")

# start with a toy example

nbirds <- 3
tmpcagesets <- make_cagesets(nbirds)
tmpconstraints <- c("B!3", "A_andnot_B", "|A")
tmpcagesets[check_constraints(tmpcagesets, tmpconstraints),]


# now test LSAT example

nbirds <- 5
cagesets <- make_cagesets(nbirds, 
                          bnames = c("Alice", "Bob", "Carla", "Diwakar", "Etria"),
                          batts = c("white", "speckled", "green", "blue", "yellow")
)
# The top cage holds three birds, and the bottom cage holds two.  
# Alice is in the bottom cage.
# Bob is in the top cage and is not speckled. 
# Carla cannot be in the same cage as the blue parakeet.
# Etria is green.
# The green parakeet and the speckled parakeet are in the same cage.

constraints <- c("top_3", "|Alice", "Bob|", "Bob!speckled", "Carla_andnot_blue", "Etria.green", "green_and_speckled")
cagesets[check_constraints(cagesets, constraints),]

# underdetermined, as should be until we add the last constraint that Carla is in the top cage
constraints <- c("top_3", 
                 "|Alice", 
                 "Bob|", 
                 "Bob!speckled", 
                 "Carla_andnot_blue", 
                 "Etria.green", 
                 "green_and_speckled",
                 "Carla|")
cagesets[check_constraints(cagesets, constraints),]



