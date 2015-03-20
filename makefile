# Example 22
EXE=hw09

# Main target
all: $(EXE)

#  MinGW
ifeq "$(OS)" "Windows_NT"
CFLG=-O3 -Wall -DUSEGLEW
LIBS=-lglew32 -lglut32cu -lglu32 -lopengl32
CLEAN=del *.exe *.o *.a
else
#  OSX
ifeq "$(shell uname)" "Darwin"
CFLG=-O3 -Wall -Wno-deprecated-declarations
LIBS=-framework GLUT -framework OpenGL
#  Linux/Unix/Solaris
else
CFLG=-O3 -Wall
LIBS=-lglut -lGLU -lGL -lm
endif
#  OSX/Linux/Unix/Solaris
CLEAN=rm -f $(EXE) *.o *.a
endif

# Dependencies
hw09.o: hw09.c CSCIx239.h
fatal.o: fatal.c CSCIx239.h
cube.o: cube.c CSCIx239.h
light.o: light.c CSCIx239.h
projection.o: projection.cpp CSCIx239.h
loadtexbmp.o: loadtexbmp.c CSCIx239.h
print.o: print.c CSCIx239.h
project.o: project.c CSCIx239.h
errcheck.o: errcheck.c CSCIx239.h
object.o: object.c CSCIx239.h
fps.o: fps.c CSCIx239.h
elapsed.o: elapsed.c CSCIx239.h
shader.o: shader.c CSCIx239.h
noise.o: noise.c CSCIx239.h

#  Create archive
CSCIx239.a:fatal.o loadtexbmp.o print.o project.o errcheck.o object.o fps.o elapsed.o shader.o noise.o cube.o light.o projection.o
	ar -rcs $@ $^

# Compile rules
.c.o:
	g++ -c $(CFLG) $<
.cpp.o:
	g++ -c $(CFLG) $<

#  Link
hw09:hw09.o CSCIx239.a
	g++ -O3 -o $@ $^   $(LIBS)

#  Clean
clean:
	$(CLEAN)
