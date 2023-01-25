# sample_for_interview
This repository I use this to show examples of my code and priciples that I use in my work.

The code is separated by layers and services and uses Clear scalable architecture. Also, the app uses an MVVM pattern for the visual part.

I have the next layers and services: 
- `APIClient` - responsible for communication between client and server and call any endpoints;
- `UsersApiService` - responsible for communication between client and server and call only users endpoints;
- `UsersService` - responsible for managing only users;
- `UserListView`, `UserDetailsView`, etc - responsible for the visual part.

I use dependency injections for each level. It helps make a scalable system and makes weak relations between components.
For example,
`UsersApiService` uses an APIClient object that communicates with the server or we can create another object `LocalAPIClient` that will implement `APIClientProtocol` and this object will work with local files or use another server.

`UsersService` uses `UsersApiService` that make backend requests, but we can have another object that implements `UsersApiServiceProtocol` and it will have cached data or use local storage or work with different data, like XML.

`UserListView` have `ViewModel` and it uses `UsersService` but can use another object that implements `UsersServiceProtocol` and this object will work with a database, merge some data from different endpoints, make some processing, and something else.

At the same time, we don't know anything inside the implementation of this object, but if they match `protocol` then we can use it and switch implementation at any time.

Also, the project has Unit Tests and dependency injections able to make Mock object, and we can implement an automatic unit test of each module of the app. It will help when we will refactor the code and we can test the app during the automatic deployment process and we will see issues at the early state and fix it immidiately. 

## Visual part

For visualisation I use SwiftUI. I use ViewModel to control the view part. ViewModel implements business logic, like loading data, and controls the state of some views. View just show this data and react of states. It helps test UI too. Because, UI should show only ViewModel data. Also, it helps faster find bugs and fix it.

If you have further questions, you always can write to me:
glushchenko2003@gmail.com
https://upwork.com/freelancers/shlushchenko
