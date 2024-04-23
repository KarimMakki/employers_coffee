




<img src="https://github.com/iec-solutions-team/employee_coffee_app/assets/91680756/c495b842-a3a6-4f0a-98ff-6260bd78f2db" alt="Screenshot2" width="100%"/>
<img src="https://github.com/iec-solutions-team/employee_coffee_app/assets/91680756/a570cc46-4738-4665-8376-af04e493be87" alt="Screenshot" width="100%"/>




# **Employers Coffee App**

# **Overview**

The employers coffee app is a flutter mobile application helps a company's employers add their own coffee preference, the app uses firestore as a database to save the coffees data and utilizies google login, email and password login for authentication

## **Features**

1. Ability to add your coffee preference by using it's type and if you like it hot or cold.

2. Edit your coffee preference and have it updated in realtime using Firestore.

3. Review your profile details after logging in by google or email.


# **Getting Started**

### **1. Setup the Firebase App**
1. You’ll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
2. Once your Firebase instance is created, you’ll need to enable Google authentication.
3. Go to the Firebase Console for your new instance.
4. Click “Authentication” in the left-hand menu
5. Click the “sign-in method” tab
6. Click “Google” and enable it

### **2. Enable the Firestore Database**
1. Navigate to the [Firebase Console](https://console.firebase.google.com/).
2. Select your Firebase project.
3. Go to the "Database" section.
4. Choose Firestore as your database.
5.  Setting Up Security Rules (Optional): You can set up security rules to control access to your Firestore database. Learn more about Firestore security rules [here](https://firebase.google.com/docs/firestore/security/get-started).

### **3. (skip if not running on Android)**
1. Create an app within your Firebase instance for Android, with package name com.yourcompany.news
2. Run the following command to get your SHA-1 key:  keytool -exportcert -list -v \-alias androiddebugkey -keystore ~/.android/debug.keystore
3. In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking “Add Fingerprint”.
4. Download  google-services.json and place it into /android/app/.

   
### **4. (skip if not running on iOS)**
1. Create an app within your Firebase instance for iOS, with your app package name
2. Download GoogleService-Info.plist
3. Open XCode, right click the Runner folder, select the “Add Files to ‘Runner'” menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode
4. Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item in the array value of this key is specific to the Firebase instance. Replace it with the value for REVERSED_CLIENT_ID from GoogleService-Info.plist


### **5. Setting up Environment Variables**
1. Rename .env.example file to .env.
2. Add your firebase project apiKey and appId

   
