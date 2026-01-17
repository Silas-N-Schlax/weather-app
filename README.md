

# Weather App - User Guide

This applicaiton alows you to save a locaiton and view their current and 16-day weather forcast using [Open Meteo](https://open-meteo.com/en/docs)'s weather Api.

## How to Use the App:

1. Load the website:
    **(url)**

2. Enter a **name** for your location
    This is a custom label and does not need to match the actual location, get creative!

3. Enter an **address** for your location.
    This value is used to determine the latitude and longitude for the weather data, this can be an IP address too.

4. Click **Create Location**

5. Once created, the locaiton will appear in the sidebar (typically at the bottom, thought locations may be sorted on reload).

6. Click on a location in the sidebar to load its weather data.
    Depending on network speed, loading may take a few seconds or moments.

7. You may create multiple locations with different names and locations, or duplicates, we wont stop you!

8. To remove a locaiton, click the **Delete** button.
    The location will be immediately removed from botht eh sidebard and the database.
    ⚠️ Deletion is permanent and cannot be undone, there is **no confimation** before deletion.

9. You can switch between locations at any time by selectin a different one in the sidebar.


## Notes
- Weather and locaiton data is fetched form third-party APIs and may be unaviable if the server is down or rate limited.
- Styling and functionality is minimal due to time constraints.

# Tech Stack
- Ruby on Rails 8
- Turbo and Stimilus
- Rspec
- fly.io (host)


# API's
- [Ip Api](https://ipapi.co/)
- [Geo Code Api](https://geocode.xyz/api)
- [Open Meteo Api](https://open-meteo.com/en/docs)