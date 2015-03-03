```
bash>
rm test_bandwidth1.stdout
for s in {1..30}; do ./test_bandwidth1.out >> test_bandwidth1.stdout; sleep 1; done
grep ^Data test_bandwidth1.stdout \
 | perl -plne's/.*?([\d\.]+).*?([\d\.]+).*/$1\t $2/;' > bandwidth.tsv

R>
library(ggplot2)
df = read.delim("bandwidth.tsv", col.names=c("size", "bandwidth"))
df$size = as.factor(df$size)
ggplot(df, aes(size, bandwidth)) + geom_boxplot() + ggtitle("30 runs of test_bandwidth1")
```
