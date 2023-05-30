#!/bin/bash
# Terminal boyutlarını al
COLS=$(tput cols)
ROWS=$(tput lines)

# Yıldız yoğunluğu ayarı
DENSITY=2  # Yoğunluk oranını 100 ile çarpılmış hali

# Yıldız sayısı hesaplama
STAR_COUNT=$((COLS * ROWS * DENSITY / 100))

# Yıldız işaretlerini rastgele konumlara yerleştirme
for ((i=0; i<STAR_COUNT; i++)); do
  x=$((RANDOM % COLS))
  y=$((RANDOM % ROWS))
  tput cup $y $x
  printf "\e[34m★\e[0m"
done

# İmleci sona taşıma
tput cup $ROWS $COLS
