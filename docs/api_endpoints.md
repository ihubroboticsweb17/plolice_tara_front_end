# REST API Endpoint Reference

This document outlines the hardcoded static and dynamic endpoints located in `lib/core/api/api_constants.dart` that power the Police Tara frontend.

## Foundation & IP Addressing
- **`globalIP`**: `http://3.88.46.127`
- **`defaultBaseUrl1`**: Dynamic (defaults to `http://192.168.1.26:8000`)

### Endpoint: Grab Dynamic IP
- **Description:** Called continuously to find the robot's local IP address.
- **Route:** `[globalIP]/robot/get-last-ip/{roboId}/`
- **Method:** GET

---

## 2. Complaint Service (`/police/complaints/...`)
- **Create a Complaint:**
  - Route: `/police/complaints/create/`
- **List All Complaints:** 
  - Route: `/police/complaints/list/?user={userId}`
- **Get Detail View:**
  - Route: `/police/complaint/detail/`
- **Edit/Update Existing:**
  - Route: `/police/complaints/edit/`

---

## 3. Robot Hardware & States

### Battery Telemetry
- **Offline Battery Sync:** `/robot-battery/list/`
- **Online Battery Sync:** `/robot/sale/user/list/`
- **Charging Status:** `/charging/get/`

### Speak & Mic Operations
- **Toggle/Create Speak Status:** `/police/speak/create/`
- **Check Current Speak Status:** `/police/speak/list/`

### Volume Modulation
- **Set Robot Volume:** `/volume/set/`
- **Get Current Volume:** `/volume/get/`

### Languages
- **Fetch Supported Languages:** `/robot/languages/list/`
- **Push Language Selection via Update:** `/robot/update-robots/`

---

## 4. Modules & PDF Viewers 
While less prominent in the Police Tara build, the infrastructure accommodates robust PDF hosting and module systems.
- **List PDFs:** `/pdfs/list/`
- **Upload New PDF:** `/upload-pdf/`
- **Edit PDF Entry:** `/pdfs/edit/`
- **Delete PDF:** `/pdfs/delete/`
- **Fetch Last Known Module:** `/lastmodule/`
