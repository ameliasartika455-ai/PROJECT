# TUGAS-2
 Analisis Tingkat Kepuasan Mahasiswa Terhadap Penggunaan Zoom Meeting Dalam perkuliahan daring di FMIPA Universitas Mataram
 
# Latar Belakang

Perkembangan teknologi informasi memberikan pengaruh besar terhadap sistem pembelajaran di perguruan tinggi. Salah satu bentuk pemanfaatan teknologi dalam dunia pendidikan adalah penggunaan media pembelajaran daring seperti Zoom Meeting. Aplikasi Zoom Meeting banyak digunakan sebagai media pembelajaran karena mampu memfasilitasi komunikasi secara virtual antara dosen dan mahasiswa selama proses perkuliahan berlangsung.

Penggunaan Zoom Meeting dalam perkuliahan daring tentunya memberikan pengalaman yang berbeda bagi setiap mahasiswa. Beberapa mahasiswa merasa terbantu karena proses pembelajaran dapat dilakukan secara fleksibel, namun terdapat pula kendala seperti kualitas jaringan internet, keterbatasan interaksi, dan tingkat konsentrasi selama perkuliahan daring berlangsung. Oleh karena itu, diperlukan evaluasi untuk mengetahui tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam proses pembelajaran daring.

FMIPA Universitas Mataram merupakan salah satu fakultas yang memanfaatkan Zoom Meeting sebagai media pembelajaran daring. Untuk mengetahui bagaimana tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting, dilakukan survei online menggunakan Google Form. Penelitian ini menggunakan teknik non probability sampling dengan metode convenience sampling karena pengambilan responden dilakukan berdasarkan kemudahan peneliti dalam memperoleh data.


# Tujuan

Penelitian ini bertujuan untuk:

1. Mengetahui tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam perkuliahan daring di FMIPA Universitas Mataram.
2. Menentukan jumlah sampel penelitian menggunakan rumus slovin.
3. menguji validitas dan reliabilitas instrumen kusioner yang digunakan dalam penelitian. 


# Metode Penelitian

Penelitian ini menggunakan metode kuantitatif dengan pendekatan survei online. Data diperoleh melalui penyebaran kuesioner menggunakan Google Form kepada mahasiswa FMIPA Universitas Mataram. Teknik sampling yang digunakan adalah non probability sampling dengan metode convenience sampling, yaitu teknik pengambilan sampel berdasarkan kemudahan peneliti dalam memperoleh responden yang sesuai dengan penelitian. Jumlah responden yang digunakan dalam penelitian ini sebanyak 30 mahasiswa. Pengolahan data dilakukan menggunakan bahasa pemrograman R.


# Langkah-Langkah Analisis Data

## 1. Perhitungan Jumlah Sampel (Slovin) 
Tahap ini dilakukan untuk menentukan jumlah sampel penelitian menggunakan rumus Slovin. Rumus Slovin digunakan untuk menentukan ukuran sampel berdasarkan jumlah populasi dan tingkat kesalahan tertentu sehingga sampel yang diperoleh dapat mewakili populasi penelitian.
```r
N <- 1880
e <- 0.19

n <- N / (1 + N * e^2)

n
ceiling(n)
```

## 2. Memanggil Library dan Membaca Data

Tahap ini dilakukan untuk memanggil package yang digunakan dalam pengolahan data serta membaca data hasil survei yang akan dianalisis.
```r
library(readxl)
library(psych)
data <- read_excel("C:/Users/Lenovo T480s/Downloads/DATA KUSIONER ZOOM MEETING (2).xlsx")

View(data)
```

## 3. Uji Validitas

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
## 4. Uji Reliabilitas

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

# Hasil dan Pembahasan

## Slovin

### Tabel Slovin

| Keterangan | Nilai |
|---|---|
| Hasil Perhitungan Slovin | 27.2986 |
| Jumlah Sampel | 28 Responden |

Penentuan jumlah sampel dalam penelitian ini dilakukan menggunakan rumus Slovin dengan tingkat kesalahan sebesar 19%. Berdasarkan hasil perhitungan diperoleh jumlah sampel sebesar 27.2986 yang kemudian dibulatkan menjadi 28 responden. Jumlah sampel tersebut dianggap mampu mewakili populasi mahasiswa FMIPA Universitas Mataram dalam penelitian mengenai tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam perkuliahan daring.

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

# Kesimpulan

Berdasarkan hasil penelitian yang telah dilakukan, seluruh item pernyataan pada kuesioner dinyatakan valid karena memiliki nilai r hitung yang lebih besar dibandingkan nilai r tabel. Hasil uji reliabilitas juga menunjukkan bahwa instrumen penelitian memiliki nilai Cronbach Alpha sebesar 0,852 sehingga dinyatakan reliabel dan memiliki tingkat konsistensi yang baik.

Dengan demikian, kuesioner penelitian layak digunakan untuk mengukur tingkat kepuasan mahasiswa terhadap penggunaan Zoom Meeting dalam perkuliahan daring di FMIPA Universitas Mataram.

---

# Link Kuesioner
https://forms.gle/dxw7pMtRU38jaauE7



