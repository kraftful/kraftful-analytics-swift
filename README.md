# Kraftful Analytics for Swift

## Setup

Add the package as a dependency;

1. File > Add Packages...
2. Enter package url: `git@github.com:kraftful/kraftful-analytics-swift.git`
3. Import; `import KraftfulAnalytics`

## Usage

The KraftfulAnalytics API exposes the following methods:

### `initialize(writeKey: String)`

Add the initialize call to your App's `init()` method.

```swift
struct ExampleApp: App {
    init() {
        KraftfulAnalytics.initialize(writeKey: "YOUR-WRITE-KEY")
    }

    var body: some View { .... }
}
```

### `trackSignInStart()` and `trackSignInSuccess(userId: String?)`

Add the `trackSignIn(...)` calls to your login and registration flows. Typically the start call happens when your login/register screen loads and the success call happens when the user successfully logs in/registers.

```swift
struct SignInView: View {
    var body: some View {
        ScrollView {
          ... *snip* ...
        }
        .onAppear() {
          // Call trackSignInStart when this page is appears
          KraftfulAnalytics.trackSignInStart()
        }
        .navigationTitle("Sign In")
    }
}
```

```swift
struct SignInView: View {
    var body: some View {
        ScrollView {
            VStack {
                ... *snip* ...
                Button(action: {
                    let success = appState.signIn(username: username, password: password)
                    if (!success) {
                        loginError = "Unable to login with those credentials"
                    } else {
                        // Call trackSignInSuccess when the user is authenticated
                        KraftfulAnalytics.trackSignInSuccess(userId: appState.loggedInUserId)
                        loginError = ""
                    }
                }) {
                    Text("Login!")
                }
                ... *snip* ...
            }
        }
        .navigationTitle("Sign In")
    }
}
```

### `trackConnectionStart()` and `trackConnectionSuccess()`

Add the `trackConnection(...)` calls to your device connection flows. Similar to the sign in tracking, these are typically added when the first screen in your device connection flow loads and then is successfully connected.

```swift
struct ConnectionStartView: View {
    var body: some View {
        ScrollView {
          ... *snip* ...
        }
        .onAppear() {
          // Call trackConnectionStart when this page is appears
          KraftfulAnalytics.trackConnectionStart()
        }
        .navigationTitle("Connection Start")
    }
}
```

```swift
struct SignInView: View {
    var body: some View {
        ScrollView {
            VStack {
                ... *snip* ...
                Button(action: {
                    let connected = appState.connectDevice(token: token)
                    if (!connected) {
                        connectError = "Unable to connect device"
                        connectSuccess = false
                    } else {
                        // Call trackConnectionSuccess when the device is connected
                        KraftfulAnalytics.trackConnectionSuccess()
                        connectError = ""
                        connectSuccess = true
                    }
                }) {
                    Text("Connect!")
                }
                ... *snip* ...
            }.padding()
        }
        .navigationTitle("Connection Start")
    }
}
```

### `trackFeatureUse(feature: String)`

Add `trackFeatureUse(...)` calls to the features you want to track. Here we're adding the calls to some Button actions.

```swift
struct HomeDeviceView: View {
    var body: some View {
        ScrollView {
            ... snip ...
            VStack {
                Text("Setpoint")
                    .padding(.bottom, 10)
                HStack {
                    Button(action: {
                        appState.changeSetpoint(increment: -1)
                        // Track decreasing the temperature setpoint
                        KraftfulAnalytics.trackFeatureUse(feature: "Decrease Setpoint")
                    }) {
                        Text("-")
                            .font(.largeTitle)
                            .padding(.bottom, 12)
                            .padding(.trailing, 20)
                    }
                    Text("\(formatter.string(from: appState.deviceSetpoint as NSNumber) ?? "?")°")
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .font(.largeTitle)
                        .frame(width: 100, alignment: .center)
                    Button(action: {
                        appState.changeSetpoint(increment: 1)
                        // Track increasing the temperature setpoint
                        KraftfulAnalytics.trackFeatureUse(feature: "Increase Setpoint")
                    }) {
                        Text("+")
                            .font(.largeTitle)
                            .padding(.bottom, 12)
                            .padding(.leading, 20)
                    }
                }
            }
        }
    }
}
```

### `trackAppReturn(userId: String?)`

Add `trackAppReturn(...)` calls when your app is foregrounded. This should be done where you rehydrate your user information so you can pass the logged in userId if they are already logged in.

```swift
struct ExampleApp: App {
    var body: some Scene {
      WindowGroup {
          ContentView()
              .onAppear {
                  // Load app state when foregrounded
                  AppState.load { result in
                      switch result {
                      case .failure(let error):
                          fatalError(error.localizedDescription)
                      case .success(let data):
                          state.fromData(data: data)
                          // Track return with the logged in userId
                          KraftfulAnalytics.trackAppReturn(userId: state.loggedInUserId)
                      }
                  }
              }
        }
    }
}```

## License

```
MIT License

Copyright (c) 2022 Kraftful

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
