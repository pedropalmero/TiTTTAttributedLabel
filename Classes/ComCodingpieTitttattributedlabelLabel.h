/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "TTTAttributedLabel.h"

@interface ComCodingpieTitttattributedlabelLabel : TiUIView <TTTAttributedLabelDelegate, UIActionSheetDelegate, LayoutAutosizing>{
@private
	TTTAttributedLabel *label;
    CALayer* bgdLayer;
	BOOL requiresLayout;
    CGRect padding;
    CGRect textPadding;
    UIControlContentVerticalAlignment verticalAlign;
    CGRect initialLabelFrame;
}

@property(nonatomic,getter=isHighlighted) BOOL     highlighted;
@property(nonatomic, assign) BOOL hasHTML;

- (TTTAttributedLabel *)label;

@end
