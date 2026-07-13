# 🟢 Nvidia GPU Sales & Market Dynamics Analysis

## 📌 Project Overview
Proyek ini merupakan analisis *end-to-end* mengenai performa penjualan dan dinamika pasar GPU Nvidia menggunakan *dataset* transaksi sintetis. Tujuannya adalah untuk menggali *insight* terkait sumber pendapatan, segmentasi pelanggan, dominasi wilayah, serta dampak anomali pasar (seperti praktik calo/ *scalping*) terhadap tingkat kepuasan pelanggan (CSAT). 

## 🗂️ Dataset & Pipeline
Proyek ini tidak hanya menganalisis data, tetapi juga membangun *pipeline* datanya dari awal:
1. **Data Generation:** Membangun data sintetis yang realistis menggunakan skrip Python (`generate_data.py`).
2. **Data Cleaning & EDA:** Melakukan pembersihan data, penanganan *missing values*, dan *Exploratory Data Analysis* menggunakan Jupyter Notebook (`NvidiaGpuSales.ipynb`).
3. **Data Analysis:** Melakukan ekstraksi *insight* bisnis mendalam menggunakan 10 *query* PostgreSQL (`Nvidia_GPUSales.sql`).
4. **Data Visualization:** Membangun *interactive dashboard* menggunakan Power BI (`NvidiaGpuSales.pbix`).

## 🛠️ Tech Stack
* **Language:** Python, SQL
* **Database:** PostgreSQL
* **Visualization:** Power BI
* **Libraries:** Pandas, NumPy, Faker

## 📊 Dashboard Visualization
<img width="662" height="368" alt="image" src="https://github.com/user-attachments/assets/45a128bf-6440-4897-bf30-9e02ab08eb8e" />

Dashboard interaktif di atas berfokus pada ringkasan eksekutif untuk memantau dinamika pasar utama, termasuk Total Pendapatan, performa Lini GPU, sentimen pasar terhadap harga calo, dan 5 Model GPU Terlaris.

## 💡 Key Business Recommendations
Berdasarkan temuan data dan *query* SQL, berikut adalah rekomendasi strategis untuk perusahaan:

1. **Intervensi Praktik Calo (*Scalping Mitigation*):** Segera implementasikan sistem antrean *Direct-to-Consumer* (D2C). Data menunjukkan harga GPU di pasar membengkak hingga **15.01% (*Avg Scalping Premium*)**. Transaksi dalam kategori *"Heavy Scalping"* terbukti menghancurkan Kepuasan Pelanggan (CSAT) dari skor ideal **~4.5** merosot ke **< 4.0**.
2. **Optimalisasi Inventaris Global:** Prioritaskan **Asia-Pacific** dan **North America** sebagai tulang punggung utama yang menyumbang pendapatan terbesar (Total **$396.06 Juta**). Amankan minimal 60% pasokan inventaris untuk kedua *region* ini.
3. **Strategi *Volume vs. Margin*:** Meskipun ekosistem *Data Center AI* mencetak cuan masif, perusahaan tidak boleh mengabaikan stok *Consumer Gaming*. Sebanyak **151.72 Ribu unit** terjual didominasi oleh seri *mid-to-high* (RTX 5070 & RTX 4070 Ti Super).
4. **Pemangkasan Rasio *Backorder*:** Keterlambatan barang (*Backordered*) yang dikombinasikan dengan harga calo adalah pemicu ganda anjloknya kepuasan pelanggan. Memastikan status barang *"In Stock"* pada Top 5 GPU adalah kunci retensi pembeli.

## 🚀 How to Run This Project

**1. Menjalankan Analisis SQL**
* Unduh file dataset mentah (`nvidia_gpu_sales_synthetic_2026_RAW.csv`) dan data bersih (`nvidia_gpu_sales.csv`).
* Buka file `Nvidia_GPUSales.sql` di SQL Client Anda (misal: pgAdmin/DBeaver).
* Sesuaikan *file path* pada perintah `COPY` agar mengarah ke lokasi folder tempat Anda menyimpan file `nvidia_gpu_sales.csv`.
* Jalankan instruksi *Create Table* dan *10 Business Queries*.

**2. Membuka Dashboard Power BI**
* Unduh file `NvidiaGpuSales.pbix` dan letakkan dalam satu folder dengan `nvidia_gpu_sales.csv`.
* Buka file `.pbix` menggunakan Power BI Desktop.
* Jika terjadi *error* jalur data, klik **Transform Data > Data Source Settings > Change Source**, lalu arahkan kembali ke file CSV yang telah Anda unduh.
* Klik **Close & Apply**.

---
*Created by [Faiz-Aturr] - Let's connect on [LinkedIn](TBA)!*
