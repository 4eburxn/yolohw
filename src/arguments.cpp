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
		if (parser.has("help")) {
			parser.printMessage();
			return -1;
		}
		std::cerr << "Something went wrong on argument parsing. "
					 "Try:\n\t"
				  << argv[0] << " -f=/path/to/file\n"
				  << std::endl;
		parser.printMessage();
		return 1;
	}
	auto path = parser.get<std::string>("file");
	cap = cv::VideoCapture(path);

	DEBUG_SECTION
	std::cerr << "Dopening capture on " << path
			  << "\n\tstatus: " << cap.isOpened() << std::endl;

	return 0;
}
