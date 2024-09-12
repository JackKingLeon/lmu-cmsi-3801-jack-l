from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


def first_then_lower_case (strings, fxn, /):
    for str in strings:
        if fxn(str):
            return str.lower()

    return None

def powers_generator(*, base, limit):
    power = 0
    while pow(base, power) <= limit:
        yield pow(base, power)
        power = power + 1

def say(words=None, /):
    def inner(word=None, /):
        if word is None:
            return words
        return say(words + " " + word)

    if words is None:
        return ""
    return inner

def meaningful_line_count(file, /):
    f = open(file, encoding="utf8")
    if f is None:
        raise FileNotFoundError
    
    lines = []

    for line in f.readlines():
        line = line.strip()
        if line != None and line != "" and line[0] != "#":
            lines.append(line)

    f.close()
    return len(lines)

@dataclass(frozen=True)
class Quaternion:
    a: int
    b: int
    c: int
    d: int
    coefficients = tuple
    conjugate = tuple

    def __post__init__(self, /):
        object.__setattr__(self, 'a', self.a)
        object.__setattr__(self, 'b', self.b)
        object.__setattr__(self, 'c', self.c)
        object.__setattr__(self, 'd', self.d)

    @property
    def coefficients(self, /):
        return Quaternion(self.a, self.b, self.c, self.d)
    
    @property
    def conjugate(self, /):
        return Quaternion(self.a, -self.b, -self.c, -self.d)

    def __add__(self, q, /):
        return Quaternion(self.a + q.a, self.b + q.b, self.c + q.c, self.d + q.d)
    
    def __eq__(self, q, /):
        if type(q) == tuple and self.a == q[0] and self.b == q[1] and self.c == q[2] and self.d == q[3]:
            return True
        elif self.a == q.a and self.b == q.b and self.c == q.c and self.d == q.d:
            return True
        return False
    
    def __mul__(self, q, /):
        return Quaternion(
        (self.a * q.a - self.b * q.b - self.c * q.c - self.d * q.d),
        (self.a * q.b + self.b * q.a + self.c * q.d - self.d * q.c),
        (self.a * q.c - self.b * q.d + self.c * q.a + self.d * q.b),
        (self.a * q.d + self.b * q.c - self.c * q.b + self.d * q.a)
        )
    def has_decimal (self, num, /):
        return num % 1 > 0
    
    def __str__(self, /):
        return_str = ""
        if self.a == 0 and self.b == 0 and self.c == 0 and self.d == 0:
            return_str = "0"
            return return_str

        if self.a != 0:
            if self.has_decimal(self.a):
                return_str = return_str + f"{self.a}"
            else:
                return_str = return_str + f"{self.a:.1f}"

        if self.b != 0:
            if self.has_decimal(self.b):
                return_str = return_str + f"{self.b:+g}i"
            else:
                return_str = return_str + f"{self.b:+.1f}i"
        if abs(self.b) == 1:
            return_str = return_str.replace("1.0","")

        if self.c != 0:
            if self.has_decimal(self.c):
                return_str = return_str + f"{self.c:+g}j"
            else:
                return_str = return_str + f"{self.c:+.1f}j"
        if abs(self.c) == 1:
            return_str = return_str.replace("1.0","")

        if self.d != 0:
            if self.has_decimal(self.d):
                return_str = return_str + f"{self.d:+g}k"
            else:
                return_str = return_str + f"{self.d:+.1f}k"
        if abs(self.d) == 1:
            return_str = return_str.replace("1.0","")

        if return_str[0] == "+":
            return_str = return_str[1:]

        return return_str 
