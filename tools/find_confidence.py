import sys
import math

def main():
    data = []
    
    # Чтение данных из stdin или файла
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            height, width, confidence = map(float, line.split())
            area = height * width
            data.append((area, confidence))
        except ValueError:
            print(f"Пропущена некорректная строка: {line}", file=sys.stderr)
    
    if not data:
        print("Нет данных для анализа.")
        return
    
    # Пороги уверенности
    thresholds = [0.5, 0.7, 0.9, 0.95, 0.98]
    
    results = {}
    
    for threshold in thresholds:
        # Фильтруем объекты с уверенностью >= порога
        filtered_areas = [area for area, conf in data if conf >= threshold]
        
        if not filtered_areas:
            results[threshold] = None
            continue
        
        # Сортируем площади
        filtered_areas.sort()
        
        # Находим 95-й перцентиль (индекс = 0.95 * n, округляем вверх)
        n = len(filtered_areas)
        index = math.ceil(0.05 * n) - 1  # -1 для индексации с 0
        index = max(0, min(index, n - 1))  # Защита от выхода за границы
        
        results[threshold] = filtered_areas[index]
    
    # Вывод результатов
    print("Минимальная площадь для покрытия 5% объектов с заданной уверенностью:")
    print("-" * 60)
    print(f"{'Порог':<15} {'Минимальная площадь':<20}")
    print("-" * 60)
    
    for threshold in thresholds:
        area = results[threshold]
        if area is None:
            print(f"{threshold:<15} {'Нет данных':<20}")
        else:
            print(f"{threshold:<15} {area:<20.2f}")

if __name__ == "__main__":
    main()
