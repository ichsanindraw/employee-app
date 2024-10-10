# Employee App

The **Employee App** allows users to view a list of employees, filter employees by type, and mock API responses to simulate different scenarios (success, empty, and error). The app is built using **SwiftUI**, **Combine**, **Moya**, and **Kingfisher**.

## Features

- **Employee List**: View a list of employees fetched from the API.
- **Filter by Employee Type**: Tap the filter icon on the top-right of the navigation bar to filter employees based on their type.
- **Mock API Responses**: Tap the gear icon on the top-left of the navigation bar to mock different responses:
  - Success
  - Empty
  - Error

## Mocking API Responses

To simulate different API responses (Success, Empty, and Error), you need to configure the following environment variables in the `Prod.xcconfig` file:

```bash
SUCCESS_API_URL = <Your success API endpoint> 
EMPTY_API_URL = <Your empty API endpoint> 
ERROR_API_URL = <Your error API endpoint>
```

Make sure to provide valid URLs for each scenario in the `Prod.xcconfig` file.

## Dependencies

The following libraries are used in the project:

- **[SwiftUI](https://developer.apple.com/xcode/swiftui/)**: For building the user interface.
- **[Combine](https://developer.apple.com/documentation/combine/)**: For handling asynchronous data streams.
- **[Moya](https://github.com/Moya/Moya)**: For network abstraction.
- **[Kingfisher](https://github.com/onevcat/Kingfisher)**: For downloading and caching images.

## Setup Instructions

1. Clone the repository.
2. Open the project in Xcode.
3. Configure the API URLs in `Prod.xcconfig` as shown above.
4. Build and run the app on your simulator or device.

## Screenshots

*(Include screenshots if available)*

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.