def is_isomorphic(s: str, t: str) -> bool:
    """
    Проверяет, являются ли две строки изоморфными.

    Параметры:
    s (str): первая строка
    t (str): вторая строка

    Возвращает:
    bool: True если строки изоморфны, иначе False
    """
    if len(s) != len(t):
        return False

    # Словари для отслеживания соответствий символов
    s_to_t = {}  # соответствие s -> t
    t_to_s = {}  # соответствие t -> s (для проверки уникальности)

    for char_s, char_t in zip(s, t):
        # Проверка соответствия s -> t
        if char_s in s_to_t:
            # Если символ s уже встречался, он должен соответствовать тому же символу t
            if s_to_t[char_s] != char_t:
                return False
        else:
            # Если символ s новый, проверяем, что символ t еще не использован
            if char_t in t_to_s:
                return False
            # Устанавливаем двустороннее соответствие
            s_to_t[char_s] = char_t
            t_to_s[char_t] = char_s

    return True


# Примеры использования
if __name__ == "__main__":
    # Тестовые примеры
    test_cases = [
        ("paper", "title", True),
        ("egg", "add", True),
        ("foot", "stop", False),
        ("ab", "aa", False),
        ("a", "a", True),
        ("ab", "cd", True),
        ("s", "s", True),
        ("t", "t", True),
        ("1", "p", False),
        ("", "", True),
    ]

    print("Тестирование функции is_isomorphic:")
    print("-" * 40)

    for s, t, expected in test_cases:
        result = is_isomorphic(s, t)
        status = "✓" if result == expected else "✗"
        print(f"{status} is_isomorphic('{s}', '{t}') = {result} (ожидалось: {expected})")

    # Пример из задания
    print("\n" + "=" * 40)
    print("Пример из задания:")
    s = 'paper'
    t = 'title'
    print(f"s = '{s}', t = '{t}'")
    print(f"is_isomorphic(s, t) = {is_isomorphic(s, t)}")
    # Вывод: True