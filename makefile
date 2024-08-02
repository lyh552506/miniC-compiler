# Compiler and flags
CXX = clang++
CXXFLAGS = -std=c++20 -O2 -lm -lpthread -L/extlibs -g
INCLUDES = -I/extlibs -I./util -I./include/backend -I./include/yacc -I./include/lib -I./include/ir/opt -I./include/Analysis

# Directories to search for source files
SRC_DIRS = ./lib ./yacc ./backend ./ir/opt ./ir/Analysis

# Output executable
TARGET = ./compiler

# Find all .cpp files in the specified directories
SRCS = $(shell find $(SRC_DIRS) -name '*.cpp')
SRCS += ./main.cpp
# OBJS = $(SRCS:.cpp=.o)

# Default target
all: $(TARGET)

# Link the executable
$(TARGET):	$(OBJS)
	$(CXX) $(CXXFLAGS) $(SRCS) $(INCLUDES) -o $@

# Compile each .cpp file to .o
# %.o: %.cpp
# 	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

# Clean up
clean:
	rm -f $(TARGET)

.PHONY: all clean