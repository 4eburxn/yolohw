#include <iostream>
#include <opencv2/core/mat.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/videoio.hpp>

#include "arguments.h"
#include "use.h"

int main(int argc, char* argv[]) {
	cv::VideoCapture cap;
	int code = handle_arguments(argc, argv, cap);
	if (code == -1) return 0;
	if (code) return 1;

	cv::Mat frame;
	int k = 0;
	while (cap.read(frame)) {
		DEBUG_SECTION k++;
		int keyboard = cv::waitKey(30);
		cv::imshow("base_frame", frame);
	}
	DEBUG_SECTION
	std::cerr << "total frames: " << k << std::endl;

	return 0;
}
