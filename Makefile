all: opticalFlowfeedback

opticalFlowfeedback: feedback.o 
	g++ -L/usr/local/lib -o "opticalFlowfeedback" ./feedback.o ./sensors.o ./serial_port.o ./opticalFlow.o ./quadcopter.o ./att_control.o ./pos_control.o ./pid.o -lopencv_core -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_videoio -lopencv_imgcodecs -lopencv_photo -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_shape -lopencv_features2d  -lopencv_objdetect -lopencv_calib3d -lopencv_contrib -lopencv_legacy -lopencv_flann -lpthread

quadcopter.o: quadcopter.cpp quadcopter.h
	g++ -c pid.cpp att_control.cpp pos_control.cpp quadcopter.cpp

opticalFlow.o: opticalFlow.cpp opticalFlow.h quadcopter.o
	g++ -c opticalFlow.cpp

serial_port.o: serial_port.cpp serial_port.h opticalFlow.o
	g++ -c serial_port.cpp

sensors.o: sensors.cpp serial_port.h serial_port.o
	g++ -c sensors.cpp -lpthread

feedback.o: feedback.cpp sensors.h sensors.o
	g++ -c -I/usr/local/include/opencv -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"feedback.d" -MT"feedback.o" feedback.cpp

clean:
	rm -rf *.o
	rm -f opticalFlowfeedback