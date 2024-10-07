
# Onze Coffee

## Overview

**Onze Coffee** is a Flutter app designed to offer an easy and efficient way for users to order and track their coffee orders. It employs the BLoC (Business Logic Component) pattern for managing state, ensuring a responsive and dynamic user experience. The app provides user authentication and order management capabilities, with the following features:

## Key Features

- **Splash Screen**: A custom-designed splash screen that reflects the branding of Onze Coffee, providing smooth transitions.
- **Onboarding**: A guided experience that introduces new users to the app's features.
- **Authentication**: Secure user login and email verification through OTP (One Time Password).
- **Order Tracking**: Real-time order tracking, showing the status of the coffee order in progress.
- **Order Management**: Allows users to view their current and completed orders with a clear interface.
- **Responsive Design**: The app is built to adjust dynamically across different screen sizes and orientations for an optimal user experience.

## Detailed Screens

### SplashScreen
- **Purpose**: Displays the Onze Coffee logo and a brief intro to the app.
- **State Management**: Uses `SplashCubit` for managing the timing of the splash screen and transition to the next screen.
- **UI Elements**: A centered logo (`onze.png`), branding images, and a full-screen background image. The color scheme aligns with the app's brand identity.

### WelcomeScreen
- **Purpose**: Introduces new users to the app with a multi-page onboarding experience.
- **State Management**: `WelcomeCubit` manages the onboarding flow and handles transitions between pages.
- **UI Elements**: Three slides featuring background images, introductory text, a dot indicator for navigation, and a "Next" button. The final slide navigates users to the sign-up process.

### LoginScreen
- **Purpose**: Provides a login form for user authentication.
- **State Management**: `AuthCubit` handles the login logic, including validation and state transitions (loading, success, error).
- **UI Elements**: Custom text fields for email input, a "Login" button, and a link to create a new account. The design is consistent with the rest of the app.

### VerifyScreen
- **Purpose**: Allows users to verify their email using an OTP.
- **State Management**: `AuthCubit` processes OTP verification, displaying loading, success, or error states.
- **UI Elements**: Displays the user's email, a Pinput widget for entering the OTP, and a placeholder for a "Verify OTP" button (which can be uncommented for manual submission).


### TrackOrderScreen
- **Purpose**: Lets users track their coffee order with real-time updates.
- **State Management**: `TrackOrderBloc` fetches and displays the order status using states (loading, success, error).
- **UI Elements**: Displays the order number, a Lottie animation for order progress, and a `Stepper` (currently commented out) to visually represent the different stages of the order.


### HomeScreen
- **Purpose**: Displays coffee products and provides filtering, searching, and cart management features.
- **State Management**: BLoC is used to manage states like filtering and searching.
- **UI Elements**: A search bar, filter options (e.g., hot coffee, cold coffee), a swiper carousel for product display, and an "Add to Cart" button. Custom animations enhance user interaction.



### OrdersScreen
- **Purpose**: Displays and categorizes user orders into "Current" and "Completed" tabs.
- **State Management**: `OrderStateBloc` handles fetching and displaying the user's order history.
- **UI Elements**: A tab bar for navigating between current and completed orders, custom list tiles for displaying order details, and Lottie animations for loading indicators.
  

### FirstTimeVerify Screen
- **Purpose**: Handles the verification process during the user's first login by entering an OTP.
- **State Management**: Utilizes BLoC and `Pinput` for seamless OTP input.
- **UI Elements**: Displays instructions for verifying the email, an input field for OTP, and a custom background.



### Screens

![534766945debe5a0abd0137dfcb6796a](https://github.com/user-attachments/assets/de0e6976-8876-4e83-8abd-7bb661dff082)

![6039a92e55b6966dcdcb8e4775065411 (1)](https://github.com/user-attachments/assets/bcf13ee7-7fcd-40d8-9c4e-954b8ee5062a)

![home](https://github.com/user-attachments/assets/a8141530-8c16-4a98-8e93-ba8588332b89)

![b774e867c938046adf70c0c6b173a556](https://github.com/user-attachments/assets/95a46ef7-6d35-44e5-aa79-d442d5241e7a)

### User Flow
The user flow diagram illustrates the process of managing orders for both employees and customers in an ordering system. Here's a detailed breakdown:

### 1. **Start**
   - The process begins for either an employee or a customer.

### 2. **Employee Decision**
   - **If the user is an employee** (left side - red flow):
     - They are directed to **check orders**.
     - **Decision Point (Accept?)**:
       - If the order is **accepted**, the employee proceeds to **confirm the order**.
       - After confirming, they can **change the order state** to reflect the status.
     - If the order is **not accepted**, the flow terminates.

   - **If the user is not an employee** (right side - blue flow):
     - They are directed to **view products** available in the system.

### 3. **Customer Flow**
   - **Add to Cart**: The customer selects products and adds them to the cart.
   - **Place Order**: The customer proceeds to place the order.
   - **View Order and Waiting Time**: The customer views the order details and estimated waiting time.
   - **Decision Point (Proceed?)**:
     - If the customer decides to proceed, they go to **Payment**.
     - After payment, the customer can **track the order**.

### 4. **End**
   - The process concludes once the employee has processed the order or the customer has successfully placed and tracked their order.

![Screenshot 2024-10-05 at 8 53 02 PM](https://github.com/user-attachments/assets/1abceb5c-b175-47e4-99a2-d3e207a649b7)






### ER model

### 1. **Product**
   - **product_id** (int4): Unique identifier for each product.
   - **name** (text): Name of the product.
   - **price** (numeric): Price of the product.
   - **stock** (int4): Current stock level of the product.
   - **category** (text): The category of the product (e.g., food, drinks).
   - **description** (text): Description of the product.
   - **availability** (boolean): Whether the product is available.
   - **image_url** (text): URL to the image of the product.
   - **waiting_time** (int4): Time required to prepare the product.
   - **calories** (int4): Nutritional information about the product (calories).

### 2. **Order_Items**
   - **item_id** (int4): Unique identifier for each item in an order.
   - **product_id** (int4): Links to the product being ordered.
   - **price** (numeric): Price of the product in the specific order (can include discounts).
   - **quantity** (int4): Quantity of the product ordered.
   - **order_id** (int4): Links to the specific order this item belongs to.

### 3. **Orders**
   - **order_id** (int4): Unique identifier for each order.
   - **order_time** (timestamp): Time the order was placed.
   - **user_id** (UUID): Links to the user who placed the order.
   - **emp_id** (UUID): Links to the employee responsible for processing the order (if applicable).
   - **status** (status): The current status of the order (e.g., pending, processed, delivered).
   - **date** (timestamp): Date of the order.

### 4. **Bill**
   - **bill_id** (int4): Unique identifier for the bill.
   - **user_id** (UUID): Links to the user responsible for the bill.
   - **order_id** (int4): Links to the specific order associated with the bill.
   - **price** (numeric): Total price for the bill (sum of all order items).
   - **date** (timestamp): Date the bill was generated.
   - **payment_method** (text): Payment method used (e.g., credit card, cash).

### 5. **Users**
   - **user_id** (UUID): Unique identifier for each user.
   - **email** (text): Email of the user.
   - **name** (text): Name of the user.
   - **role** (role): The role of the user (e.g., customer, employee).
   - **external_id** (text): External identifier, possibly used for linking with other services.

### 6. **auth.users**
   - **id** (UUID): Linked to the users table to authenticate users through an external service (auth).

### Relationships
- **Product to Order_Items**: Each order item is linked to a product by `product_id`.
- **Orders to Order_Items**: An order can have multiple items linked through `order_id`.
- **Orders to Users**: Each order is placed by a user (`user_id`).
- **Orders to Employees**: Each order can optionally be linked to an employee (`emp_id`).
- **Orders to Bill**: A bill is associated with a specific order via `order_id`.
- **Users to Bill**: Each bill is linked to the user who made the order through `user_id`.
- **Users to auth.users**: The `users` table is connected to the `auth.users` table for authentication.

![Screenshot 2024-10-05 at 8 51 45 PM](https://github.com/user-attachments/assets/71450d5b-061e-4d36-8a1e-e009bc442978)

![Screenshot 2024-10-05 at 8 56 22 PM](https://github.com/user-attachments/assets/b4bdd9ae-b55e-4d07-9a73-9c30c8319390)


### Dependencies

- **cupertino_icons:** Provides iOS-style icons for Flutter apps.
- **supabase_flutter:** Enables easy integration with Supabase (backend-as-a-service) for authentication, database, and storage.
- **onesignal_flutter:** OneSignal push notification integration for Flutter.
- **device_preview:** Allows you to preview your app on various devices and screen sizes.
- **get_storage:** A simple key-value storage solution for Flutter applications.
- **get_it:** A service locator for managing dependencies and objects.
- **flutter_bloc:** State management library based on BLoC (Business Logic Component) architecture.
- **lottie:** For rendering rich animations from Lottie (JSON-based animations).
- **flutter_svg:** Renders SVG files and images in Flutter.
- **card_swiper:** Provides swipeable card interfaces and UIs.
- **moyasar:** Integrates Moyasar payment gateway into Flutter apps


### Team Members
 Abdulaziz Alruwaily
 Amjad Elahi
 Linda Almakramy
  Nouf Alqahtani
