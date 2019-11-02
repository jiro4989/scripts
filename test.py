#!/usr/bin/env python

def func1():
    print 1

def func2():
    print 2

def func3(): # pragma: no cover
    print 3

if __name__ == "__main__":
    import sys
    #func1()
    #func2()
    if len(sys.argv) > 1:
        if sys.argv[1] == "1":
            func1()
        if sys.argv[1] == "2":
            func2()
