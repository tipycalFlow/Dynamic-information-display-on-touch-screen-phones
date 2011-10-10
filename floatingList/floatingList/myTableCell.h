//
//  myTableCell.h
//  floatingList
//
//  Created by Aakash Chaudhary on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface myTableCell : UITableViewCell {
    float originX;
    float width;
}

@property(assign) float originX;
@property(assign) float width;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier origin:(CGFloat)origin width:(CGFloat) widthX;

@end
