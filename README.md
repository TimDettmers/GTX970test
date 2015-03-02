# GTX970test
Bandwidth tests for the GTX970 to diagnose the memory problem for the last 0.5GB

Use "make" to compile and "make run" to run both tests.

These tests test both shared memory and global memory access in a more realistic setting than other benchmarks:

1. Add kernel test: The memory is read, modified and rewritten to the same location

2. Transpose and copy kernel test: Data is swapped from one place in memory and back, tested with both shared memory and global memory.
