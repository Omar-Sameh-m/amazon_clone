# Amazon Clone

A comprehensive e-commerce mobile application built with Flutter, replicating the core features of Amazon. This app allows users to browse products, search for items, manage their shopping cart, place orders, sell products, and leave reviews, all powered by Firebase for backend services.

## Features

### User Authentication
- Secure sign-in and sign-up using Firebase Authentication
- Persistent user sessions across app restarts

### Product Browsing
- Home screen with banner ads and featured products
- Horizontal category list for easy navigation
- Product showcase with images, prices, and ratings

### Search Functionality
- Advanced search bar with real-time suggestions
- Results screen displaying filtered products
- Category-based filtering

### Product Details
- Detailed product pages with images, descriptions, and specifications
- Customer reviews and ratings display
- Add to cart functionality

### Shopping Cart
- Add/remove products from cart
- Quantity management
- Total price calculation
- Secure checkout process

### Order Management
- Place orders with user details
- Order history tracking
- Order status updates

### Sell Products
- Dedicated seller interface
- Product listing with image upload
- Manage seller inventory

### Reviews and Ratings
- Leave reviews and ratings for products
- View average ratings and customer feedback
- Interactive review dialog

### User Account
- Personal account dashboard
- Order history and tracking
- User profile management
- Account settings

### Additional Features
- Image picker for product uploads
- Cloud storage integration for media files
- Responsive UI with loading indicators
- Error handling and user feedback

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Authentication, Firestore, Storage)
- **State Management**: BLoC Pattern
- **UI Components**: Material Design
- **Image Handling**: Image Picker, Path Provider
- **Other Libraries**: Equatable, Universal HTML

## Installation

1. **Prerequisites**:
   - Flutter SDK (version 3.8.1 or higher)
   - Dart SDK
   - Android Studio or VS Code with Flutter extensions
   - Firebase project setup

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/amazon-clone.git
   cd amazon-clone
   ```

3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Firebase Setup**:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication, Firestore, and Storage
   - Download `google-services.json` for Android and place it in `android/app/`
   - For web, update the Firebase config in `lib/main.dart`

5. **Run the App**:
   ```bash
   flutter run
   ```

## Usage

1. **Launch the App**: Run `flutter run` to start the application on your connected device or emulator.

2. **Sign Up/Sign In**: Create a new account or log in with existing credentials.

3. **Browse Products**: Explore the home screen, categories, and search for items.

4. **Add to Cart**: Select products and add them to your shopping cart.

5. **Checkout**: Proceed to checkout and place your order.

6. **Sell Products**: Use the sell screen to list your own products for sale.

7. **Leave Reviews**: After purchasing, rate and review products.

## Project Structure

```
lib/
├── blocs/          # BLoC state management
├── layout/         # Main app layout
├── models/         # Data models
├── repositories/   # Data repositories
├── resources/      # Firebase methods
├── services/       # Storage services
├── utils/          # Utilities and constants
├── views/          # Screen widgets
└── widgets/        # Reusable UI components
```

## Mockups

*Add your app mockups and screenshots here*

### Home Screen Mockup
![Home Screen](path/to/home_mockup.png)

### Product Details Mockup
![Product Details](path/to/product_mockup.png)

### Cart Screen Mockup
![Cart Screen](path/to/cart_mockup.png)

### Account Screen Mockup
![Account Screen](path/to/account_mockup.png)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
