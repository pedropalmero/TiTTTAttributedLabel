/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComCodingpieTitttattributedlabelLabel.h"
#import "TiUtils.h"
#import "UIImage+Resize.h"
#import <MapKit/MapKit.h>

@implementation ComCodingpieTitttattributedlabelLabel

#pragma mark Internal

-(id)init
{
    if (self = [super init]) {
        bgdLayer = nil;
        padding = CGRectZero;
        initialLabelFrame = CGRectZero;
        verticalAlign = -1;
    }
    return self;
}

-(void)dealloc
{
    RELEASE_TO_NIL(label);
    RELEASE_TO_NIL(bgdLayer);
    [super dealloc];
}

-(CGSize)sizeForFont:(CGFloat)suggestedWidth
{
	NSString *value = [label text];
	UIFont *font = [label font];
	CGSize maxSize = CGSizeMake(suggestedWidth<=0 ? 480 : suggestedWidth, 10000);
	CGSize shadowOffset = [label shadowOffset];
	requiresLayout = YES;
	if ((suggestedWidth > 0) && [value hasSuffix:@" "]) {
		// (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(UILineBreakMode)lineBreakMode method truncates
		// the string having trailing spaces when given size parameter width is equal to the expected return width, so we adjust it here.
		maxSize.width += 0.00001;
	}
    
    CGSize size;
    
    if ([value respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        CGRect textRect = [value boundingRectWithSize:maxSize
                                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                           attributes:@{NSFontAttributeName:font}
                                              context:nil];
        size = textRect.size;
        size.height += [[label font] pointSize];
    } else {
        size = [value sizeWithFont:font constrainedToSize:maxSize lineBreakMode:UILineBreakModeTailTruncation];
    }
    
	if (shadowOffset.width > 0)
	{
		// if we have a shadow and auto, we need to adjust to prevent
		// font from clipping
		size.width += shadowOffset.width + 10;
	}
	return size;
}

-(CGFloat)contentWidthForWidth:(CGFloat)suggestedWidth
{
	return [self sizeForFont:suggestedWidth].width;
}

-(CGFloat)contentHeightForWidth:(CGFloat)width
{
	return [self sizeForFont:width].height;
}

-(void)padLabel
{
    if (verticalAlign != -1) {
        CGSize actualLabelSize = [self sizeForFont:initialLabelFrame.size.width];
        CGFloat originX = 0;
        switch (label.textAlignment) {
            case UITextAlignmentRight:
                originX = (initialLabelFrame.size.width - actualLabelSize.width);
                break;
            case UITextAlignmentCenter:
                originX = (initialLabelFrame.size.width - actualLabelSize.width)/2.0;
                break;
            default:
                break;
        }
        
        if (originX < 0) {
            originX = 0;
        }
        CGRect labelRect = CGRectMake(originX, 0, actualLabelSize.width, actualLabelSize.height);
        switch (verticalAlign) {
            case UIControlContentVerticalAlignmentBottom:
                labelRect.origin.y = initialLabelFrame.size.height - actualLabelSize.height;
                break;
            case UIControlContentVerticalAlignmentCenter:
                labelRect.origin.y = (initialLabelFrame.size.height - actualLabelSize.height)/2;
                if (labelRect.origin.y < 0) {
                    labelRect.size.height = (initialLabelFrame.size.height - labelRect.origin.y);
                }
                break;
            default:
                if (initialLabelFrame.size.height < actualLabelSize.height) {
                    labelRect.size.height = initialLabelFrame.size.height;
                }
                break;
        }
        
        [label setFrame:CGRectIntegral(labelRect)];
    }
    else {
        [label setFrame:initialLabelFrame];
    }
    
    if (bgdLayer != nil && !CGRectIsEmpty(initialLabelFrame))
    {
        [self updateBackgroundImageFrameWithPadding];
    }
	return;
}

// FIXME: This isn't quite true.  But the brilliant soluton wasn't so brilliant, because it screwed with layout in unpredictable ways.
//	Sadly, there was a brilliant solution for fixing the blurring here, but it turns out there's a
//	quicker fix: Make sure the label itself has an even height and width. Everything else is irrelevant.
-(void)setCenter:(CGPoint)newCenter
{
	[super setCenter:CGPointMake(floorf(newCenter.x), floorf(newCenter.y))];
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	initialLabelFrame = bounds;
    
    [self padLabel];
    
    [super frameSizeChanged:frame bounds:bounds];
}

-(TTTAttributedLabel*)label
{
	if (label==nil)
	{
        label = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.delegate = self;
        
        [self addSubview:label];
        //        self.clipsToBounds = YES;
	}
	return label;
}

- (id)accessibilityElement
{
	return [self label];
}

-(void)setHighlighted:(BOOL)newValue
{
	[[self label] setHighlighted:newValue];
}

- (void)didMoveToSuperview
{
	/*
	 *	Because of how we re-use the same cells in both a tableview and its
	 *	search table, there is the chance that the label is transported between
	 *	the two views before a selected search row is deselected. In other
	 *	words, make sure we're not highlighted when changing superviews.
	 */
	[self setHighlighted:NO];
	[super didMoveToSuperview];
}

- (void)didMoveToWindow
{
    /*
     * See above
     */
    [self setHighlighted:NO];
    [super didMoveToWindow];
}

-(BOOL)isHighlighted
{
	return [[self label] isHighlighted];
}

#pragma mark Public APIs

-(void)setVerticalAlign_:(id)value
{
    verticalAlign = [TiUtils intValue:value def:-1];
    if (verticalAlign < UIControlContentVerticalAlignmentCenter || verticalAlign > UIControlContentVerticalAlignmentBottom) {
        verticalAlign = -1;
    }
    if (label != nil) {
        [self padLabel];
    }
}
-(void)setText_:(id)text
{
	[[self label] setText:[TiUtils stringValue:text]];
    [self padLabel];
	[(TiViewProxy *)[self proxy] contentsWillChange];
}

-(void)setColor_:(id)color
{
	UIColor * newColor = [[TiUtils colorValue:color] _color];
	[[self label] setTextColor:(newColor != nil)?newColor:[UIColor darkTextColor]];
    [[self label] setText:[[self label] text]];
}

-(void)setHighlightedColor_:(id)color
{
	UIColor * newColor = [[TiUtils colorValue:color] _color];
	[[self label] setHighlightedTextColor:(newColor != nil)?newColor:[UIColor lightTextColor]];
    [[self label] setText:[[self label] text]];
}

-(void)setFont_:(id)font
{
	[[self label] setFont:[[TiUtils fontValue:font] font]];
	[(TiViewProxy *)[self proxy] contentsWillChange];
}

-(void)setMinimumFontSize_:(id)size
{
    CGFloat newSize = [TiUtils floatValue:size];
    if (newSize < 4) { // Beholden to 'most minimum' font size
        [[self label] setAdjustsFontSizeToFitWidth:NO];
        [[self label] setMinimumFontSize:0.0];
        [[self label] setNumberOfLines:0];
    }
    else {
        [[self label] setNumberOfLines:1];
        [[self label] setAdjustsFontSizeToFitWidth:YES];
        [[self label] setMinimumFontSize:newSize];
    }
    
}

-(CALayer *)backgroundImageLayer
{
    if (bgdLayer == nil)
    {
        bgdLayer = [[CALayer alloc]init];
        bgdLayer.frame = self.layer.bounds;
        [self.layer insertSublayer:bgdLayer atIndex:0];
    }
	return bgdLayer;
}
-(void) updateBackgroundImageFrameWithPadding
{
    CGRect backgroundFrame = CGRectMake(self.bounds.origin.x - padding.origin.x,
                                        self.bounds.origin.y - padding.origin.y,
                                        self.bounds.size.width + padding.origin.x + padding.size.width,
                                        self.bounds.size.height + padding.origin.y + padding.size.height);
    [self backgroundImageLayer].frame = backgroundFrame;
}

-(void)setBackgroundImage_:(id)url
{
    [super setBackgroundImage_:url];
}

-(void)setBackgroundPaddingLeft_:(id)left
{
    padding.origin.x = [TiUtils floatValue:left];
    [self updateBackgroundImageFrameWithPadding];
}

-(void)setBackgroundPaddingRight_:(id)right
{
    padding.size.width = [TiUtils floatValue:right];
    [self updateBackgroundImageFrameWithPadding];
}

-(void)setBackgroundPaddingTop_:(id)top
{
    padding.origin.y = [TiUtils floatValue:top];
    [self updateBackgroundImageFrameWithPadding];
}

-(void)setBackgroundPaddingBottom_:(id)bottom
{
    padding.size.height = [TiUtils floatValue:bottom];
    [self updateBackgroundImageFrameWithPadding];
}

-(void)setTextAlign_:(id)alignment
{
	[[self label] setTextAlignment:[TiUtils textAlignmentValue:alignment]];
    [self padLabel];
}

-(void)setShadowColor_:(id)color
{
	if (color==nil)
	{
		[[self label] setShadowColor:nil];
	}
	else
	{
		color = [TiUtils colorValue:color];
		[[self label] setShadowColor:[color _color]];
	}
    
    [[self label] setText:[[self label] text]];
}

-(void)setShadowOffset_:(id)value
{
	CGPoint p = [TiUtils pointValue:value];
	CGSize size = {p.x,p.y};
	[[self label] setShadowOffset:size];
    
    [[self label] setText:[[self label] text]];
}

-(void)setTextCheckingTypes_:(id)args
{
    NSInteger* checkingTypes = [TiUtils intValue:args];
    
    self.label.enabledTextCheckingTypes = checkingTypes;
    
    // we have to reset the text again so that checking types have effect
    if (self.label.text) {
        self.label.text = self.label.text;
    }
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label1 didSelectLinkWithURL:(NSURL *)url {
    [[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber {
    TiLogMessage(@"Opening phone number");
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {
    TiLogMessage(@"%@", addressComponents);
    NSString *title = [addressComponents objectForKey:@"name"];
    float latitude = [[addressComponents objectForKey:@"lat"] floatValue];
    float longitude = [[addressComponents objectForKey:@"long"] floatValue];
    
    //for iOS6 later
    if( [MKMapItem class]) {
        if (latitude && longitude) {
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            
            mapItem.name = title;
            [mapItem openInMapsWithLaunchOptions:nil];
        } else {
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressDictionary:addressComponents completionHandler:^(NSArray *placemarks, NSError *error) {
                if (placemarks && placemarks.count > 0) {
                    CLPlacemark *topResult = [placemarks objectAtIndex:0];
                    MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                    
                    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
                    
                    mapItem.name = placemark.title;
                    [mapItem openInMapsWithLaunchOptions:nil];
                }
            }];
        }
    } else {
        int zoom = 13;
        NSString *stringURL = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@@%1.6f,%1.6f&z=%d", title, latitude, longitude, zoom];
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - UIActionSheetDelegate

- (void) actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionSheet.title]];
}

@end
