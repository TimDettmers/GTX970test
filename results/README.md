```
rm test_bandwidth1.stdout
while true; do ./test_bandwidth1.out >> test_bandwidth1.stdout; sleep 1; done
grep ^Data test_bandwidth1.stdout \
 | perl -plne's/.*?([\d\.]+).*?([\d\.]+).*/$1\t $2/;' > bandwidth.tsv
```
