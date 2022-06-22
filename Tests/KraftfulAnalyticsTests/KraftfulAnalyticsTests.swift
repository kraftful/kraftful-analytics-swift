import XCTest
@testable import KraftfulAnalytics

final class KraftfulAnalyticsTests: XCTestCase {
  var mockSender = KraftfulAnalytics.MockEventSender()

  override func setUpWithError() throws {
    mockSender = KraftfulAnalytics.MockEventSender()
    KraftfulAnalytics.initializeWith(sender: mockSender)
  }
  
  func testTrackSignIn() {
    KraftfulAnalytics.trackSignInStart();
    
    XCTAssertEqual(mockSender.trackCalls.count, 1, "Track was not called")
    XCTAssertEqual(mockSender.trackCalls[0].name, "Sign In Start", "Invalid event name for sign in start")
    
    let testUserId = "test-user-id"
    KraftfulAnalytics.trackSignInSuccess(userId: testUserId)
    
    XCTAssertEqual(mockSender.identifyCalls.count, 1, "Identify was not called")
    XCTAssertEqual(mockSender.identifyCalls[0].userId, testUserId, "Invalid userId")
    XCTAssertEqual(mockSender.trackCalls.count, 2, "Track was not called again")
    XCTAssertEqual(mockSender.trackCalls[1].name, "Sign In Success", "Invalid event name for sign in success")
  }
  
  func testTrackConnection() {
    KraftfulAnalytics.trackConnectionStart();
    
    XCTAssertEqual(mockSender.trackCalls.count, 1, "Track was not called")
    XCTAssertEqual(mockSender.trackCalls[0].name, "Connection Start", "Invalid event name for connection start")
    
    KraftfulAnalytics.trackConnectionSuccess()
    
    XCTAssertEqual(mockSender.trackCalls.count, 2, "Track was not called again")
    XCTAssertEqual(mockSender.trackCalls[1].name, "Connection Success", "Invalid event name for connection success")
  }
  
  func testTrackFeatureUse() {
    let testFeature = "Test Feature"
    KraftfulAnalytics.trackFeatureUse(feature: testFeature)
    
    XCTAssertEqual(mockSender.trackCalls.count, 1, "Track was not called")
    XCTAssertEqual(mockSender.trackCalls[0].name, testFeature, "Event name does not match track call")
  }
  
  func testTrackAppReturn() {
    let testUserId = "test-user-id-2"
    KraftfulAnalytics.trackAppReturn(userId: testUserId)
    
    XCTAssertEqual(mockSender.identifyCalls.count, 1, "Identify was not called")
    XCTAssertEqual(mockSender.identifyCalls[0].userId, testUserId, "Invalid userId")
    XCTAssertEqual(mockSender.trackCalls.count, 1, "Track was not called again")
    XCTAssertEqual(mockSender.trackCalls[0].name, "Return", "Invalid event name for return")
  }
}
