# =========================
# MENENTUKAN SAMPEL (SLOVIN)
# =========================

N <- 1880
e <- 0.19

n <- N / (1 + N * e^2)

n
ceiling(n)



# =========================
# MEMANGGIL LIBRARY
# =========================

library(readxl)
library(psych)



# =========================
# IMPORT DATA
# =========================

data <- read_excel("C:/Users/Lenovo T480s/Downloads/DATA KUSIONER ZOOM MEETING (2).xlsx")

View(data)



# =========================
# MENGAMBIL ITEM PERTANYAAN
# =========================

item <- data[, c("P1","P2","P3","P4","P5",
                 "P6","P7","P8","P9","P10")]



# =========================
# SKOR TOTAL
# =========================

total <- rowSums(item)

total



# =========================
# UJI VALIDITAS
# =========================

validitas <- cor(item, total)

validitas



# =========================
# R TABEL
# =========================

# n = 30
# df = n - 2 = 28
# alpha = 0.05
# r tabel = 0.361

r_tabel <- 0.361

r_tabel



# =========================
# MEMBUAT TABEL VALIDITAS
# =========================

hasil_validitas <- data.frame(
  Item = colnames(item),
  r_hitung = round(as.vector(validitas),3)
)

hasil_validitas$Keterangan <- ifelse(
  hasil_validitas$r_hitung > r_tabel,
  "Valid",
  "Tidak Valid"
)

hasil_validitas



# =========================
# UJI RELIABILITAS
# =========================

reliabilitas <- alpha(item)

reliabilitas



# =========================
# NILAI CRONBACH ALPHA
# =========================

reliabilitas$total$raw_alpha



# =========================
# TABEL RELIABILITAS
# =========================

hasil_reliabilitas <- data.frame(
  Cronbach_Alpha = reliabilitas$total$raw_alpha
)

hasil_reliabilitas$Keterangan <- ifelse(
  hasil_reliabilitas$Cronbach_Alpha > 0.60,
  "Reliabel",
  "Tidak Reliabel"
)

hasil_reliabilitas