# AutoSaaS - Automation Platform Demo 🚀

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev/)
[![Web Ready](https://img.shields.io/badge/Platform-Web%20%7C%20Android%20%7C%20iOS-success.svg)]()

> **Live Demo:** 🌐 [https://estebanrdz6.github.io/automation-saas-demo/](https://estebanrdz6.github.io/automation-saas-demo/)

A professional, ultra-modern, and minimal **SaaS Automation Platform Demo** built with **Flutter**. This application graphically represents a robust workflow automation tool designed specifically for B2B environments. It aims to showcase how services can be visually connected and automated (e.g., *"If a new customer is created → send email → create CRM contact → send Slack notification"*).

---

## 🎯 Project Overview

This project is a **fully functional UI demo** targeting potential clients and stakeholders to demonstrate cloud automation capabilities. 

### Key Highlights:
- **Cross-Platform:** Works seamlessly across Web, Android, and iOS leveraging Flutter's unified codebase.
- **Multilingual Support:** Dynamic language switching (English / Spanish) utilizing Provider for state management.
- **Material 3 Design:** Sleek, deeply integrated modern UI components, responsive sidebars, and clean typography.

---

## 🚀 Core Features

1. 📊 **Dashboard**
   - A high-level overview displaying execution statistics, active workflows, and system errors.
   - Powered by `fl_chart` to render dynamic, interactive and professional usage graphs.

2. ⚡ **Automation Visual Builder**
   - The core conceptual engine where users "create" logic.
   - Built to represent triggers (e.g., *New Webhook*) and actions (e.g., *Send Email*) via interconnected standard blocks.

3. 🔌 **Integrations Grid**
   - A mock marketplace mimicking connections to popular third-party services (Stripe, Slack, Salesforce, Mailchimp, REST APIs).

4. 📋 **Execution Logs**
   - Detailed history ledger tracking the status (`Success`, `Failed`, `Pending`) and execution times of triggered workflows.

5. 📚 **Templates & Education**
   - Specific panels designed to onboard users, showcasing pre-built scenarios (like *"Lead Capture Flow"*) and general SaaS business benefits.

6. 💳 **Pricing Module**
   - A standard SaaS tier display (Starter, Business, Enterprise) to evaluate scope limitations per account tier.

---

## 📂 Architecture & Project Structure

The project has been planned taking scalability and separation of concerns into account:

```text
lib/
├── core/           # Core configurations: Themes, Global constants, App configs.
├── models/         # Data structures: Automation nodes, Logs, User profiles.
├── services/       # Mock backend logic: Simulating execution and API calls.
├── automation/     # Visual Builder tools: Drag&Drop logic, node rendering.
├── integrations/   # Integration specifics: OAuth mocks, API wrappers.
├── localization/   # i18n logic: Dictionaries for English and Spanish.
├── ui/             # Reusable UI components: Cards, NavBars, Custom Buttons.
└── main.dart       # App entry point, routing (GoRouter), and Global Providers.
```

---

## 🛠️ Tech Stack

- **Framework:** Flutter (Dart)
- **Routing:** `go_router` (Perfect for Web URLs and nested shell navigation)
- **State Management:** `provider` (Handles the i18n toggle smoothly across the app)
- **Charting UI:** `fl_chart` (For high-quality dashboard analytics)
- **Local Storage:** `shared_preferences` (For persisting language preferences locally)



## 🌐 Deployment (GitHub Pages)

The project is configured to be seamlessly deployed via Flutter Web. 
The current stable build can be tested at any time through the official demo link at the top of this documentation.

---
*Developed as a high-end showcase for Automation Platforms.*