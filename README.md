# Sharpsell Store

A Flutter e-commerce application with clean architecture.

## Features

- Home screen with search bar, category carousel, and product grid
- Product detail screen with image, description, price, and related products
- Cart screen with item list, bill details breakdown, and payment button
- Product list screen filtered by category

## Architecture

This project follows clean architecture principles with the following layers:

- **Domain**: Contains business logic, entities, and repository interfaces
- **Data**: Implements repositories and contains data sources (remote API and local storage)
- **Presentation**: Contains UI components, screens, and state management

## Getting Started

### Prerequisites

- Flutter SDK (3.3.0 or higher)
- Android Studio / VS Code
- Android Emulator / iOS Simulator

### Installation

1. Clone the repository:
```
git clone https://github.com/yourusername/sharpsell_store.git
```

2. Navigate to the project directory:
```
cd sharpsell_store
```

3. Install dependencies:
```
flutter pub get
```

4. Run the app:
```
flutter run
```

## Running on Android

To run the app on an Android emulator:

1. Start your Android emulator
2. Run the following command:
```
flutter run -d <emulator-id>
```

## Dependencies

- **Provider**: State management
- **http**: Network requests
- **shared_preferences**: Local storage
- **cached_network_image**: Image caching
- **get_it**: Dependency injection

## API Integration

The app uses [FakeStoreAPI](https://fakestoreapi.com/) for demo purposes. In a production environment, you would replace this with your actual API endpoints.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
