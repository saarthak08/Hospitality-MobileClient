# Hospitality
<img src="https://user-images.githubusercontent.com/38679082/79780084-03f5f480-8359-11ea-8083-399d62bf484e.png" alt="Login Activity" width="250"/>

A mobile application backed by [Hospitality-Backend](https://github.com/Bhanups123/Hospitality-Backend) which can be used to find out the nearest hospitals to you in a specific given input range and can be used to check the statistics and the availabilities of the hospitals. Moreover, users can also book appointments with respective hospitals.


### [Hospitality-Backend](https://github.com/Bhanups123/Hospitality-Backend)


## How it works?
- It is a two-faced application i.e. there are two clients: `Hospital` & `Patient`. 
- Both hospitals and users will signup and provide their locations to the application.
- When a user will provide an input distance to the app, our algorithm will find out the nearest hospitals to him/her within the provided input distance.
- Hospitals will have to update their statistics (like total beds, available beds, total doctors, available doctors, hospital availability etc)  regularly.
- Users can check out the hospitals' stats and can request for an appointment booking with the hospital as per the hospital availability stats provided by the hospital.
- Hospitals will response to these bookings as per their availability and convenience.


## Features:
- Search hospitals near you with the help of our custom algorithm.
- Get the location of the hospitals on Google Maps.
- JWT-Token-based authentication system.
- Request for appointment booking and track the appointment status.


## Tech-Stack Used:
- [Flutter](https://flutter.dev/) for mobile application development.
- [Node.js](https://nodejs.org/en/) for backend development.
- [Google Maps API](https://developers.google.com/maps/documentation) for showing the hospitals' search result on Google Maps.
- [Docker](https://www.docker.com/) for development and deployment purposes.
- [SendGrid](https://app.sendgrid.com) for SMTP purposes.


## Note:
- To build this mobile application, follow the steps below:
- - Create a system environment variable with name `HOSPITALITY_MAPS_API_KEY` and with value `YOUR OWN GOOGLE MAPS API KEY`.
- - Create a file named `network_config.dart` and place it in `lib/src/resources/network/` directory. Then, create a String variable with name `baseURL` and value `http://`YOUR_IP_ADDRESS`:`PORT_ON_WHICH_SERVER_IS_RUNNING(DEFAULT:5000)
- - So, your `network_config.dart` will look something like: `final String baseURL="http://192.168.43.193:5000;"`.
- - For iOS, replace `API_KEY` with your own Google Maps API key on line number `12` in `ios/Runner/AppDelegate.swift` file.


### Debug-APK Link:
[https://drive.google.com/open?id=1eyAGqp4zjYITElKuhWG3Ecbcri86Kd9H]


## Screenshots:
<img src="https://user-images.githubusercontent.com/38679082/79782131-32290380-835c-11ea-9c73-8ff7b1d8cb25.jpg" alt="Input Distance" width="200"/> .    <img src="https://user-images.githubusercontent.com/38679082/79781433-16712d80-835b-11ea-82b2-d8d2b36ceafc.jpg" alt="Hospitals Search Result" width="200"/> .    <img src="https://user-images.githubusercontent.com/38679082/79782109-28070500-835c-11ea-9dcd-3384ad214bb7.jpg" alt="MapView" width="200"/> .    <img src="https://user-images.githubusercontent.com/38679082/79782097-23425100-835c-11ea-8565-408f81827c75.jpg" alt="Hospital-Info" width="200"/> .    <img src="https://user-images.githubusercontent.com/38679082/79782136-348b5d80-835c-11ea-8db7-62b0bb8e240d.jpg" alt="Statistics" width="200"/> .    <img src="https://user-images.githubusercontent.com/38679082/79782125-305f4000-835c-11ea-848a-a51d34b456a8.jpg" alt="ProfileEdit" width="200"/> .    <img src="https://user-images.githubusercontent.com/38679082/79782090-1faeca00-835c-11ea-8a8d-391b85829e13.jpg" alt="AppointmentsList" width="200"/> .    <img src="https://user-images.githubusercontent.com/38679082/79782076-1a517f80-835c-11ea-8896-28d86bac9af9.jpg" alt="AppointmentsInfo" width="200"/> .    

