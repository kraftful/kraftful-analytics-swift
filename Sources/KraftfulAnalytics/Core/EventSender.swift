import Foundation

// The interface for sending events
public protocol EventSender {
  func track(name: String) -> Void
  func track<P: Codable>(name: String, properties: P?) -> Void
  func identify(userId: String) -> Void
  func identify<T: Codable>(userId: String, traits: T?) -> Void
}
