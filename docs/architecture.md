# Platform Architecture

The Police Tara Flutter project leverages clear architectural separations to improve code maintainability and testability. The application is broken down into structured features (`lib/features`) and common utilities (`lib/core`).

## State Management: Provider
We utilize the `provider` package to manage application state globally via ChangeNotifiers injected at the top-level `main.dart`. 

### Overview of Active Providers
Located in the `MultiProvider` block inside `main.dart`, the app leverages:
- **`LanguageProvider`**: Syncs localization states.
- **`VolumeController`**: Constantly listens for and updates absolute device volume settings exposed via the robot's API.
- **`BatteryProvider`**: Handles asynchronous fetching and updating of battery life percentages (both offline/online states).
- **`ComplaintController`**: Exposes the CRUD capabilities for user complaints and notifies views of loading or error conditions during API fetch events.
- **`LoginController`**: Handles foundational authentication.

## View and UI Layout Design
The visual domain of this project is distinctly designed for **Landscape Tablet / Robot Screens**. 

### Glassmorphism System
UI elements sit atop a modern, frosted-glass effect leveraging backdrop filters.
- **`BaseGlassmorphism`**: Reusable heavily blurred backdrop box using `BackdropFilter` with radial gradient decoration.
- **`ChildGlasmorphism`**: Lighter implementation used for individual buttons and interactive sliders across the modules.

### Core Architecture (`lib/core/`)
The foundation of the application lies in the `core/` directory, which shares essential utilities and widgets across all features to enforce DRY principles:
- `api/`: Centralized HTTP handling through `ApiService` and a single source of truth for REST endpoints via `ApiConstants`.
- `utils/`: Global utility helpers and functions.
- `widgets/`: Reusable, enterprise-grade components including customized buttons, side sheets, toasts, and the integral Glassmorphism layouts (`base_glassmorphism` and `child_glassmorphism`).

### Feature Modules (`lib/features/`)
Every capability in the application is encapsulated as a standalone module within the `features/` directory. Current modules include:
- **`welcome/`**: Dashboard viewing, volume control, battery monitoring, and robot status syncing.
- **`complaint_screen/`**: Full CRUD operations for public complaint management.
- **`language/`**: Multi-language localization selection.
- **`login/`**: Core user authentication and access gateway mechanisms.

Each feature is rigidly separated into an MVC-like layered pattern:
- `view/`: Contains specific stateful and stateless UI components.
- `controller/`: Houses the Provider ChangeNotifiers, bridging the gap between business logic, backend calls, and view states.
- `service/`: Isolated service layers dedicated to managing external API interactions and data fetching.
- `model/`: Plain Dart Object classes responsible for type-safe structured data mapping from JSON payloads.

## Networking Strategy
### Dynamic Base URL Assignment
Because this system runs on robots moving across networks, `lib/core/api/api_service.dart` acts as an active ping service.
Upon startup (`WelcomeScreen.initState`), `ApiService.fetchAndUpdateBaseUrl()` reaches out to a static global IP `http://3.88.46.127/robot/get-last-ip/` to detect its current active Local IP, subsequently overriding `ApiConstants.localIp` to ensure all future REST calls target the correct local gateway.
