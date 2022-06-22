import Foundation

extension KraftfulAnalytics {
  // A mock class used by tests to verify calls
  public class MockEventSender: EventSender {
    public var trackCalls: Array<MockTrackCall> = []
    public var identifyCalls: Array<MockIdentifyCall> = []
    
    public func track(name: String) {
      self.track(name: name, properties: String?.none)
    }
    
    public func track<P: Codable>(name: String, properties: P?) {
      trackCalls.append(MockTrackCall(
        name: name,
        properties: properties
      ));
    }
    
    public func identify(userId: String) {
      self.identify(userId: userId, traits: String?.none)
    }
    
    public func identify<T: Codable>(userId: String, traits: T?) {
      identifyCalls.append(MockIdentifyCall(
        userId: userId,
        traits: traits
      ));
    }

    public struct MockTrackCall {
      let name: String
      let properties: Codable
    }
    public struct MockIdentifyCall {
      let userId: String
      let traits: Codable
    }
  }
}
