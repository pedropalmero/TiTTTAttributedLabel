/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComCodingpieTitttattributedlabelModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation ComCodingpieTitttattributedlabelModule

#pragma mark Internal

MAKE_SYSTEM_PROP(CHECKING_TYPE_ORTHOGRAPHY, NSTextCheckingTypeOrthography); // language identification
MAKE_SYSTEM_PROP(CHECKING_TYPE_SPELLING, NSTextCheckingTypeSpelling); // spell checking
MAKE_SYSTEM_PROP(CHECKING_TYPE_GRAMMAR, NSTextCheckingTypeGrammar); // grammar checking
MAKE_SYSTEM_PROP(CHECKING_TYPE_DATE, NSTextCheckingTypeDate); // date/time detection
MAKE_SYSTEM_PROP(CHECKING_TYPE_ADDRESS, NSTextCheckingTypeAddress); // address detection
MAKE_SYSTEM_PROP(CHECKING_TYPE_LINK, NSTextCheckingTypeLink); // link detection
MAKE_SYSTEM_PROP(CHECKING_TYPE_QUOTE, NSTextCheckingTypeQuote); // smart quotes
MAKE_SYSTEM_PROP(CHECKING_TYPE_DASH, NSTextCheckingTypeDash); // smart dashes
MAKE_SYSTEM_PROP(CHECKING_TYPE_REPLACEMENT, NSTextCheckingTypeReplacement); // fixed replacements, such as copyright symbol for (c)
MAKE_SYSTEM_PROP(CHECKING_TYPE_CORRECTION, NSTextCheckingTypeCorrection); // autocorrection
MAKE_SYSTEM_PROP(CHECKING_TYPE_REGULAR_EXPRESSION, NSTextCheckingTypeRegularExpression); // regular expression matches
MAKE_SYSTEM_PROP(CHECKING_TYPE_PHONE_NUMBER, NSTextCheckingTypePhoneNumber); // phone number detection
MAKE_SYSTEM_PROP(CHECKING_TYPE_TRANSIT_INFORMATION, NSTextCheckingTypeTransitInformation); // transit (e.g. flight) info detection
MAKE_SYSTEM_PROP(CHECKING_TYPE_ALL_SYSTEM_TYPES, NSTextCheckingAllSystemTypes);
MAKE_SYSTEM_PROP(CHECKING_TYPE_ALL_CUSTOM_TYPES, NSTextCheckingAllCustomTypes);
MAKE_SYSTEM_PROP(CHECKING_TYPE_ALL_TYPES, NSTextCheckingAllTypes);

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"62bc7aac-ea25-4d21-b62c-0b2e4287e0cb";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.codingpie.titttattributedlabel";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

@end
