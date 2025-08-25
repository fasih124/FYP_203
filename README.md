# **CareNest — Smart Baby Cradle Monitoring System** 

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Flutter%20%7C%20Firebase-blue?style=for-the-badge" alt="Platform" />
  <img src="https://img.shields.io/badge/Architecture-MVVM-success?style=for-the-badge" alt="Architecture" />
  <img src="https://img.shields.io/badge/Status-Ongoing-orange?style=for-the-badge" alt="Status" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License" />
</p>

<p align="center">
  <i>An intelligent cradle monitoring system that ensures your baby's safety with real-time monitoring, notifications, and automation.</i>
</p>

---

## 📌 **Overview**

**CareNest** is a **smart baby cradle monitoring system** built with **Flutter** and **Firebase Realtime Database**.
It helps parents **monitor their baby’s activities**, **detect presence**, **receive real-time notifications**, and even **automate cradle movements** based on baby activity and environmental conditions.

---

## ✨ **Key Features**

* 🍼 **Real-Time Baby Monitoring** → Track baby presence and activity live.
* 📹 **Live Video Streaming** → Watch your baby from anywhere using the app.
* 🌡 **Environmental Monitoring** → Detect temperature, humidity, and moisture levels.
* 🔔 **Instant Notifications** → Get alerts for baby presence, crying, or unusual activity.
* ⚡ **Firebase Integration** → Realtime database updates and secure data handling.
* 🎨 **Modern Flutter UI** → Smooth, responsive, and user-friendly interface.

---

## 🛠 **Tech Stack**

| Category           | Technology                          |
| ------------------ | ----------------------------------- |
| **Frontend**       | Flutter (Dart)                      |
| **Architecture**   | MVVM                                |
| **Backend**        | Firebase Realtime Database          |
| **Notifications**  | Flutter Local Notifications         |
| **Authentication** | Firebase Auth (optional)            |
| **Cloud Storage**  | Firebase Storage (for images/video) |
| **Tools**          | Android Studio, VS Code             |

---

## ⚡ **Installation & Setup**

### **1. Clone the Repository**

```bash
git clone https://github.com/your-username/CareNest.git
cd CareNest
```

### **2. Install Dependencies**

```bash
flutter pub get
```

### **3. Configure Firebase**

* Go to [Firebase Console](https://console.firebase.google.com/)
* Create a new project **CareNest**
* Download `google-services.json` and place it in `android/app/`
* Enable:

  * Realtime Database
  * Authentication (optional)
  * Storage (optional)

### **4. Run the Project**

```bash
flutter run
```

---

## 🎯 **How to Use**

1. **Login/Register** → Authenticate using email or Google.
2. **Dashboard** → View cradle model and baby monitoring stats.
3. **Live Video** → Watch real-time camera feed of the cradle.
4. **Notifications** → Receive instant alerts for moisture detection or baby presence.
5. **Automation** → Cradle movement triggers automatically when baby activity is detected.

---

## 📸 **Screenshots**

<p align="center">
  <table>
    <tr>
      <td align="center">
        <b>Splash Screen</b><br>
        <img src="Design%20and%20Architecture/Fornt%20End%20UI/Splash.png" alt="Splash Screen" width="250">
      </td>
      <td align="center">
        <b>Login Screen</b><br>
        <img src="Design%20and%20Architecture/Fornt%20End%20UI/Sign%20In.png" alt="Live Video" width="250">
      </td>
       <td align="center">
        <b>Home Screen</b><br>
        <img src="Design%20and%20Architecture/Fornt%20End%20UI/Home_connected_present.png" alt="Live Video" width="250">
      </td>
      <td align="center">
        <b>Video stream Screen</b><br>
        <img src="Design%20and%20Architecture/Fornt%20End%20UI/Video_connected.png" alt="Live Video" width="250">
      </td>
      <td align="center">
        <b>Setting Screen</b><br>
        <img src="Design%20and%20Architecture/Fornt%20End%20UI/Setting.png" alt="Notifications" width="250">
      </td>
    </tr>
  </table>
</p>

---

## 📂 **Project Structure**

```bash
Implementation/Flutter_Files
├── lib/
│   ├── models/           # Data Models (BabyPresence, CradleModel, etc.)
│   ├── view_models/      # MVVM ViewModels
│   ├── views/            # Flutter Screens
│   ├── services/         # Firebase, Notifications, Streaming
│   ├── widgets/          # Custom Widgets
│   └── main.dart         # App Entry Point
├── assets/               # App Icons, Screenshots, and Images
├── android/              # Android Configurations
├── ios/                  # iOS Configurations
└── README.md
```

---

## 🔮 **Future Enhancements**

* 📊 **Baby Sleep Analytics Dashboard** → Track sleep patterns.
* ☁️ **Cloud-Based History** → Store monitoring data for long-term insights.
* 🛠 **AI-Powered Baby Cry Detection** → Detect baby distress automatically.
* 🌍 **Multi-Cradle Management** → Support multiple devices in one app.

---

## 📬 **Contact**
**Fasih Ahmad KHan** — [LinkedIn](http://www.linkedin.com/in/fasih-ahmed-khan-a984ab226/) • [Portfolio](https://your-portfolio.com)
📧 **Email:** [fasihkhan124124@gmail.com](mailto:fasihkhan124124@gmail.com)

---

<p align="center">
  Made with ❤️ using Flutter, Firebase, and Dart
</p>
