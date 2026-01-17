# Weather App - User Guide

This application allows you to save a location and view its current and 16-day weather forecast using [Open Meteo](https://open-meteo.com/en/docs)'s weather API.

## How to Use the App:

1. Load the website:  
   Website not hosted, clone this repo, setup an instance and run the server using **rails s**.

2. Enter a **name** for your location  
   This is a custom label and does not need to match the actual location—get creative!

3. Enter an **address** for your location.  
   This value is used to determine the latitude and longitude for the weather data; this can be an IP address too.

4. Click **Create Location**

5. Once created, the location will appear in the sidebar (typically at the bottom, though locations may be sorted on reload).

6. Click on a location in the sidebar to load its weather data.  
   Depending on network speed, loading may take a few seconds.

7. You may create multiple locations with different names and locations, or duplicates—we won’t stop you!

8. To remove a location, click the **Delete** button.  
   The location will be immediately removed from both the sidebar and the database.  
   ⚠️ Deletion is permanent and cannot be undone; there is **no confirmation** before deletion.

9. You can switch between locations at any time by selecting a different one in the sidebar.

## Notes
- Weather and location data is fetched from third-party APIs and may be unavailable if the service is down or rate-limited.
- Styling and functionality are minimal due to time constraints.

## Tech Stack
- Ruby on Rails 8
- Turbo and Stimulus
- RSpec
- fly.io (host)



# API's
- [Ip Api](https://ipapi.co/)
- [Geo Code Api](https://geocode.xyz/api)
- [Open Meteo Api](https://open-meteo.com/en/docs)


# Time:
- A little **over 12** hours was used for the inital portion, which included the main assignment and bonus #2.
- I wanted to complete bonus #1 and #3, so I did so outside the 12 hours spending **3** hrs. To show you what was written afterwards I ensured all code was commited before I began this, every commit hence thereafter will include **"[POST-LIMIT]"** before my commit message indicating this was written in my addational time.
- I achived bonus #1 in **30 minutes**, unfortunatly I was unable to solve errors while attempting #3 over the 2.5 hours, that I ran out of time I had free for the week.