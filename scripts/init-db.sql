 -- agtech-saas/scripts/init-db.sql

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Create custom types
CREATE TYPE user_role AS ENUM ('FARMER', 'COOPERATIVE_ADMIN', 'EXPERT', 'ADMIN');
CREATE TYPE crop_status AS ENUM ('PLANNED', 'PLANTED', 'GROWING', 'HARVESTED', 'FAILED');
CREATE TYPE expense_category AS ENUM ('SEED', 'FERTILIZER', 'PESTICIDE', 'FUEL', 'LABOR', 'MACHINERY', 'IRRIGATION', 'OTHER');
CREATE TYPE revenue_source AS ENUM ('CROP_SALE', 'SUBSIDY', 'OTHER');
CREATE TYPE device_type AS ENUM ('SOIL_MOISTURE', 'WEATHER_STATION', 'WATER_METER', 'CAMERA');
CREATE TYPE device_status AS ENUM ('ACTIVE', 'INACTIVE', 'MAINTENANCE');
CREATE TYPE severity AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');
CREATE TYPE detection_method AS ENUM ('MANUAL', 'AI_DETECTION', 'EXPERT_REVIEW');
CREATE TYPE report_status AS ENUM ('PENDING', 'CONFIRMED', 'TREATING', 'RESOLVED');
CREATE TYPE activity_type AS ENUM ('PLANTING', 'FERTILIZING', 'SPRAYING', 'IRRIGATING', 'HARVESTING', 'OTHER');
CREATE TYPE irrigation_method AS ENUM ('DRIP', 'SPRINKLER', 'SURFACE', 'CENTER_PIVOT');
CREATE TYPE inventory_type AS ENUM ('SEED', 'FERTILIZER', 'PESTICIDE', 'EQUIPMENT', 'OTHER');
CREATE TYPE notification_type AS ENUM ('WEATHER_ALERT', 'PRICE_UPDATE', 'DISEASE_DETECTION', 'TASK_REMINDER', 'SYSTEM');

-- Create indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_farms_user_id ON farms(user_id);
CREATE INDEX idx_fields_farm_id ON fields(farm_id);
CREATE INDEX idx_crops_field_id ON crops(field_id);
CREATE INDEX idx_sensor_readings_device_timestamp ON sensor_readings(device_id, timestamp);
CREATE INDEX idx_activities_date ON activities(date);
CREATE INDEX idx_notifications_user_created ON notifications(user_id, created_at);

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE agtech_db TO agtech_user;

-- Initial seed data for development
INSERT INTO users (id, email, phone, password, first_name, last_name, role) VALUES 
('clh1234567890abcdef', 'demo@agtech.com.tr', '+905551234567', '$2a$10$XKL3j7Y8JZ9K7PZr9jZWOuLEjKjHgK8JHgK8JHgK8JHgK8JHgK8JH', 'Demo', 'Kullanıcı', 'FARMER');

-- Success message
SELECT 'AgTech database başarıyla oluşturuldu!' as message;