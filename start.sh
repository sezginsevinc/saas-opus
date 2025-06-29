 #!/bin/bash
# agtech-saas/start.sh - AgTech SaaS Başlangıç Script'i

echo "🌾 AgTech SaaS Platform Başlatılıyor..."

# Renkleri tanımla
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Docker'ın yüklü olup olmadığını kontrol et
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker yüklü değil! Lütfen Docker'ı yükleyin.${NC}"
    exit 1
fi

# Docker Compose'un yüklü olup olmadığını kontrol et
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose yüklü değil! Lütfen Docker Compose'u yükleyin.${NC}"
    exit 1
fi

# .env dosyasının var olup olmadığını kontrol et
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  .env dosyası bulunamadı. .env.example'dan kopyalanıyor...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✅ .env dosyası oluşturuldu. Lütfen düzenleyin!${NC}"
fi

# Eski container'ları durdur ve temizle
echo -e "${YELLOW}🔄 Eski container'lar temizleniyor...${NC}"
docker-compose down

# Docker image'ları build et
echo -e "${YELLOW}🏗️  Docker image'ları build ediliyor...${NC}"
docker-compose build

# Container'ları başlat
echo -e "${YELLOW}🚀 Container'lar başlatılıyor...${NC}"
docker-compose up -d

# Container'ların başlamasını bekle
echo -e "${YELLOW}⏳ Servisler başlatılıyor...${NC}"
sleep 10

# Database migration'ları çalıştır
echo -e "${YELLOW}📊 Database migration'ları çalıştırılıyor...${NC}"
docker-compose exec -T api npx prisma migrate deploy

# Seed data yükle (development ortamı için)
if [ "$1" == "--seed" ]; then
    echo -e "${YELLOW}🌱 Seed data yükleniyor...${NC}"
    docker-compose exec -T api npm run seed
fi

# Servislerin durumunu kontrol et
echo -e "\n${GREEN}✅ AgTech SaaS Platform başarıyla başlatıldı!${NC}\n"
echo -e "📍 Erişim Adresleri:"
echo -e "   🌐 Web Uygulaması: ${GREEN}http://localhost${NC}"
echo -e "   🔌 API: ${GREEN}http://localhost/api${NC}"
echo -e "   🤖 AI Service: ${GREEN}http://localhost/ai${NC}"
echo -e "   💾 Adminer (DB): ${GREEN}http://localhost:8080${NC}"
echo -e "   📊 RabbitMQ: ${GREEN}http://localhost:15672${NC}"
echo -e "   📈 InfluxDB: ${GREEN}http://localhost:8086${NC}"

echo -e "\n${YELLOW}💡 İpuçları:${NC}"
echo -e "   • Logları görmek için: ${GREEN}docker-compose logs -f${NC}"
echo -e "   • Durdurmak için: ${GREEN}docker-compose down${NC}"
echo -e "   • Seed data ile başlatmak için: ${GREEN}./start.sh --seed${NC}"

# Container durumlarını göster
echo -e "\n${YELLOW}📦 Container Durumları:${NC}"
docker-compose ps