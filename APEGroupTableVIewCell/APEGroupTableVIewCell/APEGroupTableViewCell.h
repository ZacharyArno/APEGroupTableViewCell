//
//  APEGroupTableViewCell.h
//  KeepDemo
//
//  Created by Zachary on 4/2/16.
//  Copyright © 2016 Zachary. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, APEGroupTableViewCellDrawStyle) {
    APEGroupTableViewCellDrawStyleUnknow = 0,
    APEGroupTableViewCellDrawStyleAllRound,
    APEGroupTableViewCellDrawStyleTopRound,
    APEGroupTableViewCellDrawStyleMedium,
    APEGroupTableViewCellDrawStyleBottomRound
};

/* This is a abstract class, you should not use it directly.
 * Therefore, you should to use subclasses of it, APEGroupRoundTalbeViewCell,
 * APEGroupCapTableViewCell, APEGroupMediumTableViewCell, APEGroupBucketTableViewCell
 */

@interface APEGroupTableViewCell : UITableViewCell

@property (nonatomic, assign, readonly) APEGroupTableViewCellDrawStyle drawStyle;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong, nonnull) UIColor *strokeColor;
@property (nonatomic, strong, nonnull) UIColor *fillColor;
@property (nonatomic, assign) CGFloat insetX;

// For draw APEGroupTableViewCellDrawStyleMedium style,
// if you use APEGroupMediumTableViewCell you should set up it
@property (nonatomic, strong, nullable) NSIndexPath *indexPath;

// For draw APEGroupTableViewCellDrawStyleMedium style,
// if you use APEGroupMediumTableViewCell you should set up it
@property (nonatomic, assign) NSUInteger total;

@end

@interface APEGroupRoundTalbeViewCell : APEGroupTableViewCell

@end

@interface APEGroupCapTableViewCell : APEGroupTableViewCell

@end

@interface APEGroupMediumTableViewCell : APEGroupTableViewCell

@end

@interface APEGroupBucketTableViewCell : APEGroupTableViewCell

@end
