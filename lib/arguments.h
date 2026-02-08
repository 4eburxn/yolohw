#ifndef __ARGUMENTS_H__
#define __ARGUMENTS_H__
#include <opencv2/videoio.hpp>

int handle_arguments(int argc, char* argv[], cv::VideoCapture& cap,
					 std::string& model_path);

#endif	// !__ARGUMENTS_H__
