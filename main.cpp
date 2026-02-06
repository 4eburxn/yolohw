#include <iostream>
#include <opencv2/core/mat.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/videoio.hpp>

#include "arguments.h"

int main(int argc, char* argv[]) {
	cv::VideoCapture cap;
	if (handle_arguments(argc, argv, cap)) return 1;

	cv::Mat frame;
	while (cap.read(frame)) {
		int keyboard = cv::waitKey(8);
		cv::imshow("base_frame", frame);
	}

	return 0;
}
