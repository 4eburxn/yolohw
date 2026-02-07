#include <iostream>

#include "arguments.h"
#include "use.h"

const cv::String params =
	"{help h usage ? || print this message }"
	// "{config c       || path to config     }"
	// "{video v        || device number      }"
	// "{port p         || port of http srv   }"
	"{file f         || path to video file }";

int handle_arguments(int argc, char* argv[], cv::VideoCapture& cap) {
	cv::CommandLineParser parser(argc, argv, params);
	if (!parser.has("file")) {
		std::cerr << "something went wrong on argument parsing. "
					 "Usage:\n\t"
				  << argv[0] << " -f=/path/to/file" << std::endl;
		return 1;
	}
	auto path = parser.get<std::string>("file");
	cap = cv::VideoCapture(path);

	DEBUG_SECTION
	std::cerr << "Dopening capture on " << path
			  << "\n\tstatus: " << cap.isOpened() << std::endl;

	return 0;
}
