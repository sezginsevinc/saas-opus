 # agtech-saas/ai-service/main.py

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Import routers
from app.api import disease_detection, crop_prediction, chatbot, weather_analysis

# Lifespan context manager for startup/shutdown events
@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    print("🚀 AgTech AI Service başlatılıyor...")
    # Load ML models here
    yield
    # Shutdown
    print("🛑 AgTech AI Service kapatılıyor...")

# Create FastAPI app
app = FastAPI(
    title="AgTech AI Service",
    description="Türkiye Tarım Teknolojisi AI Servisi",
    version="1.0.0",
    lifespan=lifespan
)

# CORS configuration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Production'da güncelle
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Health check
@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "service": "AgTech AI Service",
        "version": "1.0.0"
    }

# Root endpoint
@app.get("/")
async def root():
    return {
        "message": "AgTech AI Service'e hoş geldiniz! 🤖",
        "endpoints": [
            "/disease-detection",
            "/crop-prediction",
            "/chatbot",
            "/weather-analysis"
        ]
    }

# Include routers
app.include_router(disease_detection.router, prefix="/disease-detection", tags=["Hastalık Tespiti"])
app.include_router(crop_prediction.router, prefix="/crop-prediction", tags=["Verim Tahmini"])
app.include_router(chatbot.router, prefix="/chatbot", tags=["Tarım Chatbot"])
app.include_router(weather_analysis.router, prefix="/weather-analysis", tags=["Hava Durumu Analizi"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)