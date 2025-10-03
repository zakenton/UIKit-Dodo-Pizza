Dodo Pizza iOS Clone 🍕

https://img.shields.io/badge/Swift-5.0-orange.svg
https://img.shields.io/badge/UIKit-Apple-blue.svg
https://img.shields.io/badge/Platform-iOS-lightgrey.svg

A fully functional iOS clone of the Dodo Pizza web interface, built using native Apple technologies.

📱 About The Project

This application replicates the core functionality of the Dodo Pizza web interface, providing users with a convenient way to order pizza and other products. The project demonstrates proficiency with modern iOS development technologies.

🛠 Technologies Used

Swift - Primary development language
UIKit - Framework for building user interface
SnapKit - DSL for Auto Layout
MapKit - Maps integration and location services
URLSession - Network requests and API communication
✨ Features

🎨 Adaptive user interface
🗺 Maps integration for delivery address selection
📦 Complete pizza ordering workflow
🔄 Network communication with API
🎯 Modern Auto Layout using SnapKit
📍 Location-based services
🛒 Shopping cart functionality
📸 Screenshots

Main Screen

<p align="center"> <img src="Screenshots/main_screen.png" width="300" alt="Main Screen"> </p>
Pizza Menu

<p align="center"> <img src="Screenshots/pizza_menu.png" width="300" alt="Pizza Menu"> </p>
Delivery Map

<p align="center"> <img src="Screenshots/delivery_map.png" width="300" alt="Delivery Map"> </p>
Shopping Cart

<p align="center"> <img src="Screenshots/cart.png" width="300" alt="Shopping Cart"> </p>
🚀 Installation & Setup

Clone the repository:
bash
git clone https://github.com/your-username/dodo-pizza-ios-clone.git
Open the project in Xcode:
bash
cd dodo-pizza-ios-clone
open DodoPizza.xcodeproj
Install dependencies (if any):
bash
pod install
Build and run the project in simulator or device (⌘+R)
📁 Project Structure

text
DodoPizza/
├── Models/
│   ├── Pizza.swift
│   ├── CartItem.swift
│   └── Order.swift
├── Views/
│   ├── PizzaCell.swift
│   ├── MenuHeaderView.swift
│   └── CartView.swift
├── ViewControllers/
│   ├── MenuViewController.swift
│   ├── CartViewController.swift
│   └── MapViewController.swift
├── Services/
│   ├── NetworkManager.swift
│   └── LocationService.swift
├── Resources/
│   ├── Assets.xcassets
│   └── Info.plist
└── Utilities/
    ├── Extensions.swift
    └── Constants.swift

