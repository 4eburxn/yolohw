#include <toml++/toml.h>

#include <iostream>
#include <string>
#include <toml++/impl/parser.hpp>

#include "arguments.h"
#include "use.h"

const cv::String params =
	"{help h usage ? || print this message }"
	"{config c       || path to config     }"
	// "{video v        || device number      }"
	// "{port p         || port of http srv   }"
	"{file f         || path to video file }";

int handle_arguments(int argc, char* argv[], cv::VideoCapture& cap) {
	std::string path;

	cv::CommandLineParser parser(argc, argv, params);
	if (parser.has("help")) {
		parser.printMessage();
		return -1;
	}
	if (parser.has("file")) {
		path = parser.get<std::string>("file");
		return 1;
	} else {
		std::string cfgpath;
		if (parser.has("config"))
			cfgpath = parser.get<std::string>("config");
		else
			cfgpath = "./default.toml";

		auto conf = toml::parse_file(cfgpath);
		path = conf["path"].value_or("");
		if (!path.length()) {
			return 2;
		}
	}

	cap = cv::VideoCapture(path);
	DEBUG_SECTION
	std::cerr << "Dopening capture on " << path
			  << "\n\tstatus: " << cap.isOpened() << std::endl;

	return 0;
}
