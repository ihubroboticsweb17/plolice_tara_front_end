# Feature Operations Guide

The Police Tara system houses multiple complex user flows tailored for an administrative public-facing robot.

## 1. Welcome Screen (`features/welcome/view/welcome_screen.dart`)
Functioning as the dashboard, the Welcome Screen leverages a two-panel layout overlaid on a full custom `bg.png` space background.

### Operations
- **Passive Background Syncing:** Utilizing Dart `Timer.periodic()`, every 5 seconds the app quietly polls for IP updates via `ApiService.fetchAndUpdateBaseUrl()`.
- **Speaking Status Toggle:** Central mic icon toggles the robot's hardware 'listening/speaking' state. 
- **Hidden Volume Widget:** Triggers via the volume icon, revealing an interactive `Slider` which instantly dispatches volume commands via `VolumeController`.
- **Navigation Shortcuts:** "Let's Go" (View Complaints), Language, and Add Complaint floating buttons utilizing custom SVG icons.

## 2. Complaint Management Portal (`features/complaint_screen`)
The core CRUD capability of this project, ensuring issues are tracked efficiently.

### Views & Capabilities
- **`ComplaintsList`**: Uses a `ListView.builder` inside a `Consumer<ComplaintController>` to asynchronously map out a list of active complaints. It implements styling elements such as radial gradients and elegant list tiles showing names and addresses.
- **`ComplaintAddEditView`**: Contains an intricate form with `TextFormField`. The widget accepts a boolean `isEdit` paired with an optional ID for updating an existing complaint, dynamically swapping standard "Add" functionality for "Edit / Patch" REST calls.
- **`ComplaintsDetailsView`**: Renders the complete specific contents of an individual complaint. 

## 3. Localization Settings (`features/language`)
Managed through `LanguageList` and the `LanguageProvider`. Displays large tap targets suitable for tactile interactions off an external language model list. 

## 4. Hardware Health Polling (`features/welcome`)
The project manages direct connections to hardware battery services via `features/welcome/model/online_battery_model.dart` and offline variants. 
`BatteryProvider.fetchOnlineBattery()` grabs vital metrics, adjusting the UI indicator icons across the whole application natively without manual setState triggers.

## 5. Login & Authentication (`features/login`)
A secure gateway for accessing restricted functionality via the `LoginController` and `LoginService`. Provides foundational authentication mechanisms leveraging custom user input handling components.
- **`PasswordScreen` & `LoginView`:** Core interfaces handling credentials.

## Shared UI Systems (`core/widgets`)
To maintain the enterprise visual standard, all dynamic interfaces use shared core widgetry rather than distinct ad-hoc designs. Some highlights include:
- **`Glassmorphism`:** Foundation of the entire UI theme ensuring immersive, frosted overlays overlaying background assets.
- **`SideSheet` & `Toast`:** Comprehensive custom alert mechanisms designed around the landscape tablet paradigm.
- **`CompanyLogo` & Form Controls:** Specialized UI elements supporting responsive layout.
