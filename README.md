# NewsApp




## Architecture
The Project built on [Clean Swift architure](https://clean-swift.com).
![alt text](http://clean-swift.com/wp-content/uploads/2015/08/VIP-Cycle.png)

## SOLID
The Project is implementing the SOLID principles in all its cycle.

## Multi Environments
There are 3 environments in the project
- Development
- Release
- Staging

each enviroment has its own scheme, configuration and the corresponding environmental variables are saved in the EnvironmentVariables.plist and it's all managed in the EnvironmentManager.swift.

## UI
The UI is responsive and support Multi Orientation + Dark and Light modes. It's made in UIKit and using NIB files for fast development.
The views are based on UIStackViews. The animitations are powered by Lottie since it has wide resources and the files sizes are low.
I was going to use SwiftUI since it's the latest technology, but the Job Description I'm applying for mentioned having knowledge in UIKit so I decided to focus on demonstrating my skills on it.

## Reusability
as part of the architure, the project compenents are highly losed which makes them reusable.

## Data Source
### Remote
The project uses NYTimes API as required.

### Local
The database used in the project is Realm Swift (https://realm.io/realm-swift)
the reason behind that is the impelementaion of realm database is faster than CoreData and there is no big differences on the
stability between the 2 databases, so I followed the system design role that's says 
"always use the use the minimum if it serve the requirements". if the database contained complecated data and refrences, then CoreData
would be more useful.

## CI/CD
The Github repository has 2 workflows;
- the development workflow got triggered when there is a push or a pull requests to the development scheme, it builds, runs 
UI and Unit tests on the Dev environment (using its scheme).
- the main one which is get triggered from the pull requests and pushes to the main branch, it uses the release scheme for build,
unit test, and UI testing. Currently there is no deploy to Appstore since the project isn't in the Appstore.

## Automated Tests
The project contains UITests and Unit Tests.
the coverage is 68.5%

## Design pattern
These are examples for design patterns used in the app and not included to:
### Singleton
example for its usage in the app: EnvironmentManager
### Factory
example for its usage in the app: ServicesFactory
### Bridge
example for its usage in the app: Configuration elements
### Facade
example for its usage in the app: Interactor elements
