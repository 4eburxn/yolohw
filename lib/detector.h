#ifndef __DETECTOR_H__
#define __DETECTOR_H__

#include <iostream>
#include <opencv2/core/types.hpp>
#include <opencv2/dnn.hpp>
#include <vector>

#include "use.h"

class detector {
   private:
	cv::dnn::Net net_model;
	const int person_id = 0;
	class box {
	   public:
		cv::Rect first;
		float second;
		int clss;
	};

   public:
	detector(cv::dnn::Net model_) : net_model(model_) {
		// net_model.setPreferableBackend(cv::dnn::DNN_BACKEND_OPENCV);
		// net_model.setPreferableTarget(cv::dnn::DNN_TARGET_CPU);
		DEBUG_SECTION
		std::cerr << "detector created" << std::endl;
	};
	std::vector<box> get_detections(cv::Mat frame);
};

#endif	// !__DETECTOR_H__
