# PROJECT
 Analisis Tingkat Kepuasan Mahasiswa Terhadap Penggunaan Zoom Meeting Dalam perkuliahan daring di FMIPA Universitas Mataram
 
# Latar Belakang

Perkembangan teknologi informasi memberikan pengaruh besar terhadap sistem pembelajaran di perguruan tinggi. Salah satu bentuk pemanfaatan teknologi dalam dunia pendidikan adalah penggunaan media pembelajaran daring seperti Zoom Meeting. Aplikasi Zoom Meeting banyak digunakan sebagai media pembelajaran karena mampu memfasilitasi komunikasi secara virtual antara dosen dan mahasiswa selama proses perkuliahan berlangsung.

Penggunaan Zoom Meeting dalam perkuliahan daring tentunya memberikan pengalaman yang berbeda bagi setiap mahasiswa. Beberapa mahasiswa merasa terbantu karena proses pembelajaran dapat dilakukan secara fleksibel, namun terdapat pula kendala seperti kualitas jaringan internet, keterbatasan interaksi, dan tingkat konsentrasi selama perkuliahan daring berlangsung. Oleh karena itu, diperlukan evaluasi untuk mengetahui tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam proses pembelajaran daring.

FMIPA Universitas Mataram merupakan salah satu fakultas yang memanfaatkan Zoom Meeting sebagai media pembelajaran daring. Untuk mengetahui bagaimana tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting, dilakukan survei online menggunakan Google Form. Penelitian ini menggunakan teknik non probability sampling dengan metode convenience sampling karena pengambilan responden dilakukan berdasarkan kemudahan peneliti dalam memperoleh data.


# Tujuan

Penelitian ini bertujuan untuk menganalisis tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam perkuliahan daring di FMIPA Universitas Mataram melalui distribusi responden berdasarkan program studi, pengukuran statistik deskriptif, pengujian validitas dan reliabilitas instrumen kuesioner, serta perbandingan hasil estimasi kepuasan menggunakan metode *naive estimation* dan *weighted estimation*.


# Metode Penelitian

Penelitian ini menggunakan metode kuantitatif dengan pendekatan survei online. Data diperoleh melalui penyebaran kuesioner menggunakan Google Form kepada mahasiswa FMIPA Universitas Mataram. Teknik sampling yang digunakan adalah non probability sampling dengan metode convenience sampling, yaitu teknik pengambilan sampel berdasarkan kemudahan peneliti dalam memperoleh responden yang sesuai dengan penelitian. Jumlah responden yang digunakan dalam penelitian ini sebanyak 30 mahasiswa. Pengolahan data dilakukan menggunakan bahasa pemrograman R.


# Langkah-Langkah Analisis Data

## 1. Memanggil Library dan Membaca Data

Tahap ini dilakukan untuk memanggil package yang digunakan dalam pengolahan data serta membaca data hasil survei yang akan dianalisis.
```r
library(readxl)
library(psych)
data <- read_excel("C:/Users/Lenovo T480s/Downloads/DATA KUSIONER ZOOM MEETING (2).xlsx")

View(data)
```

## 2. Perhitungan Jumlah Sampel (Slovin) 

Tahap ini dilakukan untuk menentukan jumlah sampel penelitian menggunakan rumus Slovin. Rumus Slovin digunakan untuk menentukan ukuran sampel berdasarkan jumlah populasi dan tingkat kesalahan tertentu sehingga sampel yang diperoleh dapat mewakili populasi penelitian.
```r
N <- 1880
e <- 0.19

n <- N / (1 + N * e^2)

n
ceiling(n)
```
## 3. Distribusi Responden Berdasarkan Program Studi

Analisis distribusi responden berdasarkan program studi bertujuan untuk mengetahui sebaran mahasiswa yang menjadi sampel dalam penelitian. Hal ini penting agar dapat dilihat apakah responden sudah tersebar secara merata atau didominasi oleh program studi tertentu.
### Barplot 
```r
barplot(
  table(data$`Program Studi`),
  main = "Distribusi Responden Berdasarkan Program Studi",
  xlab = "Program Studi",
  ylab = "Frekuensi"
)
```
### Pie Chart 
```r
pie(
  table(data$`Program Studi`),
  main = "Persentase Responden Berdasarkan Program Studi"
)
```

## 4. Statistik Deskriptif

Statistik deskriptif digunakan untuk memberikan gambaran umum mengenai data skor total kepuasan mahasiswa terhadap penggunaan Zoom Meeting. Skor total diperoleh dari penjumlahan seluruh item pertanyaan P1 hingga P10.

## Perhitungan Skor Total

```r
data$TOTAL <- data$P1 + data$P2 + data$P3 + data$P4 + data$P5 +
  data$P6 + data$P7 + data$P8 + data$P9 + data$P10
summary(data$TOTAL)
mean(data$TOTAL)
sd(data$TOTAL)
min(data$TOTAL)
max(data$TOTAL)
```

## 5. Uji Validitas

Tahap ini dilakukan untuk mengetahui apakah setiap item pernyataan pada kuesioner mampu mengukur variabel penelitian dengan baik. Uji validitas dilakukan menggunakan korelasi item-total, yaitu menghitung hubungan antara setiap item pertanyaan dengan skor total responden.

Tahap berikut digunakan untuk mengambil item-item pertanyaan yang akan diuji validitasnya.

```r
item <- data[, c("P1","P2","P3","P4","P5",
                 "P6","P7","P8","P9","P10")]
```

Tahap berikut digunakan untuk menghitung skor total setiap responden.

```r
total <- rowSums(item)

total
```

Tahap berikut digunakan untuk menghitung korelasi antara setiap item dengan skor total.

```r
validitas <- cor(item, total)

validitas
```

Tahap berikut digunakan untuk membuat tabel hasil uji validitas.

```r
# n = 30
# df = n - 2 = 28
# alpha = 0.05
# r tabel = 0.361

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
```
## 6. Uji Reliabilitas

Tahap ini dilakukan untuk mengetahui tingkat konsistensi item-item pertanyaan pada kuesioner. Uji reliabilitas dilakukan menggunakan metode Cronbach Alpha. Semakin tinggi nilai Cronbach Alpha maka semakin baik tingkat reliabilitas instrumen penelitian.

Tahap berikut digunakan untuk menghitung nilai reliabilitas kuesioner.

```r
reliabilitas <- alpha(item)

reliabilitas
```

Tahap berikut digunakan untuk menampilkan nilai Cronbach Alpha.

```r
reliabilitas$total$raw_alpha
```

Tahap berikut digunakan untuk membuat tabel hasil uji reliabilitas.

```r
hasil_reliabilitas <- data.frame(
  Cronbach_Alpha = reliabilitas$total$raw_alpha
)

hasil_reliabilitas$Keterangan <- ifelse(
  hasil_reliabilitas$Cronbach_Alpha > 0.60,
  "Reliabel",
  "Tidak Reliabel"
)

hasil_reliabilitas
```
---

## 7. Naive Estimation

Naive estimation digunakan untuk menghitung estimasi proporsi secara langsung berdasarkan jumlah responden yang memberikan respon positif terhadap penggunaan Zoom Meeting dalam perkuliahan daring
```r
x <- 28

n <- 30

p_hat <- x/n

p_hat

p_hat * 100
```

## 8. Weighted Estimation

Weighting sederhana dilakukan untuk menyesuaikan distribusi sampel dengan distribusi populasi menggunakan rumus: wi = Proporsi Populasi / Proporsi Sampel

Metode weighting digunakan untuk mengurangi bias akibat perbedaan distribusi responden dengan populasi sebenarnya. 
```r
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

# Proporsi Populasi dan Sampel
prop_pop <- pop / sum(pop)
prop_sampel <- sampel / sum(sampel)

weight <- prop_pop / prop_sampel
weight

# Responden Puas per Program Studi 
puas_per_prodi <- c(
  matematika = 2,
  kimia = 5,
  fisika = 2,
  biologi = 4,
  lingkungan = 5,
  statistika = 12
)

# Weighted Estimation
p_hat_weighted_final <- sum(
  (puas_per_prodi / sampel) * prop_pop
)

p_hat_weighted_final
p_hat_weighted_final * 100

```

## 9. Grafik Perbandingan Estimasi

Grafik perbandingan estimasi digunakan untuk membandingkan hasil naive estimation dan weighted estimation terhadap tingkat kepuasan mahasiswa dalam penggunaan Zoom Meeting.
```r
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

```
---

# Hasil dan Pembahasan

## Slovin

### Tabel Slovin

| Keterangan | Nilai |
|---|---|
| Hasil Perhitungan Slovin | 27.2986 |
| Jumlah Sampel | 28 Responden |

Penentuan jumlah sampel dalam penelitian ini dilakukan menggunakan rumus Slovin dengan tingkat kesalahan sebesar 19%. Berdasarkan hasil perhitungan diperoleh jumlah sampel sebesar 27.2986 yang kemudian dibulatkan menjadi 28 responden. Jumlah sampel tersebut dianggap mampu mewakili populasi mahasiswa FMIPA Universitas Mataram dalam penelitian mengenai tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam perkuliahan daring.

---
# Distribusi Responden Berdasarkan Program Studi

## Tabel Frekuensi Program Studi

| Program Studi | Frekuensi | Persentase (%) |
|---|---|---|
| Biologi | 4 | 13.33 |
| Fisika | 2 | 6.67 |
| Ilmu Lingkungan | 5 | 16.67 |
| Kimia | 5 | 16.67 |
| Matematika | 2 | 6.67 |
| Statistika | 12 | 40.00 |
| **Total** | **30** | **100** |

Berdasarkan tabel di atas, responden terbanyak berasal dari Program Studi Statistika sebanyak 12 responden atau 40% dari total sampel. Sementara itu, jumlah responden paling sedikit berasal dari Program Studi Fisika dan Matematika yaitu masing-masing sebanyak 2 responden atau 6,67%.

## Grafik Batang

Grafik batang menunjukkan distribusi jumlah responden berdasarkan program studi. Tinggi batang pada Program Studi Statistika paling besar dibandingkan program studi lainnya, yang menandakan bahwa mayoritas responden berasal dari Program Studi Statistika.

<img width="1162" height="740" alt="image" src="https://github.com/user-attachments/assets/21a4b50f-d22b-44e8-942f-5a2383c3d839" />


## Pie Chart

Diagram lingkaran menunjukkan proporsi responden pada setiap program studi. Bagian terbesar pada diagram berasal dari Program Studi Statistika dengan persentase 40%, sedangkan bagian terkecil berasal dari Program Studi Fisika dan Matematika dengan persentase masing-masing sebesar 6,67%.

<img width="773" height="569" alt="image" src="https://github.com/user-attachments/assets/c1f4a5e6-ba78-446b-bf37-e462e40b3128" />


---

# Statistik Deskriptif Skor Total

Skor total diperoleh dari penjumlahan seluruh item P1–P10.

## Hasil Statistik Deskriptif

| Statistik | Nilai |
|---|---|
| Minimum | 26 |
| Kuartil 1 | 37 |
| Median | 40 |
| Mean | 38.5 |
| Kuartil 3 | 42 |
| Maksimum | 43 |
| Standar Deviasi | 4.313 |

Nilai rata-rata skor total responden sebesar 38,5 yang menunjukkan bahwa tingkat kepuasan responden terhadap Zoom Meeting tergolong tinggi. Nilai minimum sebesar 26 dan maksimum sebesar 43 menunjukkan adanya variasi jawaban antar responden. Standar deviasi sebesar 4,313 menunjukkan bahwa penyebaran data relatif kecil sehingga jawaban responden cukup homogen.

---

## Uji Validitas

### Tabel Validitas

| Item | r Hitung | r Tabel | Keterangan |
|---|---|---|---|
| P1 | 0,640 | 0,361 | Valid |
| P2 | 0,472 | 0,361 | Valid |
| P3 | 0,686 | 0,361 | Valid |
| P4 | 0,701 | 0,361 | Valid |
| P5 | 0,636 | 0,361 | Valid |
| P6 | 0,723 | 0,361 | Valid |
| P7 | 0,755 | 0,361 | Valid |
| P8 | 0,696 | 0,361 | Valid |
| P9 | 0,646 | 0,361 | Valid |
| P10 | 0,616 | 0,361 | Valid |

Berdasarkan hasil uji validitas menggunakan korelasi Pearson terhadap 10 item pernyataan dengan jumlah responden sebanyak 30 orang, diperoleh nilai r hitung seluruh item lebih besar dibandingkan nilai r tabel sebesar 0,361. Hal tersebut menunjukkan bahwa seluruh item pernyataan pada kuesioner dinyatakan valid dan mampu mengukur variabel penelitian dengan baik.

---

## Uji Reliabilitas

### Tabel Reliabilitas

| Cronbach Alpha | Keterangan |
|---|---|
| 0,852 | Reliabel |

Berdasarkan hasil uji reliabilitas diperoleh nilai Cronbach Alpha sebesar 0,852. Nilai tersebut lebih besar dari 0,60 sehingga kuesioner dinyatakan reliabel. Hal ini menunjukkan bahwa seluruh item pernyataan pada kuesioner memiliki tingkat konsistensi yang baik dalam mengukur tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam perkuliahan daring.

---

# Naive Estimation

Estimasi sederhana dilakukan dengan menghitung proporsi responden puas terhadap total responden.

## Hasil Naive Estimation

| Keterangan | Nilai |
|---|---|
| Proporsi Kepuasan | 0.9333 |
| Persentase Kepuasan | 93.33% |

Hasil naive estimation menunjukkan bahwa sebesar 93,33% responden merasa puas terhadap penggunaan Zoom Meeting.

---

# Weighted Estimation

Weighted estimation dilakukan untuk memperoleh estimasi yang mempertimbangkan proporsi populasi masing-masing program studi.

## Bobot Tiap Program Studi

| Program Studi | Bobot |
|---|---|
| Matematika | 2.9138 |
| Kimia | 1.0569 |
| Fisika | 2.4827 |
| Biologi | 1.4329 |
| Ilmu Lingkungan | 1.1112 |
| Statistika | 0.2195 |

Bobot terbesar terdapat pada Program Studi Matematika dan Fisika karena jumlah sampel dari kedua program studi relatif kecil dibandingkan proporsi populasinya. Sebaliknya, Program Studi Statistika memiliki bobot terkecil karena jumlah sampelnya relatif lebih besar dibandingkan proporsi populasi.

---

## Hasil Weighted Estimation

| Metode Estimasi | Nilai | Persentase |
|---|---|---|
| Naive Estimation | 0.9333 | 93.33% |
| Weighted Estimation | 1.0000 | 100% |

Hasil weighted estimation sebesar 100% menunjukkan bahwa setelah mempertimbangkan bobot populasi tiap program studi, seluruh responden pada masing-masing strata dianggap puas terhadap Zoom Meeting. Nilai weighted estimation lebih tinggi dibandingkan naive estimation karena seluruh responden pada setiap program studi dikategorikan puas.

---

# Interpretasi Grafik Perbandingan Estimasi

Grafik perbandingan estimasi menunjukkan bahwa metode weighted estimation menghasilkan nilai kepuasan yang lebih tinggi dibandingkan naive estimation. Naive estimation menghasilkan tingkat kepuasan sebesar 93,33%, sedangkan weighted estimation menghasilkan tingkat kepuasan sebesar 100%. Hal ini menunjukkan bahwa pemberian bobot berdasarkan proporsi populasi dapat mempengaruhi hasil estimasi akhir.

<img width="1088" height="555" alt="image" src="https://github.com/user-attachments/assets/7d295361-768f-4b60-a6b9-b44f6715a565" />

---

# Kesimpulan

Berdasarkan hasil penelitian yang telah dilakukan, seluruh item pernyataan pada kuesioner dinyatakan valid karena memiliki nilai r hitung yang lebih besar dibandingkan nilai r tabel. Hasil uji reliabilitas juga menunjukkan bahwa instrumen penelitian memiliki nilai Cronbach Alpha sebesar 0,852 sehingga dinyatakan reliabel dan memiliki tingkat konsistensi yang baik.

Dengan demikian, kuesioner penelitian layak digunakan untuk mengukur tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam perkuliahan daring di FMIPA Universitas Mataram.

---

# Link Kuesioner
https://forms.gle/dxw7pMtRU38jaauE7



