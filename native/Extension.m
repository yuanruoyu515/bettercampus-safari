#import <Foundation/Foundation.h>

// Native messaging is not requested by this port. Complete unexpected native
// requests without forwarding page content to another process or service.
@interface SafariWebExtensionHandler : NSObject <NSExtensionRequestHandling>
@end
@implementation SafariWebExtensionHandler
- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context {
    [context completeRequestReturningItems:@[] completionHandler:nil];
}
@end
