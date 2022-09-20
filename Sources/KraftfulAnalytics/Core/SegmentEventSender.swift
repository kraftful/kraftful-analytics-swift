import Foundation
import Segment

extension KraftfulAnalytics {

  // An EventSender implementation for Segment
  public class SegmentEventSender: EventSender {
    static let KRAFTFUL_INGESTION_URL = "analytics-ingestion.kraftful.com";
    private var analytics: Analytics;

    init(apiKey: String) {
      let configuration = Configuration(writeKey: apiKey)
        .trackApplicationLifecycleEvents(true)
        .flushInterval(10)
        .apiHost(Self.KRAFTFUL_INGESTION_URL)
      
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
