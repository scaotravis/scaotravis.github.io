rm(list = ls()) # clear out environment 
df = read.table("GPA.csv", header=TRUE, sep=",")
print(paste0("Mean is ", mean(df$hsGPA)))
sd(df$hsGPA)
quantile(df$hsGPA, probs=.75)
hist(df$hsGPA, xlab="High School GPA", main="Histogram of High School GPA")
cor(df$hsGPA, df$ACT)
plot(df$hsGPA, df$ACT, xlab="High School GPA", ylab="ACT Score", main="Scatterplot")
t.test(df$hsGPA, mu=3.5, conf.level=.90)
