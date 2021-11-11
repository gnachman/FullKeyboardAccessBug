//
//  AppDelegate.m
//  FullKeyboardAccessBug
//
//  Created by George Nachman on 11/9/21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end

@interface MyView: NSView
@end

@implementation MyView

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor whiteColor] set];
    NSRectFill(self.bounds);
    if (self.window.firstResponder == self) {
        [[NSColor redColor] set];
    } else {
        [[NSColor blackColor] set];
    }
    NSFrameRect(self.bounds);
}

- (BOOL)becomeFirstResponder {
    NSLog(@"become first responder");
    [self setNeedsDisplay:YES];
    return YES;
}

- (BOOL)resignFirstResponder {
    NSLog(@"resign first responder");
    [self setNeedsDisplay:YES];
    return YES;
}

- (BOOL)canBecomeKeyView {
    return YES;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)keyDown:(NSEvent *)event {
    NSLog(@"%@", event);
    [self interpretKeyEvents:@[event]];
}

@end
