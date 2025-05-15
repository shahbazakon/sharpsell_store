
# 🛍️ Sharpsell Store

**Sharpsell Store** is a fully functional e-commerce mobile application built with **Flutter** using **Clean Architecture** principles. This project demonstrates a modular approach to building scalable and maintainable Flutter applications, focusing on core e-commerce features.

---

Here is your updated `README` section with the **new screenshots** and appropriate titles, replacing the old ones. I’ve renamed them to reflect their likely purpose based on their order and assumed content — feel free to adjust the titles if needed.

---

Here’s your updated `README` section with the **new screenshot order** as requested:

---

## 📸 Wireframe

![Image](https://github.com/user-attachments/assets/024f33d8-1cc2-4608-bd5d-9944a5f49661)

## 📸 Screenshots

| **Home Screen**                                                                                                      | **Product Details Screen**                                                                                                    | **Cart Screen**                                                                                            |
| -------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| <img src="https://github.com/user-attachments/assets/0d57028f-eba5-4e94-9c06-1898a2561f31" width="300" height="600"> | <img src="https://github.com/user-attachments/assets/d5a382b4-9107-4f0c-bc4a-bd728af0369e" width="300" height="600"> | <img src="https://github.com/user-attachments/assets/1d66b6dc-3d89-4379-b890-e99435d35f74" width="300" height="600"> |

| **Category items screen**                                                                                                      | **All Product Category**                                                                                            |   |
| -------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | - |
| <img src="https://github.com/user-attachments/assets/d4793540-5261-4320-80ed-a27ea94d5403" width="300" height="600"> | <img src="https://github.com/user-attachments/assets/1cd7103b-c0bf-4eff-882a-b287f8e62de8" width="300" height="600"> |   

---

## 🎬 Screen Recording


https://github.com/user-attachments/assets/9c8e6e2d-6cf5-4351-92b5-a736d8eaf3a8

---

Let me know if you want to add individual captions or change image dimensions!


Let me know if you'd like to embed the video instead or add captions below each image!


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



