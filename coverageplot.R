SRR503481 <- read.delim("SRR503481cov.txt", header=FALSE) #reading in a tab delimited file
SRR503478 <- read.delim("SRR503478cov.txt", header=FALSE)
SRR503479 <- read.delim("SRR503479cov.txt", header=FALSE)
SRR503480 <- read.delim("SRR503480cov.txt", header=FALSE)
head(SRR503481) #take a look at the first few columns

colnames(SRR503481) <- c("Fasta_header", "Start", "End", "Depth")#adding column names
colnames(SRR503478) <- c("Fasta_header", "Start", "End", "Depth")
colnames(SRR503479) <- c("Fasta_header", "Start", "End", "Depth")
colnames(SRR503480) <- c("Fasta_header", "Start", "End", "Depth")

head(SRR503481) #take a look again and see that the column names have been added

library(dplyr)
library(ggplot2) #loads the packages

Parental <- SRR503481 %>% mutate(Sample = "Parental", RelativeDepth = (Depth/median(Depth))) #creates new variables providing sample ID and read depths normalized by the median depth
Replicate_1 <- SRR503478 %>% mutate(Sample = "Replicate_1", RelativeDepth = (Depth/median(Depth)))
Replicate_2 <- SRR503479 %>% mutate(Sample = "Replicate_2", RelativeDepth = (Depth/median(Depth)))
Replicate_3 <- SRR503480 %>% mutate(Sample = "Replicate_3", RelativeDepth = (Depth/median(Depth)))

vacciniadata <- rbind(Parental,Replicate_1,Replicate_2,Replicate_3) #combines the data frames

ggplot(vacciniadata,aes(x=Start, y=RelativeDepth,col=Sample))+
  geom_col()+
  geom_vline(xintercept=c(28863,31863,49411,52411),linetype="dashed")+
  xlab("Genome (base pairs)")+
  facet_grid(rows = vars(Sample)) #plotting while separating and coloring the plots by the Sample variable
