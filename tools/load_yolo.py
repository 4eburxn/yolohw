
import subprocess
import sys

def download_and_export_model():
    """Скачивает модель YOLOv8n и экспортирует её в ONNX."""
    from ultralytics import YOLO

    print("Загрузка модели YOLOv8n.pt...")
    model = YOLO('yolov8n.pt')

    print("Экспорт модели в формат ONNX...")
    model.export(format='onnx', opset=12, imgsz=640)
    print("Модель успешно экспортирована в 'yolov8n.onnx'.")

if __name__ == "__main__":
    download_and_export_model()
    print("\nГотово! Модель 'yolov8n.onnx' готова для использования с OpenCV C++.")
