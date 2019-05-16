# sei-project-2
GA SEI-19 Project 2 - House Keeper App

# Brief
Create an app where real estate agents and tenants can create/view maintenance requests for their current properties. The completed maintence is then saved to the property, so future tenants know about the properties history.

# Link to Website
https://hidden-reef-79978.herokuapp.com

# Planning
What the app needs:
  - User log in and account creation
    - Two types of users -> 'Agents' and 'Tenants'
  - User (agent and tenant) can add a property to their portfolio. The idea is that an Agent will have many properties that they are looking after. Tenants typically would have one.
  - User (agent and tenant) can submit requests for maintenance or even leave general comments (i.e. a review)
    - Requests are then checked off by both parties and the history is logged
    - Logged so that new renters can see what has been done
  - Rate the property
  - Rate the agent

# How was the app implemented?
HTML and CSS at the frontend. The backend of the app was driven by Ruby and PostgresQL using RESTful design techniques. Property data was acquire using the domain.com.au API 

# Challenges
API - Getting the API to authenticate. Eventually found example code written in Node and I had to convert this to Ruby
Planning - Given the amount of time (we had 2 days), I found myself overcommited to the number of features. This was due to underestimating the time taken to implement RESTful design for the first time. 

# Cool Tech
PostgresQL/Ruby - Keeping comments for each of the properties in the database.
Ruby - RESTful design
CSS/Ruby - Dashboard displays all the current properties within the user's portfolio 
CSS - Writing and displaying comments from all users for each property

# Future Implementations
- Finish the requirements outlined in the brief.
- Update CSS to make the UX more friendly

# sources
domain.com.au API (https://developer.domain.com.au)  

