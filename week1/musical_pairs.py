import random
from datetime import *

students = [
    "A", "B", "C", "D",
    "E", "F", "G", "H",
    "I", "J", "K", "L"
]

today_string = str(date.today())
random.seed(today_string)

random.shuffle(students)

print("=" * 40)
print(f"🎵 MUSICAL PAIRS FOR {today_string} 🎵")
print("=" * 40)