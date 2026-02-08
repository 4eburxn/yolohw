
#include <iostream>
#include <opencv2/core/mat.hpp>

#include "detector.h"
#include "use.h"

std::vector<std::pair<cv::Rect, float>> detector::get_detections(
	cv::Mat frame) {
	std::vector<std::pair<cv::Rect, float>> detections;
	cv::Mat blob;
	cv::dnn::blobFromImage(frame, blob, 1 / 255.0, cv::Size(640, 640),
						   cv::Scalar(), true, false);

	net_model.setInput(blob);

	std::vector<cv::Mat> outputs;
	net_model.forward(outputs);
	cv::Mat& output = outputs[0];
	if (output.dims == 3) {
		output = output.reshape(1, output.size[1]);
	}
	cv::transpose(output, output);

	int rows = output.rows;
	int dimensions = output.cols;

	float* data = (float*)outputs[0].data;
	std::vector<float> confidences;
	std::vector<cv::Rect> boxes;
	for (int i = 0; i < rows; ++i) {
		float* row_ptr = output.ptr<float>(i);

		if (row_ptr[4] > 0.5) {
			int x = row_ptr[0] * frame.size[1] / 640;
			int y = row_ptr[1] * frame.size[0] / 640;
			int w = row_ptr[2] * frame.size[1] / 640;
			int h = row_ptr[3] * frame.size[0] / 640;

			int left = static_cast<int>(x - w / 2);
			int top = static_cast<int>(y - h / 2);
			boxes.emplace_back(
				cv::Rect(left, top, static_cast<int>(w), static_cast<int>(h)));
			confidences.emplace_back(static_cast<float>(row_ptr[4]));
			std::cout << h << " " << w << " " << row_ptr[4] << std::endl;
		}
	}
	std::vector<int> indices;
	cv::dnn::NMSBoxes(boxes, confidences, 0.5f, 0.45f, indices);

	for (int idx : indices) {
		detections.emplace_back(boxes[idx], confidences[idx]);
	}

	return detections;
}
