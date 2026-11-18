# PGMessengerApp

A SwiftUI client for [CloudMessengerAPI](https://github.com/cedric06nice/CloudMessengerAPI), the group messaging API I built with two other students for a [Purple Giraffe](https://www.purplegiraffe.fr) team challenge in March 2021.

## Features

- [x] Create an account
- [x] Log in, with the session token stored for later requests
- [x] Load all messages
- [ ] Load my own profile
- [ ] Post a message
- [ ] Live updates over WebSocket
- [ ] Sort messages by date

The unticked items were not finished within the challenge.

## Structure

- `Models/`: users, messages and session state, as `ObservableObject` managers that the views observe.
- `Controllers/`: one API client per resource (users, messages) built on a shared `ApiController` using `URLSession` and `Codable`.
- `Views/`: login, registration, profile and message list in SwiftUI.

## Run it

Add a `Secrets` struct pointing at your API server, then open `PGMessengerApp.xcodeproj` in Xcode:

```swift
struct Secrets {
    struct Server {
        static let serverProtocol = "http"
        static let hostname = "127.0.0.1"
        static let port = 8080
    }
}
```

---

Cedric Pugnaire · Software Developer · [cedric06nice.com](https://cedric06nice.com) · [CV](https://cedric06nice.com/cv) · [GitHub](https://github.com/cedric06nice)
