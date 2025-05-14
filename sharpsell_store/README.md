# Sharpsell Store

A Flutter e-commerce application with clean architecture.

## Features

- **Home Screen**: Displays categories and products with a search bar
- **Product List Screen**: Shows products for a selected category
- **Product Details Screen**: Shows detailed information about a product and similar products
- **Cart Screen**: Displays added items with bill details

## Architecture

This project follows the Clean Architecture principles with the following layers:

- **Domain Layer**: Contains business logic, entities, and use cases
- **Data Layer**: Implements repositories and data sources
- **Presentation Layer**: Contains UI components and BLoC for state management

## Project Structure

```
lib/
├── core/
│   ├── error/
│   ├── network/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── product_details/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── product_list/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── cart/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── injection_container.dart
```

## Technologies Used

- **Flutter**: UI framework
- **Bloc**: State management
- **Get_it**: Dependency injection
- **Dartz**: Functional programming
- **Dio**: HTTP client
- **Shared Preferences**: Local storage
- **Cached Network Image**: Image caching

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Screenshots

The application includes the following screens:
- Home Screen
- Product Details Screen
- Cart Screen
- Product List Screen

## License

This project is licensed under the MIT License - see the LICENSE file for details.
