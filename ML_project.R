#You could try P vs E or L vs H for the two classes. Probably better wtih P v E. (placentae vs endometrium)
df = read.delim("Normalized_transcriptome_counts (1).txt")
rownames(df) <- df[,1] #Assigning row names from 1st column 
df[,1] <- NULL #Removing the first column
df
