//
//  myTableCell.m
//  floatingList
//
//  Created by Aakash Chaudhary on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "myTableCell.h"


@implementation myTableCell
@synthesize originX,width;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier origin:(CGFloat)origin width:(CGFloat) widthX
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    originX = origin;
    width = widthX;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [super layoutSubviews];
    if (width==0) 
        self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, 
                                          4.0, 
                                          self.textLabel.frame.size.width, 
                                          self.textLabel.frame.size.height);
    else
    self.textLabel.frame = CGRectMake(originX, 
                                      4.0, 
                                      width, 
                                      self.textLabel.frame.size.height);
}

- (void)dealloc
{
    [super dealloc];
}

@end
