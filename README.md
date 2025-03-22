# 🚀 Chrome VNC Server - Docker Image  

This Docker image runs **Google Chrome** inside a **VNC Server** using **Xvfb**, allowing remote access via VNC.  

## ✨ Features
- ✅ **Google Chrome** in full-screen mode  
- ✅ **VNC support** for remote access  
- ✅ **Ubuntu 22.04** base image  
- ✅ **Optimized for headless operation**  
- ✅ **No window manager (prevent resizing/minimizing)**  

---

## 🛠 How to Use  

### **Pull the Image**  
```bash
docker pull motallebialiakbar/chrome-vnc:latest
```

### **Run the Container**  
```bash
docker run -p 5900:5900 -e SCREEN_WIDTH=1920 -e SCREEN_HEIGHT=1080 motallebialiakbar/chrome-vnc:latest
```
