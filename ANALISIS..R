
# =========================================
# MEMANGGIL LIBRARY
# =========================================

library(readxl)

install.packages("psych")

library(psych)



# =========================================
# IMPORT DATA
# =========================================

data <- read_excel("C:/Users/Lenovo T480s/Downloads/DATA KUSIONER ZOOM MEETING.xlsx")

View(data)



# =========================================
# MELIHAT NAMA VARIABEL
# =========================================

names(data)



# =========================================
# MENENTUKAN JUMLAH SAMPEL (SLOVIN)
# =========================================

N <- 1880
e <- 0.19

n <- N / (1 + N * e^2)

n

ceiling(n)



# =========================================
# TABEL FREKUENSI PROGRAM STUDI
# =========================================

table(data$`Program Studi`)



# =========================================
# PERSENTASE PROGRAM STUDI
# =========================================

prop.table(table(data$`Program Studi`)) * 100



# =========================================
# GRAFIK BATANG
# =========================================

barplot(
  table(data$`Program Studi`),
  main = "Distribusi Responden Berdasarkan Program Studi",
  xlab = "Program Studi",
  ylab = "Frekuensi"
)



# =========================================
# PIE CHART
# =========================================

pie(
  table(data$`Program Studi`),
  main = "Persentase Responden Berdasarkan Program Studi"
)



# =========================================
# MEMBUAT SKOR TOTAL
# =========================================

data$TOTAL <- data$P1 + data$P2 + data$P3 + data$P4 + data$P5 +
  data$P6 + data$P7 + data$P8 + data$P9 + data$P10



# =========================================
# STATISTIK DESKRIPTIF
# =========================================

summary(data$TOTAL)

mean(data$TOTAL)

sd(data$TOTAL)

min(data$TOTAL)

max(data$TOTAL)



# =========================================
# UJI VALIDITAS
# =========================================

# Membuat skor total


item <- data[, c("P1","P2","P3","P4","P5",
                 "P6","P7","P8","P9","P10")]

total <- rowSums(item)

total

validitas <- cor(item, total)

validitas

r_tabel <- 0.361

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


# =========================================
# UJI RELIABILITAS
# =========================================

reliabilitas <- alpha(item)

reliabilitas

reliabilitas$total$raw_alpha

hasil_reliabilitas <- data.frame(
  Cronbach_Alpha = reliabilitas$total$raw_alpha
)

hasil_reliabilitas$Keterangan <- ifelse(
  hasil_reliabilitas$Cronbach_Alpha > 0.60,
  "Reliabel",
  "Tidak Reliabel"
)

hasil_reliabilitas


# =========================================
# NAIVE ESTIMATION
# =========================================

x <- 28

n <- 30

p_hat <- x/n

p_hat

p_hat * 100



# =========================================
# WEIGHTED ESTIMATION
# =========================================

# Populasi per program studi

pop <- c(
  matematika = 365,
  kimia = 331,
  fisika = 311,
  biologi = 359,
  lingkungan = 348,
  statistika = 165
)



# Sampel per program studi

sampel <- c(
  matematika = 2,
  kimia = 5,
  fisika = 2,
  biologi = 4,
  lingkungan = 5,
  statistika = 12
)



# Proporsi populasi

prop_pop <- pop / sum(pop)



# Proporsi sampel

prop_sampel <- sampel / sum(sampel)



# Weighting

weight <- prop_pop / prop_sampel

weight



# =========================================
# JUMLAH RESPONDEN PUAS PER PRODI
# =========================================

puas_per_prodi <- c(
  matematika = 2,
  kimia = 5,
  fisika = 2,
  biologi = 4,
  lingkungan = 5,
  statistika = 12
)



# =========================================
# WEIGHTED ESTIMATION
# =========================================

p_hat_weighted_final <- sum(
  (puas_per_prodi / sampel) * prop_pop
)

print(p_hat_weighted_final)

print(p_hat_weighted_final * 100)



# =========================================
# GRAFIK PERBANDINGAN ESTIMASI
# =========================================

angka_grafik <- c(
  p_hat,
  p_hat_weighted_final
)

names(angka_grafik) <- c(
  "Naive",
  "Weighted"
)



barplot(
  angka_grafik,
  main = "Perbandingan Hasil Estimasi Kepuasan",
  col = c("skyblue", "orange"),
  ylim = c(0, 1.2),
  ylab = "Tingkat Kepuasan"
)



text(
  x = c(0.7, 1.9),
  y = angka_grafik,
  labels = round(angka_grafik, 3),
  pos = 3
)
