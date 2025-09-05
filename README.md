Distributor & Retailer Management App

A Flutter app to manage Distributors and Retailers with full CRUD operations, type-based selection, and image upload.

Features

Add / Update / Delete users (Distributor / Retailer)

Image upload via camera (hidden in edit mode)

Type selection using tabs

Form validation for all fields

Mock API integration using Dio

Provider state management

Folder Structure
lib/
 ├─ core/      # Network, routes, theme, utils
 ├─ models/    # User model
 ├─ repository/# API services
 ├─ viewmodels/# Provider state management
 ├─ views/     # List & Form screens
 └─ widgets/   # Reusable widgets

Packages

provider, go_router, google_fonts, image_picker, dio, cupertino_icons

Usage

Select Distributor or Retailer tab on List Screen

Click Add User → fill form → submit

Edit user → form shows existing data (image upload hidden)

Delete user → removes from list

Author

Ajay Kumar – Flutter Developer
Let's Connect: 7876740036