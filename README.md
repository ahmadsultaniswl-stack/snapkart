# SnapKart 🛒 — Flutter E-Commerce App

A full-featured e-commerce mobile app built independently in Flutter, with a complete Firebase backend — from authentication to real-time order tracking.

<!--
📸 SCREENSHOT INSTRUCTIONS (delete this comment block once done):
1. Take screenshots from your phone (Home, Product Detail, Cart, Checkout, Order Tracking, Profile/Theme toggle — 4 to 6 screens is enough).
2. Drag-and-drop the images directly into this README file while editing it on GitHub (GitHub auto-uploads and inserts the markdown for you), OR
3. Create a folder named "screenshots" in your repo, upload images there, then reference them like: ![Home Screen](screenshots/home.png)
4. Replace the placeholder row below with your real images.
-->

## 📱 Screenshots

| Splash Screen | Home | Product Detail | Cart |
|----------------|------|-----------------|------|
|<img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 10 43 40 PM" src="https://github.com/user-attachments/assets/8d448dbc-f637-44c6-b0df-9c8eefce39d7" /> | <img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 10 47 00 PM" src="https://github.com/user-attachments/assets/e6e1e8b8-cbb9-4146-a2ef-96a289292a8c" /> | <img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 10 49 01 PM" src="https://github.com/user-attachments/assets/4e5d32b7-8a5c-4e28-ae4c-548f8f3370c4" /> | <img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 11 46 40 PM" src="https://github.com/user-attachments/assets/d5d387fd-797d-4b6f-8a43-50f645dfe783" /> |

| Checkout | Order Tracking | Bilingual (EN/UR) | Dark Mode |
|----------|-----------------|--------------------|-----------|
| <img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 10 47 46 PM" src="https://github.com/user-attachments/assets/b7e8f2c7-131f-4237-8f44-913aeb36df51" /> | <img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 10 50 11 PM" src="https://github.com/user-attachments/assets/e054d2d9-aed4-4c78-a3aa-d0429e08e746" /> | <img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 11 58 34 PM" src="https://github.com/user-attachments/assets/c818c2ca-05c5-4455-9a9e-780a100b562f" /> | <img width="576" height="1280" alt="WhatsApp Image 2026-09-09 at 11 58 28 PM" src="https://github.com/user-attachments/assets/c980c44d-c9ba-4de7-9146-7084e84e5b0a" /> |

---

## ✨ Features

- 🔐 **Authentication** — Email/Password + Google Sign-In via Firebase Auth
- 🔍 **Product search** — search across categories with instant results
- 🛍️ **Full shopping flow** — catalog, product details, cart, wishlist, checkout
- 📦 **Real-time order tracking** — Firestore snapshot listeners update order status live
- 💳 **Four payment methods** at checkout
- 🔔 **Push & local notifications** via Firebase Cloud Messaging (FCM)
- 🌐 **Bilingual UI** — full English/Urdu localization across 16+ screens
- 🌗 **Light/Dark theming** — persistent across sessions
- 📍 **Address management** — save and manage multiple delivery addresses
- 🗂️ **Order history** — view past orders and re-order easily

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter, Dart |
| State Management | GetX (reactive UI with Obx, DI, routing) |
| Backend | Firebase (Firestore, Auth, FCM) |
| Local Storage | SharedPreferences |
| Media | Cloudinary |

---

## 🏗️ Architecture Highlights

- Clean, reusable GetX controllers shared across 16+ screens
- Real-time Firestore listeners for both order tracking and admin-side inventory sync (see companion [SnapKart Admin Panel](https://github.com/ahmadsultaniswl-stack/snapkart-admin-panel))
- One-time custom migration script to move the product catalog from a public REST API into Firestore
- Firebase Security Rules configured for role-based data access

---

## 🚀 Getting Started

```bash
# Clone the repo
git clone https://github.com/ahmadsultaniswl-stack/snapkart.git
cd snapkart

# Install dependencies
flutter pub get

# Run the app
flutter run
```

> Note: You'll need to connect your own Firebase project (Auth, Firestore, FCM enabled) and add your `google-services.json` / `GoogleService-Info.plist` before running.

---

## 👤 Author

**Saie Ahmad**
Flutter Mobile App Developer
📧 ahmadsultaniswl@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/saie-ahmad)
