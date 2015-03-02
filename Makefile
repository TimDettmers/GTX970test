all : test_bandwidth1.out test_bandwidth2.out

test_bandwidth1.out : test_bandwidth1.cu
	nvcc test_bandwidth1.cu -o test_bandwidth1.out  -I /usr/local/cuda/include  -L /usr/local/cuda/lib64 -gencode arch=compute_35,code=sm_35

test_bandwidth2.out : test_bandwidth2.cu
	nvcc test_bandwidth2.cu -o test_bandwidth2.out  -I /usr/local/cuda/include  -L /usr/local/cuda/lib64 -gencode arch=compute_35,code=sm_35

run:
	./test_bandwidth1.out
	./test_bandwidth2.out
