 # agtech-saas/README.md

# 🌾 AgTech SaaS Platform - Türkiye Tarım Teknolojisi

Türkiye'nin en kapsamlı tarım teknolojisi SaaS platformu. Çiftçilere akıllı tarım çözümleri sunan, IoT sensörler, AI destekli hastalık tespiti ve pazar entegrasyonu sağlayan modern bir platform.

## 🚀 Hızlı Başlangıç

### Gereksinimler
- Docker Desktop (v20.10+)
- Docker Compose (v2.0+)
- Git

### Kurulum

1. **Projeyi klonlayın:**
```bash
git clone https://github.com/yourusername/agtech-saas.git
cd agtech-saas
```

2. **Environment dosyasını oluşturun:**
```bash
cp .env.example .env
# .env dosyasını düzenleyip gerekli API key'lerini ekleyin
```

3. **Docker container'ları başlatın:**
```bash
docker-compose up -d
```

4. **Database migration'ları çalıştırın:**
```bash
docker-compose exec api npm run migrate
docker-compose exec api npm run seed
```

## 🔗 Erişim Adresleri

- **Web Uygulaması:** http://localhost
- **API:** http://localhost/api
- **AI Service:** http://localhost/ai
- **Adminer (DB Yönetimi):** http://localhost:8080
- **RabbitMQ Management:** http://localhost:15672
- **InfluxDB:** http://localhost:8086

## 📁 Proje Yapısı

```
agtech-saas/
├── api/                 # Node.js Backend API
├── web/                 # React Frontend
├── ai-service/          # Python AI Service
├── mobile/             # React Native App
├── nginx/              # Reverse Proxy
├── scripts/            # Utility Scripts
└── docker-compose.yml  # Docker Orchestration
```

## 🛠️ Teknoloji Stack

### Backend
- **Node.js + Express + TypeScript** - Ana API
- **PostgreSQL** - Ana veritabanı
- **Redis** - Cache ve session yönetimi
- **MongoDB** - Log ve doküman saklama
- **InfluxDB** - IoT sensör verileri
- **Socket.io** - Real-time iletişim
- **Bull + RabbitMQ** - Task queue

### Frontend
- **React 18 + TypeScript** - Web uygulaması
- **Tailwind CSS** - Styling
- **Redux Toolkit** - State yönetimi
- **React Query** - Data fetching
- **Chart.js & Recharts** - Grafikler
- **Leaflet** - Harita görselleştirme

### AI Service
- **FastAPI + Python** - AI microservice
- **TensorFlow** - Hastalık tespiti
- **Scikit-learn** - Tahmin modelleri
- **Transformers** - Türkçe NLP

## 📱 Özellikler

### Çekirdek Özellikler
- ✅ Çiftlik yönetimi ve arazi haritalama
- ✅ Maliyet optimizasyonu ve kar-zarar analizi
- ✅ Hava durumu entegrasyonu ve uyarılar
- ✅ Pazar fiyat takibi (Hal, TMO)
- ✅ Devlet destekleri ve sigorta yönetimi

### Gelişmiş Özellikler
- 🤖 AI destekli hastalık tespiti
- 📊 Verim tahmin modelleri
- 🌡️ IoT sensör entegrasyonu
- 💬 Türkçe tarım chatbot
- 📱 WhatsApp entegrasyonu

## 🧪 Test

```bash
# Backend testleri
docker-compose exec api npm test

# Frontend testleri
docker-compose exec web npm test

# AI service testleri
docker-compose exec ai-service pytest
```

## 📚 API Dokümantasyonu

API dokümantasyonuna http://localhost/api/docs adresinden ulaşabilirsiniz.

## 🚀 Production Deployment

Production ortamı için:

1. `.env` dosyasını production değerleriyle güncelleyin
2. SSL sertifikalarını `nginx/ssl/` klasörüne ekleyin
3. `docker-compose.prod.yml` dosyasını kullanın:

```bash
docker-compose -f docker-compose.prod.yml up -d
```

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit'leyin (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## 📞 İletişim

- Email: info@agtech.com.tr
- Website: https://agtech.com.tr
- Support: https://support.agtech.com.tr

---

🌾 **Türkiye'nin dijital tarım devrimi için birlikte çalışalım!** 🚜