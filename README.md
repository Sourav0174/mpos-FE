# mPOS ⚡

**mPOS** is a modern, offline-first Point of Sale (POS) system engineered for small and medium-sized retail shops. Designed with speed and reliability in mind, mPOS ensures that core checkout loops—scanning, billing, and inventory deduction—function flawlessly even without internet connectivity.

Drawing inspiration from the sleek `apisense` design system, mPOS offers an intuitive, high-contrast, and deeply responsive user experience.

---

## 🌟 Key Features

* **Offline-First Architecture**: Continuous camera scanning, local database processing, and instant checkout run entirely offline using embedded SQLite. 
* **Ultra-Fast Billing**: Designed to process a multi-item checkout in under 30 seconds.
* **Modern UI/UX**: Clean, elevated design system supporting Light, Dark, and System modes with optimized touch targets for retail hardware.
* **Resilient Sync**: Background asynchronous synchronization ensures that all local transactions are eventually reconciled with the cloud server once connectivity is restored.
* **Modular Payment & Receipt**: Native support for Split Payments, ESC/POS Thermal Printing, and WhatsApp digital receipts.

---

## 🏗️ Technology Stack

**Frontend (Mobile App)**
* **Framework**: [Flutter](https://flutter.dev/) & Dart
* **State Management**: [Riverpod](https://riverpod.dev/) (`riverpod_annotation`)
* **Local Database**: [Drift](https://drift.simonbinder.eu/) (SQLite wrapper)
* **Architecture**: Clean Architecture with feature-first modularization

**Backend (Cloud Sync) - *Upcoming***
* **Framework**: FastAPI (Python 3.11+)
* **Database**: PostgreSQL
* **Infrastructure**: Docker + AWS

---

## 🚀 Getting Started

To run the mPOS Flutter client locally:

### Prerequisites
* Flutter SDK (`^3.19.0` or higher)
* Dart SDK
* An iOS Simulator or Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/mpos.git
   cd mpos
   ```

2. **Navigate to the frontend**
   ```bash
   cd frontend
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run code generation (for Drift DB & Riverpod)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the App**
   ```bash
   flutter run
   ```

---

## 🗺️ MVP Roadmap

- [x] **Milestone 0: Foundation & Setup** - App architecture, Design System, Local DB (Drift) setup, Shop Profile routing.
- [ ] **Milestone 1: Product Management** - Ultra-fast product onboarding (Scan -> Name + Price + Stock).
- [ ] **Milestone 2: Ultra-Fast Billing** - Continuous camera scanning, cart management, instant UI feedback.
- [ ] **Milestone 3: Payment** - Support for Cash, UPI, Card, and Split Payments.
- [ ] **Milestone 4: Receipt** - Thermal printer integration and WhatsApp sharing.
- [ ] **Milestone 5: Simple Dashboard** - Today's Sales, Today's Bills, Stock Alerts.
- [ ] **Milestone 6: Basic Inventory** - Stock deduction and low-stock threshold management.
- [ ] **Milestone 7: Offline-First Reliability** - Cloud sync queues and conflict resolution logic.

---

## 🧠 Core Engineering Principles

We adhere strictly to the following standards across the codebase:
1. **SOLID Principles & DRY**: Zero code duplication. Logic is cleanly separated into Repositories, Providers, and UI components.
2. **Senior Developer Standards**: Proactive edge-case handling, strongly typed schemas, and defensive programming.
3. **UUIDs & Audit Trails**: Every database entity utilizes client-generated UUID v4 strings, with `createdAt`, `updatedAt`, and `syncStatus` flags for future-proof cloud synchronization.

---

**© 2026 mPOS Platform. All rights reserved.**
