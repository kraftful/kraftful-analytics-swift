import Foundation
import Segment

extension KraftfulAnalytics {
  // An EventSender implementation for Segment
  public class SegmentEventSender: EventSender {
    private var analytics: Analytics;

    init(key: String) {
      let configuration = Configuration(writeKey: key)
        .trackApplicationLifecycleEvents(true)
        .flushInterval(10)
      
      analytics = Analytics(configuration: configuration)
    }

    public func track(name: String) {
      analytics.track(name: name)
    }
    
    public func track<P: Codable>(name: String, properties: P?) {
      analytics.track(name: name, properties: properties)
    }
    
    public func identify(userId: String) {
      analytics.identify(userId: userId)
    }
    
    public func identify<T: Codable>(userId: String, traits: T?) {
      analytics.identify(userId: userId, traits: traits)
    }
  }
}
