
import subprocess
import sys

def download_and_export_model():
    from ultralytics import YOLO

    print("loading YOLOv8n.pt...")
    model = YOLO('yolov8n.pt')

    model.export(format='onnx', opset=12, imgsz=640)
    print("exported 'yolov8n.onnx'.")

if __name__ == "__main__":
    download_and_export_model()
