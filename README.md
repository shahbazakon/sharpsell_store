
# 🛍️ Sharpsell Store

**Sharpsell Store** is a fully functional e-commerce mobile application built with **Flutter** using **Clean Architecture** principles. This project demonstrates a modular approach to building scalable and maintainable Flutter applications, focusing on core e-commerce features.

---

## 🚀 Features

* 🏠 **Home Screen**

  * Search bar
  * Category carousel
  * Featured product grid

* 📦 **Product Detail Screen**

  * Product images
  * Descriptions
  * Pricing
  * Related products

* 🛒 **Cart Screen**

  * Cart items list
  * Price breakdown and total
  * Payment button

* 📂 **Product List by Category**

  * Browse products filtered by category

---

## 🧱 Architecture

The project adheres to **Clean Architecture**, separating responsibilities into distinct layers:

* **Domain Layer**

  * Business logic
  * Entity definitions
  * Abstract repository contracts

* **Data Layer**

  * Repository implementations
  * Data sources (Remote API / Local Storage)

* **Presentation Layer**

  * UI components and screens
  * State management and user interaction

---

## 🛠️ Getting Started

### ✅ Prerequisites

* Flutter SDK **(>= 3.3.0)**
* Android Studio or Visual Studio Code
* Android Emulator / iOS Simulator

### 📥 Installation Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/sharpsell_store.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd sharpsell_store
   ```

3. **Install the dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

---

## 📱 Running on Android

To run the app on an Android emulator:

1. Start your Android emulator
2. Run the following command:

   ```bash
   flutter run -d <emulator-id>
   ```

---

## 📦 Dependencies

* [`provider`](https://pub.dev/packages/provider) – State management
* [`http`](https://pub.dev/packages/http) – REST API communication
* [`shared_preferences`](https://pub.dev/packages/shared_preferences) – Local storage
* [`cached_network_image`](https://pub.dev/packages/cached_network_image) – Efficient image loading and caching
* [`get_it`](https://pub.dev/packages/get_it) – Dependency injection

---

## 🌐 API Integration

The app currently uses [FakeStoreAPI](https://fakestoreapi.com/) for mock data during development. In a production environment, replace this with real API endpoints and secure authorization mechanisms.

---


