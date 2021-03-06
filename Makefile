LDFLAGS = `sh osflags ld $(MODE)`
CFLAGS = -c -g `sh osflags c $(MODE)`
#CFLAGS = -c -g `sh osflags c $(MODE)` -std=c++11
TUN_DEV_FILE = `sh osflags dev $(MODE)`
GCC = gcc
GPP = g++

all: hans++

hans++: otp.o tun.o sha1.o main.o client.o server.o auth.o worker.o time.o tun_dev.o echo.o exception.o utility.o
	$(GPP) -o hans++ otp.o tun.o sha1.o main.o client.o server.o auth.o worker.o time.o tun_dev.o echo.o exception.o utility.o $(LDFLAGS)

utility.o: utility.cpp utility.h
	$(GPP) -c utility.cpp $(CFLAGS)

exception.o: exception.cpp exception.h
	$(GPP) -c exception.cpp $(CFLAGS)

echo.o: echo.cpp echo.h exception.h
	$(GPP) -c echo.cpp $(CFLAGS)

tun.o: tun.cpp otp.h tun.h exception.h utility.h tun_dev.h 
	$(GPP) -c tun.cpp $(CFLAGS)

tun_dev.o:
	$(GCC) -c $(TUN_DEV_FILE) -o tun_dev.o $(CFLAGS)

sha1.o: sha1.cpp sha1.h
	$(GPP) -c sha1.cpp $(CFLAGS)

main.o: main.cpp client.h server.h exception.h worker.h auth.h time.h echo.h tun.h tun_dev.h
	$(GPP) -c main.cpp $(CFLAGS)

client.o: client.cpp client.h server.h exception.h config.h worker.h auth.h time.h echo.h tun.h tun_dev.h
	$(GPP) -c client.cpp $(CFLAGS)

server.o: server.cpp server.h client.h utility.h config.h worker.h auth.h time.h echo.h tun.h tun_dev.h
	$(GPP) -c server.cpp $(CFLAGS)

auth.o: auth.cpp auth.h sha1.h utility.h
	$(GPP) -c auth.cpp $(CFLAGS)

worker.o: worker.cpp worker.h tun.h exception.h time.h echo.h tun_dev.h config.h
	$(GPP) -c worker.cpp $(CFLAGS)

time.o: time.cpp time.h
	$(GPP) -c time.cpp $(CFLAGS)

otp.o: otp.cpp otp.h
	$(GPP) -c otp.cpp $(CFLAGS)

clean:
	rm -f tun.o sha1.o main.o client.o server.o auth.o worker.o time.o tun_dev.o echo.o exception.o utility.o tunemu.o otp.o hans++


tunemu.o: tunemu.h tunemu.c
	$(GCC) -c tunemu.c -o tunemu.o
