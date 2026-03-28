# Police Tara Frontend

An enterprise-grade Flutter application designed as an intelligent frontend user interface for the **Police Tara robotics platform**. Operating as a dynamic public access terminal, the application is engineered for maximum stability, responsive interactions, and direct integration with active hardware sensors over local networks.

## Architecture & Overview
Police Tara provides cutting-edge interaction tailored strictly for a landscape-oriented tablet embedded within robot hardware. Built around a robust Provider-based MVC architecture, it cleanly separates UI rendering, business logic, model serialization, and external API communication.

The software serves as a multi-functional kiosk portal enabling:
- Real-time battery and hardware volume monitoring.
- Dynamic backend network discovery via an actively polling IP system.
- Secure login and unified localization capabilities.
- A robust Complaint Management ecosystem communicating directly with unified police datastores.

## Key Technical Features
- **Dynamic Network Polling:** Constantly pings a global registry (`http://3.88.46.127`) to map and connect to the robot's dynamic local APIs (`192.168.x.x`) ensuring uninterrupted connectivity.
- **Glassmorphism Design System:** An immersive, aesthetic, modern layout built around beautifully rendered glossy core widgets (`BaseGlassmorphism` and `ChildGlasmorphism`) ensuring a premium user experience on large touchscreens.
- **Landscape Strict Orientation:** Forced tablet orientation (`landscapeRight` and `landscapeLeft`) guaranteeing pixel-perfect scaling across robotic chassis screens.
- **Isolated Provider Injectors:** Highly decoupled application state distributing control logic across modular ChangeNotifiers like `LanguageProvider`, `BatteryController`, `VolumeController`, and `ComplaintController`.
- **Integrated Complaints Portal:** Seamlessly integrated CRUD portal allowing members of the public to file, edit, and track complaints instantly.

## Getting Started

### Prerequisites
- Flutter SDK `^3.8.1`
- Dart SDK
- Android SDK / iOS Setup

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Muneef-Nk/tara_gen_1.git
   ```

2. Navigate to the project directory:
   ```bash
   cd plolice_tara_front_end
   ```

3. Install all pub dependencies:
   ```bash
   flutter pub get
   ```

4. Run the application (ensure a tablet emulator or real device in landscape mode):
   ```bash
   flutter run
   ```

## Documentation Reference
For deeper technical insights, please explore the `docs/` directory:
- **[Architecture (docs/architecture.md)](docs/architecture.md):** Information on our State Management, UI component layouts, and network strategies.
- **[Features (docs/features.md)](docs/features.md):** Granular specifics of our Complaint Portals, Language tools, Battery/Volume systems, and the Welcome Dashboard.
- **[API Reference (docs/api_endpoints.md)](docs/api_endpoints.md):** The REST endpoints driving the entire application.

## Enterprise Tech Stack
- **Framework:** Flutter (`^3.8.1`), Dart SDK
- **State Management:** Provider pattern utilizing distributed ChangeNotifiers
- **Networking:** Custom HTTP API Service Layer dynamically mapping endpoint gateways
- **UI Toolkit:** Custom UI library (Glassmorphic layouts, Google Fonts, Lottie JSON micro-animations)
