#include <iostream>
#include <opencv2/core/mat.hpp>
#include <opencv2/core/types.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/opencv.hpp>
#include <opencv2/videoio.hpp>
#include <string>

#include "arguments.h"
#include "detector.h"
#include "use.h"

inline cv::Scalar cbc(float c) {
	// 1) 0.5
	// 2) 0.7
	// 3) 0.9
	// 4) 0.95
	// 5) 0.98
	if (c < 0.7) return cv::Scalar(0, 0, 255);
	if (c < 0.9) return cv::Scalar(0, 255, 255);
	if (c < 0.95) return cv::Scalar(0, 255, 127);
	if (c < 0.95) return cv::Scalar(0, 255, 0);
	return cv::Scalar(0, 255, 0);
}

int main(int argc, char* argv[]) {
	cv::VideoCapture cap;
	std::string model_name;

	int code = handle_arguments(argc, argv, cap, model_name);
	if (code == -1) return 0;
	if (code) return 1;

	detector dtct(cv::dnn::readNetFromONNX(model_name));

	cv::Mat frame;
	int k = 0;
	while (cap.read(frame)) {
		DEBUG_SECTION k++;
		int keyboard = cv::waitKey(1);
		auto detections = dtct.get_detections(frame);
		for (auto& i : detections) {
			auto color = cbc(i.second);
			cv::rectangle(frame, i.first, color);
			cv::putText(frame, std::to_string(i.second),
						cv::Point(i.first.x, i.first.y),
						cv::FONT_HERSHEY_COMPLEX, 1, color);
		}

		cv::imshow("base_frame", frame);
	}
	DEBUG_SECTION
	std::cerr << "total frames: " << k << std::endl;

	return 0;
}
