# Police Tara

An enterprise-grade Flutter application designed as an intelligent frontend interface for the Police Tara robotics platform. 

## Overview
Police Tara provides cutting edge interaction tailored for a landscape-oriented tablet or robot device. It serves as an intuitive portal for language selection, real-time battery and volume monitoring, dynamic API communication, and a robust Complaint Management flow that directly interacts with backend systems.

## Key Features
- **Dynamic Networking:** Constantly polls for and manages connection to dynamic Robot APIs over local networks (`192.168.x.x`) and a global IP space.
- **Glassmorphism UI:** An aesthetic, modern, layout built around beautiful glassy panels using `BaseGlassmorphism` and `ChildGlasmorphism`.
- **Landscape First Layout:** Locked to landscape mode (`landscapeRight` and `landscapeLeft`) to ensure maximum screen utilization on robotics hardware.
- **Provider State Management:** Highly decoupled application state for decoupled controller management.
- **Integrated Complaints Portal:** Real-time logging, editing, and stateful tracking of public complaints.

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

## Technologies Used
* **Flutter & Dart** - Core framework and language
* **Provider** - Application state management
* **Google Fonts & Lottie** - UI / UX enhancements
* **http** - API integrations
