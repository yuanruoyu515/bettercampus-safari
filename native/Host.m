#import <Cocoa/Cocoa.h>
#import <SafariServices/SafariServices.h>

static NSString * const ExtensionIdentifier = @"local.bettercampus.safariport.Extension";

@interface BetterCampusAppDelegate : NSObject <NSApplicationDelegate>
@property(strong) NSWindow *window;
@property(strong) NSTextField *status;
@end

@implementation BetterCampusAppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSMenu *menu = [NSMenu new];
    NSMenuItem *appItem = [NSMenuItem new];
    NSMenu *appMenu = [NSMenu new];
    [appMenu addItemWithTitle:@"退出 BetterCampus Safari" action:@selector(terminate:) keyEquivalent:@"q"];
    appItem.submenu = appMenu;
    [menu addItem:appItem];
    NSApp.mainMenu = menu;

    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 560, 320)
        styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable
        backing:NSBackingStoreBuffered defer:NO];
    self.window.title = @"BetterCampus Safari";
    self.window.releasedWhenClosed = NO;
    NSView *content = self.window.contentView;
    NSTextField *title = [NSTextField labelWithString:@"BetterCampus Safari"];
    title.font = [NSFont boldSystemFontOfSize:25];
    title.frame = NSMakeRect(30, 254, 500, 40);
    [content addSubview:title];

    NSTextField *detail = [NSTextField wrappingLabelWithString:
        @"本机安装版 9.8.15.1\n\n扩展随此应用保留，不会按临时扩展的规则自动删除。请保留此应用，并在 Safari 的扩展设置中启用它。\n\n当前为本地签名：退出并重新打开 Safari 后，仍需重新允许未签名扩展。Apple 开发者签名可解决这一限制。"];
    detail.font = [NSFont systemFontOfSize:14];
    detail.frame = NSMakeRect(30, 99, 500, 148);
    [content addSubview:detail];

    NSButton *settings = [NSButton buttonWithTitle:@"打开 Safari 扩展设置" target:self action:@selector(openSettings:)];
    settings.frame = NSMakeRect(26, 48, 210, 34);
    settings.bezelStyle = NSBezelStyleRounded;
    [content addSubview:settings];

    NSButton *check = [NSButton buttonWithTitle:@"检查启用状态" target:self action:@selector(checkState:)];
    check.frame = NSMakeRect(242, 48, 150, 34);
    check.bezelStyle = NSBezelStyleRounded;
    [content addSubview:check];

    self.status = [NSTextField labelWithString:@"正在检查扩展状态…"];
    self.status.font = [NSFont systemFontOfSize:12];
    self.status.textColor = NSColor.secondaryLabelColor;
    self.status.frame = NSMakeRect(30, 18, 500, 24);
    [content addSubview:self.status];

    [self.window center];
    [self.window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
    [self checkState:nil];
}
- (void)openSettings:(id)sender {
    [SFSafariApplication showPreferencesForExtensionWithIdentifier:ExtensionIdentifier completionHandler:^(NSError *error) {
        if (error) dispatch_async(dispatch_get_main_queue(), ^{
            self.status.stringValue = @"请在 Safari → 设置 → 扩展中找到 BetterCampus。";
        });
    }];
}
- (void)checkState:(id)sender {
    [SFSafariExtensionManager getStateOfSafariExtensionWithIdentifier:ExtensionIdentifier completionHandler:^(SFSafariExtensionState *state, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.status.stringValue = error ? @"扩展尚未就绪，请打开 Safari 的扩展设置。" :
                state.enabled ? @"Safari 扩展已启用。" : @"扩展已安装，等待在 Safari 中启用。";
        });
    }];
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender { return YES; }
@end

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        BetterCampusAppDelegate *delegate = [BetterCampusAppDelegate new];
        app.delegate = delegate;
        [app setActivationPolicy:NSApplicationActivationPolicyRegular];
        [app run];
    }
    return 0;
}
