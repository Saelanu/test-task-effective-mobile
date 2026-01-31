def prime_factors(n):
    """
    Разбивает натуральное число на простые множители.

    Параметры:
    n (int): натуральное число для факторизации

    Возвращает:
    list: список простых множителей числа n

    Пример:
    >>> prime_factors(56)
    [2, 2, 2, 7]
    """
    if n <= 1:
        return []

    factors = []
    # Проверяем делимость на 2 отдельно для оптимизации
    while n % 2 == 0:
        factors.append(2)
        n //= 2

    # Проверяем нечетные делители от 3 до sqrt(n)
    i = 3
    while i * i <= n:
        while n % i == 0:
            factors.append(i)
            n //= i
        i += 2  # Проверяем только нечетные числа

    # Если осталось число больше 1, оно простое
    if n > 1:
        factors.append(n)

    return factors

# Практический пример
number = 56
result = prime_factors(number)
print(f"Простые множители числа {number}:", result)
