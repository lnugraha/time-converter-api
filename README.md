## Time Converter API ##

## General Designs: ##
1. Design pattern: Model - View - Controller (MVC) as the system only handles two main functions: login and update
2. iOS: 14.7 and 15 Beta 6
3. Orientation supported: portrait and landscape (using auto layout mechanism from NSAutoLayout)
4. UI designs: using Swift
5. Logos and figures are derived from SF Symbols Pro that can be downloaded from Apple Developer Program

## Problems statements: ##

## Case 1: Login API ##
- Given username and password login credentials, design a login user interface that allows users to enter the system securely should the login credentials are accurate

- Designs:
- [ ] Create two textfields that accept username and password upon login to the system
- [ ] The system will show two errors: empty textfield or incorrect credentials, if users do not input correct information
- [ ] Once successfully login, only decipherable information will displayed to the main page

## Case 2: Update API Parameter(s) ##
- After logging in to the system, design a user interface that allows users to change or modify their time zone

- Designs:
- [ ] Upon login, the timezone that is initially fetched from web API will be displayed in the main page
- [ ] Users can modify their timezone by selecting the button at the bottom right corner
- [ ] Users can select any number from -12 to 12 as their timezone

## Results ##

1. Simulation Results using Xcode (Portrait Orientation)
<table>
  <tr> 
    <th> Xcode 12.5.1 (iPhone 12 Mini) </th> 
    <th> Xcode 13 Beta 5 (iPhone SE 2020) </th>
  </tr>
  <tr>
    <td> <img src="./figures/Simulation_iPhone_12_Mini.gif">
    <td> <img src="./figures/Simulation_iPhone_SE.gif">
  </tr>
</table>

2. Simulation Results using devices
<table>
  <tr> 
    <th> iOS 14.7.1 / iPhone 11 Pro </th> 
    <th> iOS 15 Beta 6 / iPhone 7 </th>
  </tr>
  <tr>
    <td> <img src="./figures/Simulation_iPhone_11_Pro.gif">
    <td> <img src="./figures/Simulation_iPhone_7.gif">
  </tr>
</table>
