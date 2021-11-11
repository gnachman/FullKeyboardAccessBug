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

@interface MyView: NSView<NSTextInputClient, NSAccessibility>
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

#pragma mark - NSTextInputClient

- (void)insertText:(id)string replacementRange:(NSRange)replacementRange {
    NSLog(@"Insert %@", string);
}

- (void)doCommandBySelector:(SEL)selector {
    NSLog(@"do selector %@", NSStringFromSelector(selector));
}

- (void)setMarkedText:(id)string selectedRange:(NSRange)selectedRange replacementRange:(NSRange)replacementRange {
    NSLog(@"set marked text: %@", string);
}

- (void)unmarkText {
    NSLog(@"unmark text");
}

- (NSRange)selectedRange {
    return NSMakeRange(0, 0);
}

- (NSRange)markedRange {
    return NSMakeRange(NSNotFound, 0);
}

- (BOOL)hasMarkedText {
    return NO;
}


- (nullable NSAttributedString *)attributedSubstringForProposedRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    return [[NSAttributedString alloc] initWithString:@"" attributes:@{}];
}

- (NSArray<NSAttributedStringKey> *)validAttributesForMarkedText {
    return @[];
}

- (NSRect)firstRectForCharacterRange:(NSRange)range actualRange:(nullable NSRangePointer)actualRange {
    *actualRange = range;
    return NSMakeRect(10 * range.location, 0, 10 * range.length, 10);
}

- (NSUInteger)characterIndexForPoint:(NSPoint)point {
    return point.x / 10;
}

- (NSAttributedString *)attributedString {
    return [[NSAttributedString alloc] initWithString:@"" attributes:@{}];
}

- (CGFloat)fractionOfDistanceThroughGlyphForPoint:(NSPoint)point {
    return fmod(point.x, 10);
}

- (CGFloat)baselineDeltaForCharacterAtIndex:(NSUInteger)anIndex {
    return 0;
}

- (NSInteger)windowLevel {
    return self.window.level;
}

- (BOOL)drawsVerticallyForCharacterAtIndex:(NSUInteger)charIndex {
    return NO;
}

#pragma mark - NSAccessibility

- (BOOL)isAccessibilityElement {
    return YES;
}

- (NSRect)accessibilityFrame {
    return [self.window convertRectToScreen:[self convertRect:self.bounds toView:nil]];
}

- (BOOL)isAccessibilityFocused {
    return YES;
}

- (NSPoint)accessibilityActivationPoint {
    return [self.window convertPointToScreen:[self convertPoint:NSZeroPoint toView:nil]];
}

- (id)accessibilityTopLevelUIElement {
    return self.superview.accessibilityTopLevelUIElement;
}

- (NSURL *)accessibilityURL {
    return nil;
}

- (id)accessibilityValue {
    return @"";
}

- (NSString *)accessibilityValueDescription {
    return @"Accessibility value description";
}

- (NSArray *)accessibilityVisibleChildren {
    return @[];
}

- (NSAccessibilitySubrole)accessibilitySubrole {
    return NSAccessibilityUnknownSubrole;
}

- (NSString *)accessibilityTitle {
    return @"Accessibility title";
}

- (id)accessibilityTitleUIElement {
    return nil;
}

- (NSArray *)accessibilityNextContents {
    return nil;
}

- (NSAccessibilityOrientation)accessibilityOrientation {
    return NSAccessibilityOrientationHorizontal;
}

- (id)accessibilityOverflowButton {
    return nil;
}

- (id)accessibilityParent {
    return self.superview;
}

- (NSString *)accessibilityPlaceholderValue {
    return nil;
}

- (NSArray *)accessibilityPreviousContents {
    return nil;
}

- (NSAccessibilityRole)accessibilityRole {
    return NSAccessibilityTextAreaRole;
}

- (NSString *)accessibilityRoleDescription {
    return NSAccessibilityRoleDescriptionForUIElement(self);
}

- (id)accessibilitySearchButton {
    return nil;
}

- (id)accessibilitySearchMenu {
    return nil;
}

- (BOOL)isAccessibilitySelected {
    return NO;
}

- (NSArray *)accessibilitySelectedChildren {
    return nil;
}

- (NSArray *)accessibilityServesAsTitleForUIElements {
    return nil;
}

- (id)accessibilityShownMenu {
    return nil;
}

- (id)accessibilityMinValue {
    return nil;
}

- (id)accessibilityMaxValue {
    return nil;
}

- (NSArray *)accessibilityLinkedUIElements {
    return nil;
}

- (id)accessibilityWindow {
    return self.window;
}

- (NSString *)accessibilityIdentifier {
    return [NSString stringWithFormat:@"%p", self];
}

- (NSString *)accessibilityHelp {
    return @"Accessibility help";
}

- (NSString *)accessibilityFilename {
    return nil;
}

- (BOOL)isAccessibilityExpanded {
    return NO;
}

- (BOOL)isAccessibilityEdited {
    return NO;
}

- (BOOL)isAccessibilityEnabled {
    return YES;
}

- (NSArray *)accessibilityChildren {
    return @[];
}

- (NSArray<id<NSAccessibilityElement>> *)accessibilityChildrenInNavigationOrder {
    return @[];
}

- (id)accessibilityClearButton {
    return nil;
}

- (id)accessibilityCancelButton {
    return nil;
}

- (BOOL)isAccessibilityProtectedContent {
    return NO;
}

- (NSArray *)accessibilityContents {
    return nil;
}

- (NSString *)accessibilityLabel {
    return @"example";
}

- (BOOL)isAccessibilityAlternateUIVisible {
    return NO;
}

- (NSArray *)accessibilitySharedFocusElements {
    return @[];
}

- (BOOL)isAccessibilityRequired {
    return NO;
}

- (NSArray<NSAccessibilityCustomRotor *> *)accessibilityCustomRotors {
    return nil;
}

#pragma mark Accessibility: Text
- (NSInteger)accessibilityInsertionPointLineNumber {
    return 0;
}

- (NSRange)accessibilitySharedCharacterRange {
    return NSMakeRange(NSNotFound, 0);
}

- (NSArray *)accessibilitySharedTextUIElements {
    return @[];
}

- (NSRange)accessibilityVisibleCharacterRange {
    return NSMakeRange(0, 0);
}

- (NSInteger)accessibilityNumberOfCharacters {
    return 0;
}

- (NSString *)accessibilitySelectedText {
    return nil;
}

- (NSRange)accessibilitySelectedTextRange {
    return NSMakeRange(NSNotFound, 0);
}

- (NSArray<NSValue *> *)accessibilitySelectedTextRanges {
    return @[];
}

- (NSAttributedString *)accessibilityAttributedStringForRange:(NSRange)range {
    return [[NSAttributedString alloc] initWithString:@"" attributes:@{}];
}

- (NSRange)accessibilityRangeForLine:(NSInteger)line {
    return NSMakeRange(0, 0);
}

- (nullable NSString *)accessibilityStringForRange:(NSRange)range {
    return @"";
}

- (NSRange)accessibilityRangeForPosition:(NSPoint)point {
    return NSMakeRange(0, 0);
}

- (NSRange)accessibilityRangeForIndex:(NSInteger)index {
    return NSMakeRange(0, 0);
}

- (NSRect)accessibilityFrameForRange:(NSRange)range {
    return [self.window convertRectToScreen:[self convertRect:NSMakeRect(range.location * 10, 0, 10 * range.length, 10) toView:nil]];
}

- (nullable NSData *)accessibilityRTFForRange:(NSRange)range {
    return [NSData data];
}

- (NSRange)accessibilityStyleRangeForIndex:(NSInteger)index {
    return NSMakeRange(NSNotFound, 0);
}

- (NSInteger)accessibilityLineForIndex:(NSInteger)index {
    return 0;
}

@end
