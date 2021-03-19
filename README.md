# PGMessengerApp
### Défi de PurpleGiraffe - Mars 2021

Application SwiftUI

### Personalisation:

```
struct Secrets {
    struct Server {
        static let serverProtocol = [String]    // "http", "https", etc...
        static let hostname = [String]          // "website.com"
        static let port = [Int]                 // 80, 443, etc...
    }
}
```

### Working:

[x] create new user
[x] login with user
[x] get all messages

### To Do:

[ ] retrieve own user
[ ] post new message
[ ] integrate WebSocket
[ ] sort messages by date
