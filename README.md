# Districap E-Commerce Mobile Application

## Overview
This project involves the development of a cross-platform e-commerce mobile application for **Districap** using **Flutter**, targeting both **Android** and **iOS** platforms. The application is built with **Dart** and leverages **Firebase** for backend services, ensuring scalability, real-time data synchronization, and secure user authentication.

---

## Table of Contents
1. [Introduction](#introduction)
2. [Physical Architecture](#physical-architecture)
   - [Back-end Servers](#back-end-servers)
   - [Mobile Devices](#mobile-devices)
   - [Communication Networks](#communication-networks)
3. [Software Architecture](#software-architecture)
   - [Layered Architecture](#layered-architecture)
   - [Implementation of the Architecture](#implementation-of-the-architecture)
4. [Technologies and Frameworks](#technologies-and-adopted-frameworks)
5. [Demo Video](#demo-video)

---

## Introduction
In this implementation section, I discuss the tools, languages, and technologies employed to bring the project to fruition. The application's interfaces are showcased, providing all necessary details to demonstrate their accuracy and validity.

---

## Physical Architecture
The physical architecture of the mobile e-commerce application ensures its performance, reliability, and availability. It organizes hardware components and their interconnections to facilitate smooth operation.

### Back-end Servers
The back-end servers are the core of the application, managing user requests and data using **Firebase**. Key features include:
- **Secure User Authentication**: Using `firebase_auth`, `cloud_firestore`, and `firebase_storage`.
- **Cloud Infrastructure**: Leveraging **Firebase**, **Cloud Firestore**, **Storage**, and **Google Cloud** for scalability and efficient data management.
- **Authentication Methods**: Integration of **Google Sign-In** and **Phone Authentication** with OTP verification.

### Mobile Devices
Mobile devices execute the Flutter application code, enabling users to access all features. Key functionalities include:
- **Localization**: Using `flutter_localizations` and `intl` packages for global reach.
- **State Management**: Utilizing the `provider` package for smooth UI state management.
- **Core Features**: Adding products to the cart, managing orders, and processing payments.

### Communication Networks
Communication networks ensure seamless interaction between mobile devices and back-end servers. Key aspects include:
- **Connectivity Monitoring**: Using the `connectivity_plus` package for online/offline functionality.
- **Real-time Data Sync**: Enabled by **Firebase Cloud Firestore** and **Firebase Realtime Database**.

---

## Software Architecture
The application follows the **MVC (Model-View-Controller)** architecture, ensuring efficient organization and separation of responsibilities.

### Layered Architecture
The application is divided into three primary layers:
1. **Model**: Handles data and business logic (e.g., products, users, orders).
2. **View**: Manages the user interface and visual elements.
3. **Controller**: Acts as an intermediary between the Model and View, processing user interactions and updating the UI.

### Implementation of the Architecture
The codebase is organized into the following structure:
- **`models`**: Data structures for products, users, and orders.
- **`screens`**: UI components for each screen or page.
- **`controllers`**: Business logic and user interaction management.
- **`assets`**: Static resources like images, icons, and fonts.
- **`lib` and `test`**: Core application code and testing scripts.
- **Subfolders in `lib`**: Includes `components`, `data`, `pdf`, `providers`, `services`, `widgets`, etc.
- **Configuration Files**: `config.dart`, `constants.dart`, `routes.dart`, `theme.dart`, etc.

---

## Technologies and Adopted Frameworks
The application is built using the following technologies:
### Front-end Frameworks
- **Flutter**: For cross-platform UI development.
- **Dart**: The programming language powering Flutter.

### Back-end Frameworks
- **Firebase**: For authentication, real-time databases, and cloud storage.
- **Firestore**: For NoSQL cloud database management.

### State Management
- **Provider**: For efficient state management and data sharing.

### Networking and Data Handling
- **HTTP Package**: For API communication.
- **Firebase Cloud Functions**: For serverless backend logic.

---

## Demo Video
Below is a demo video showcasing the application's features and functionality:

<video width="640" height="360" controls>
  <source src="Demo.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

*Click the image above to view the video.*

---

## How to Run the Project
1. Clone the repository:
   ```bash
   git clone https://github.com/Chaimaaorg/E-commerce-Mobile-App
