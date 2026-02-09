from ultralytics import YOLO

# Загружаем модель
model = YOLO('./yolov8n.pt')

results = model.val(data='coco8.yaml')

target_class = 'person'
class_index = 0

print(f"\nРезультаты для класса {target_class}:")
print(f"Precision: {results.box.p[class_index]:.4f}")
print(f"Recall: {results.box.r[class_index]:.4f}\n")
