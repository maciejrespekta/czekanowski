# Jan Czekanowski’s 1905 Expedition Map  

This repository contains a Shiny application that visualizes the journey of Polish anthropologist **Jan Czekanowski** during his 1905 expedition in East Africa.  

Czekanowski was among the first Europeans to take **photographs in Rwanda** (1905), many of which are preserved today at the **Richard Kandt House Museum in Kigali**. His detailed **fieldwork diary** provides an extraordinary record of his anthropological and ethnographic observations.  

Using entries from his diary, this project maps his journey **point by point**, allowing users to explore the route interactively. The application overlays his field notes with modern geographic data, creating a digital re-tracing of his path.  

---

## 📖 Background  

The expedition diary has been published as:  

**Bar, Joanna, and Michał Tymowski (eds.).**  
*Jan Czekanowski: Tagebuch der anthropologisch-ethnologischen Kolonne der Zentralafrikaexpedition in den Jahren 1907–1909 = Jan Czekanowski: Dziennik kolumny antropologiczno-etnologicznej ekspedycji do Afryki Środkowej w latach 1907–1909.*  
Polska Akademia Umiejętności, 2023.  

This publication provided the basis for the data points and travel stages mapped in the application.  

---

## 🗺️ Features  

- Interactive **Leaflet map** with multiple base layers (OpenStreetMap, Esri, CartoDB, OpenTopoMap).  
- **Markers** for key diary entries with names and dates.  
- **Great-circle polylines** connecting the travel route segments.  
- Simple, clean design optimized for full-screen exploration.  

---

## 📂 Data  

The application uses a dataset (`Jan_Czekanowski.csv`) that contains:  
- **Date** of the diary entry (`Data`)  
- **Location name** (`Nazwa`)  
- **GPS coordinates** (`latitude`, `longitude`)  

These were transcribed, cleaned, and geolocated from Czekanowski’s published diary notes.  

---

## ✨ Credits  

- **Expedition Diary**  
  Jan Czekanowski’s field notes (1905), published by:  
  Bar, Joanna, and Michał Tymowski (eds.).  
  *Jan Czekanowski: Tagebuch der anthropologisch-ethnologischen Kolonne der Zentralafrikaexpedition in den Jahren 1907–1909 = Jan Czekanowski: Dziennik kolumny antropologiczno-etnologicznej ekspedycji do Afryki Środkowej w latach 1907–1909.*  
  Polska Akademia Umiejętności, 2023.  


- **Digitization and Mapping**  
  Dataset preparation, transcription of diary entries, geolocation, and interactive map development by **Maciej Respekta (2025)**.  

---
