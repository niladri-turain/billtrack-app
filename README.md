# BillTrack App

BillTrack is a comprehensive business management mobile application designed to streamline billing, invoicing, and sales reporting for business owners. Built with Flutter, the app focuses on providing a clean UI/UX and efficient workflow management.

## 🚀 Features & Modules

### 1. Authentication & Onboarding
*   **Splash Screen**: Features a sequential dual-controller animation where branding elements ('B' and 'illTrack') animate into view.
*   **Login Screen**: Secure 10-digit mobile number authentication.
*   **OTP Verification**: 4-digit dynamic code generation with a 60-second countdown timer and auto-fill simulation.
*   **Registration Workflow**: A two-step process to collect business details, owner information, and security PINs.

### 2. Dashboard & Home
*   **Real-time Metrics**: Visual overview of today's sales and recent transactions.
*   **Quick Actions**: Easy access to major features via a custom bottom navigation bar.
*   **Invoice Listing**: List of recent invoices with status indicators and quick view options.

### 3. Product Management
*   **Item Master**: Centralized list of all products with search and filter capabilities.
*   **Set Price**: Screen to manage product pricing and configurations.
*   **Active Products**: Accessible via the Account screen, allowing users to toggle product visibility and availability.

### 4. Billing & Invoicing
*   **Create Bill**: Streamlined interface for generating new invoices.
*   **Invoice Details**: Dynamic viewer (`InvoiceViewScreen`) displaying comprehensive bill data including customer info, itemized lists, and payment summaries.

### 5. Reports & Analytics
*   **Sales Report**: Detailed analytics dashboard featuring:
    *   Comparative sales and invoice metrics.
    *   Downloadable PDF/Excel reports.
    *   Interactive time-based filters (Month, 3 Months, This Year).
    *   Visual sales trends using graphical charts.

### 6. Account & Settings
*   **Profile Management**: View and edit business profile information.
*   **Feature Shortcuts**: Quick links to Sales Reports, Active Products, and other business tools.

---

## 📁 Project Structure

```text
lib/
├── core/
│   └── constant/               # App constants (Colors, Strings, Assets)
├── features/
│   ├── account/                # Profile and business summary
│   ├── activeProduct/          # Product availability management
│   ├── createBill/             # Billing generation logic
│   ├── home/                   # Dashboard and recent activity
│   ├── invoice/                # Invoice list and detailed view
│   ├── loginScreen/            # Login and OTP workflow
│   ├── product/                # Item Master and pricing
│   ├── registrationScreen/     # New user onboarding
│   ├── salesReport/            # Analytics and reporting widgets
│   └── splashScreen/           # Animated entry screen
├── widgets/                    # Reusable UI components (AppBars, TextFields, etc.)
└── main.dart                   # Application entry point
```

---

## 🎨 Design Constants

*   **AppColors**: Centralized theme management (Orange primary, Green for success/save, Grey for secondary text).
*   **Custom Widgets**: 
    *   `CustomAppBar`: Standardized header across screens.
    *   `CustomTextFieldWidget`: Enforced constraints (phone numbers, OTPs, PINs).
    *   `CustomBottomNavigationBar`: Unified navigation interface.

## 🛠️ Tech Stack
*   **Framework**: Flutter
*   **Language**: Dart
*   **Assets**: Optimized PNGs and SVGs for high-quality UI.
*   **Navigation**: Navigator 1.0/2.0 patterns for screen transitions.

---
*Developed for BillTrack - Simplifying Business Management.*
