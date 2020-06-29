# script calculates average Mean Decrease Accuracy from all set iterations of RF_VI_TS.R script

# load libraries

library(ggplot2)

# set a path to working directory
vstupni_adresar <- choose.dir(getwd(), "Select Working Directory")
prac_adresar <- setwd(vstupni_adresar)

# fuction that stores all ,,variable_importance" .csv files into data frame
csv_list <- list.files(path=getwd(), pattern="*.csv", full.names=TRUE)
csv_files_df <- lapply(csv_list, function(x){read.csv(file=x, header=TRUE, sep=",")[,"MeanDecreaseAccuracy"]})
csv_combined <- do.call("cbind", lapply(csv_files_df, as.data.frame))

# reading of the first file .csv in working directory a taking names of rows
radky <- read.csv(list.files()[c(1)])
radky2 <- as.character(radky[,1])

# extracting Mean Decrese Accuracy and calculating its mean 
vi <- rowMeans(csv_combined)
vi2 <- cbind(csv_combined, vi)
rownames(vi2) <- c(radky2)

# plotting results in ggplot
d <- as.data.frame(cbind(rownames(vi2),vi2$vi))
colnames(d) <- c("MDA", "Value")
d$Value <- as.numeric(as.character(d$Value))
f <- d[order(-d$Value),]

ggplot(f, mapping= aes(x = reorder(MDA, Value), y = Value)) + theme_bw() +
  geom_bar(stat="identity", fill = "#FF6666") + coord_flip() + xlab(NULL) + theme_grey(base_size = 22)

# export results to disk
png(filename="RF_MDA_GGPLOT.png", units="px", width=7000, height=5000, res=600)

ggplot(f, mapping= aes(x = reorder(MDA, Value), y = Value)) + theme_bw() +
  geom_bar(stat="identity", fill = "#FF6666") + coord_flip() + xlab(NULL) + theme_grey(base_size = 22)

dev.off()

