#!/bin/sh

rm -f ./outputs/*
#g++ -I mavlink/include/mavlink/v1.0 sensors.cpp serial_port.cpp quadcopter.cpp  -o sensors.o -lpthread

g++ -I/usr/local/include/opencv -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"feedback.d" -MT"feedback.o" -o "feedback.o" "feedback.cpp"

g++ -L/usr/local/lib -o "opticalFlowfeedback" ./feedback.o -lopencv_core -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_videoio -lopencv_imgcodecs -lopencv_photo -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_shape -lopencv_features2d  -lopencv_objdetect -lopencv_calib3d -lopencv_contrib -lopencv_legacy -lopencv_flann -lpthread

./opticalFlowfeedback $1 $2 $3 $4
