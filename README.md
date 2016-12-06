
## Explore and Save Events in any City!

### Overview

This app is live at eventext.herokuapp.com

"EvenText" is a web application build on the Ruby on Rails framework. Users can log on and search for nearby events and save selected events to their bookmarks. Once saved to their bookmarks, users can save any bookmark as a reminder and "EvenText" will text them their reminder a certain amount of time before the event. Ultimately, users of "EvenText" will save data and not worry about looking up their day to day plans.

### How it works
On login, users get the chance to add an avatar to their profile. After that, they may either want to schedule a reminder right away or search for events from the Eventbrite API. Any of these results can be saved as a "Bookmark" for later viewing. Bookmarks can be saved as reminders to generate SMS reminders by POSTing to the Twilio REST API. There is currently a rate limit on the number of requests. 

##### Caveats:  
The lack of a solid, customizable (to-the-user) time zone switch. Any cities with a space in the name potentially will get a 500 Error from the server.

### Future Steps
- Add on the social aspect of the app by introducing a comment model.
- Include an API which provides visual feedback for geographical locations.

#### Gems & Specs
- delayed_job (4.1.1)
- delayed_job_active_record (4.1.0)
- pry-rails (0.3.4)
- puma (2.15.3)
- ruby (2.0.0)
- shoulda-matchers (3.1.0)
- simple_form (3.2.1)
- twilio-ruby (4.9.0)
- uploadcare-rails (1.0.6)

### Background Resources
- [Eventbrite](http://developer.eventbrite.com/)