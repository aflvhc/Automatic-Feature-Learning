# This Makefile is used under Linux

# Change this to your matlab directory
MATLABDIR ?= /usr/sww/pkg/matlab-r2008a
CXX ?= g++
#CXX = g++-3.3
CFLAGS = -Wall -O3 -fPIC -I$(MATLABDIR)/extern/include

MEX = $(MATLABDIR)/bin/mex
MEX_OPTION = CC\#$(CXX) CXX\#$(CXX) CFLAGS\#"$(CFLAGS)" CXXFLAGS\#"$(CFLAGS)"
# uncomment the following line if you use MATLAB 7.3 (or above) on 64-bit computer
MEX_OPTION += -largeArrayDims

#MEX_EXT = $(shell $(MATLABDIR)/bin/mexext) 
MEX_EXT = mexglx

all: svmpredict.$(MEX_EXT) svmtrain.$(MEX_EXT) read_sparse.$(MEX_EXT) precomp_model.$(MEX_EXT) fiksvm_predict.$(MEX_EXT)

fiksvm_predict.$(MEX_EXT): fiksvm_predict.cpp fiksvm.o
	$(MEX) $(MEX_OPTION) fiksvm_predict.cpp fiksvm.o 

precomp_model.$(MEX_EXT): precomp_model.cpp svm_model_matlab.o fiksvm.o svm.o
	$(MEX) $(MEX_OPTION) precomp_model.cpp fiksvm.o svm_model_matlab.o svm.o


svmpredict.$(MEX_EXT):     svmpredict.c svm.h svm.o svm_model_matlab.o
	$(MEX) $(MEX_OPTION) svmpredict.c svm.o svm_model_matlab.o

svmtrain.$(MEX_EXT):       svmtrain.c svm.h svm.o svm_model_matlab.o
	$(MEX) $(MEX_OPTION) svmtrain.c svm.o svm_model_matlab.o

read_sparse.$(MEX_EXT):	read_sparse.c
	$(MEX) $(MEX_OPTION) read_sparse.c

svm_model_matlab.o:     svm_model_matlab.c svm.h
	$(CXX) $(CFLAGS) -c svm_model_matlab.c

svm.o:  svm.cpp svm.h
	$(CXX) $(CFLAGS) -c svm.cpp

fiksvm.o: fiksvm.cpp fiksvm.h svm.h
	$(MEX) $(MEX_OPTION) -c fiksvm.cpp

clean:
	rm -f *~ *.o; rm -f *.mex*; rm -f *obj

