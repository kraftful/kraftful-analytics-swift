import Segment

public struct KraftfulAnalytics {
  private static var analytics: Analytics? = nil

  /**
    Initializes the KraftfulAnalytics library using the supplied write key
    */
  public static func initialize(key: String) {
    let configuration = Configuration(writeKey: key)
      .trackApplicationLifecycleEvents(true)
      .flushInterval(10)
    analytics = Analytics(configuration: configuration)
  }

  /**
    Tracks a single feature use event
    */
  public static func trackFeatureUse(feature: String) {
    if let client = analytics {
      client.track(
        name: feature,
        properties: TrackFeatureUseProperties(
          kohortTrack: 1,
          kohortStepName: "Feature use",
          kohortFeature: feature
        ))
    }
  }

  /**
    Tracks the sign in start event
    */
  public static func trackSignInStart() {
    if let client = analytics {
      client.track(
        name: "Sign In Start",
        properties: TrackBaseProperties(
          kohortTrack: 1
        ))
    }
  }

  /**
    Tracks the sign in success event. Pass the userId to associate the events with a user.
    */
  public static func trackSignInSuccess(userId: String?) {
    if let client = analytics {
      if let userIdVal = userId {
        client.identify(userId: userIdVal)
      }
      client.track(
        name: "Sign In Success",
        properties: TrackBaseProperties(
          kohortTrack: 1
        ))
    }
  }

  /**
    Tracks the connection start event.
    */
  public static func trackConnectionStart() {
    if let client = analytics {
      client.track(
        name: "Connection Start",
        properties: TrackBaseProperties(
          kohortTrack: 1
        ))
    }
  }

  /**
    Tracks the connection success event
    */
  public static func trackConnectionSuccess() {
    if let client = analytics {
      client.track(
        name: "Connection Success",
        properties: TrackBaseProperties(
          kohortTrack: 1
        ))
    }
  }

  /**
    Tracks the return event and associates a user.
    */
  public static func trackAppReturn(userId: String?) {
    if let client = analytics {
      if let userIdVal = userId {
        client.identify(userId: userIdVal)
      }
      client.track(
        name: "Return",
        properties: TrackBaseProperties(
          kohortTrack: 1
        ))
    }
  }
}

struct TrackFeatureUseProperties: Codable {
  let kohortTrack: Int
  let kohortStepName: String
  let kohortFeature: String
}

struct TrackBaseProperties: Codable {
  let kohortTrack: Int
}
