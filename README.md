# Parse Twilio Cloud Module

This sample application shows off the use of Parse and the Twilio Cloud Module by sending SMSs to phone numbers stored in Parse or in your address book. [Cloud Modules][cloudModulesGuide] are third-party integration libraries available from Cloud Code.

## Setup Instructions

1. Clone the repository and open the Xcode project.
2. Add your Parse application id and client key in `AppDelegate.m`.
3. Install the Parse command line tool by entering the command `curl -s https://www.parse.com/downloads/cloud_code/installer.sh | sudo /bin/bash` in your terminal (Mac) or command prompt (Windows).
4. From the root directory of the app, enter the command `parse new` in your terminal or command prompt in order to setup the cloud code configuration files.
5. You'll be prompted for your Parse username and password, and you'll also be shown a list of your Parse apps. Choose the one you want to associate with this project. Make sure this matches the application id and client key you entered in step 1!
6. Open the `main.js` file located in `/parse/cloud/` and enter your Twilio accout SID and auth token.
7. Run `parse deploy`. This will deploy the Cloud Code for this app.

For more information on installing and using Cloud Code and the Parse command line tool check out the [screencast][tutorial] for Cloud Code as well as the Cloud Code [documentation](https://www.parse.com/docs/cloud_code_guide).

[tutorial]: https://parse.com/tutorials/getting-started-with-cloud-code
[cloudModulesGuide]: https://parse.com/docs/cloud_modules_guide