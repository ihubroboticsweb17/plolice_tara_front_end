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

### Component Isolation
Every feature within the `lib/features/` folder is rigidly separated into MVC/MVC-like layers:
- `view/`: Contains stateful and stateless widgets.
- `controller/`: Houses the ChangeNotifiers linking logic and state.
- `service/`: Isolated class modules tasked *only* with handling HTTP requests (via `ApiService` or directly) and serializing JSON payloads.
- `model/`: Plain Dart Object classes mapping backend JSON responses.

## Networking Strategy
### Dynamic Base URL Assignment
Because this system runs on robots moving across networks, `lib/core/api/api_service.dart` acts as an active ping service.
Upon startup (`WelcomeScreen.initState`), `ApiService.fetchAndUpdateBaseUrl()` reaches out to a static global IP `http://3.88.46.127/robot/get-last-ip/` to detect its current active Local IP, subsequently overriding `ApiConstants.localIp` to ensure all future REST calls target the correct local gateway.
