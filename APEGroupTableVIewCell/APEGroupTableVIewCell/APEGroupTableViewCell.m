//
//  APEGroupTableViewCell.m
//  KeepDemo
//
//  Created by Zachary on 4/2/16.
//  Copyright © 2016 Zachary. All rights reserved.
//

#import "APEGroupTableViewCell.h"

static CGFloat const APEGroupCornerRadius = 8.;
static CGFloat const APEGroupLineWidth    = .5;
static CGFloat const APEGroupEdgeOffset   = .3;
static CGFloat const APEGroupInsetXOffset   = .5;

@interface APEGroupTableViewCell ()

@property (nonatomic, strong) CAShapeLayer *drawLayer;
@property (nonatomic, strong) CAShapeLayer *ceilingLayer;
@property (nonatomic, strong) CAShapeLayer *floorLayer;
@property (nonatomic, assign) APEGroupTableViewCellDrawStyle drawStyle;

@end

@implementation APEGroupTableViewCell

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(strokeColor))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(fillColor))];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(lineWidth))];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    _fillColor = [UIColor colorWithRed:242 / 255.
                                 green:242 / 255.
                                  blue:242 / 255.
                                 alpha:1.];
    _strokeColor = [UIColor colorWithRed:204 / 255.
                                   green:204 / 255.
                                    blue:204 / 255.
                                   alpha:1.];
    _cornerRadius = APEGroupCornerRadius;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self _ape_setupKVO];
    return self;
}

- (CAShapeLayer *)drawLayer
{
    if (_drawLayer == nil) {
        _drawLayer = [[CAShapeLayer alloc] init];
        _drawLayer.frame = self.contentView.bounds;
        _drawLayer.lineWidth = APEGroupLineWidth;
        _drawLayer.lineCap = kCALineCapRound;
        _drawLayer.lineJoin = kCALineJoinBevel;
        _drawLayer.fillColor = _fillColor.CGColor;
        _drawLayer.strokeColor = _strokeColor.CGColor;
        _drawLayer.borderWidth = 0;
        _drawLayer.shadowColor = [UIColor clearColor].CGColor;
        _drawLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.contentView.layer insertSublayer:_drawLayer atIndex:0];
    }
    return _drawLayer;
}

- (CAShapeLayer *)ceilingLayer
{
    if (_ceilingLayer == nil) {
        _ceilingLayer = [[CAShapeLayer alloc] init];
        _ceilingLayer.backgroundColor = _fillColor.CGColor;
        _ceilingLayer.frame = CGRectMake(2 * APEGroupInsetXOffset + _insetX, 0, CGRectGetWidth(self.contentView.bounds) - 2 * _insetX - APEGroupInsetXOffset * 4, APEGroupLineWidth);
    }
    return _ceilingLayer;
}

- (CAShapeLayer *)floorLayer
{
    if (_floorLayer == nil) {
        _floorLayer = [[CAShapeLayer alloc] init];
        _floorLayer.backgroundColor = _fillColor.CGColor;
        _floorLayer.frame = CGRectMake(2 * APEGroupInsetXOffset + _insetX, CGRectGetMaxY(self.contentView.bounds) - APEGroupLineWidth, CGRectGetWidth(self.contentView.bounds) - 2 * _insetX - 4 * APEGroupInsetXOffset, APEGroupLineWidth);
    }
    return _floorLayer;
}

#pragma mark - Setter

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    [self setNeedsDisplay];
}

- (void)setTotal:(NSUInteger)total
{
    _total = total;
    [self setNeedsDisplay];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(fillColor))]) {
        self.drawLayer.fillColor = _fillColor.CGColor;
        self.ceilingLayer.backgroundColor = _fillColor.CGColor;
        self.floorLayer.backgroundColor = _fillColor.CGColor;
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(strokeColor))]) {
        self.drawLayer.strokeColor = _strokeColor.CGColor;
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(lineWidth))]) {
        self.drawLayer.lineWidth = APEGroupLineWidth;
    }
}

#pragma mark - Private

- (void)_ape_setupKVO
{
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(fillColor))
              options:NSKeyValueObservingOptionNew
              context:NULL];
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(strokeColor))
              options:NSKeyValueObservingOptionNew
              context:NULL];
    [self addObserver:self
           forKeyPath:NSStringFromSelector(@selector(lineWidth))
              options:NSKeyValueObservingOptionNew
              context:NULL];
}

- (void)_ape_drawAllRoundStyle
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, APEGroupInsetXOffset + _insetX, APEGroupEdgeOffset)
                                                        cornerRadius:APEGroupCornerRadius];
    self.drawLayer.path = maskPath.CGPath;
}

- (void)_ape_drawTopRoundStyle
{
    UIBezierPath *maskPath = [self _ape_bezierPathWithRect:CGRectInset(self.bounds, APEGroupInsetXOffset, APEGroupEdgeOffset)
                                                   corners:UIRectCornerTopLeft | UIRectCornerTopRight];

    self.drawLayer.path = maskPath.CGPath;
    if (self.floorLayer.superlayer == nil) {
        [self.drawLayer addSublayer:_floorLayer];
    }
}

- (void)_ape_drawBottomRoundStyle
{
    UIBezierPath *maskPath = [self _ape_bezierPathWithRect:CGRectInset(self.bounds, APEGroupInsetXOffset, APEGroupEdgeOffset)
                                                   corners:UIRectCornerBottomLeft | UIRectCornerBottomRight];

    self.drawLayer.path = maskPath.CGPath;
    if (self.ceilingLayer.superlayer == nil) {
        [self.drawLayer addSublayer:_ceilingLayer];
    }
}

- (void)_ape_drawMediumStyle
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:CGRectInset(self.bounds, APEGroupInsetXOffset + _insetX, APEGroupEdgeOffset)];
    self.drawLayer.path = maskPath.CGPath;
    if (_total == 3 || _indexPath.row == 1) {
        if (self.floorLayer.superlayer) [_floorLayer removeFromSuperlayer];
        if (self.ceilingLayer.superlayer) [_ceilingLayer removeFromSuperlayer];
    }
    else {
        if (self.ceilingLayer.superlayer == nil) {
            [self.drawLayer addSublayer:_ceilingLayer];
        }
    }
}

- (UIBezierPath *)_ape_bezierPathWithRect:(CGRect)rect corners:(UIRectCorner)corners
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, _insetX, 0)
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
    return maskPath;
}

@end

@implementation APEGroupRoundTalbeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.drawStyle = APEGroupTableViewCellDrawStyleAllRound;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self _ape_drawAllRoundStyle];
}

@end

@implementation APEGroupCapTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.drawStyle = APEGroupTableViewCellDrawStyleTopRound;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self _ape_drawTopRoundStyle];
}

@end

@implementation APEGroupMediumTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.drawStyle = APEGroupTableViewCellDrawStyleMedium;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self _ape_drawMediumStyle];
}

@end

@implementation APEGroupBucketTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.drawStyle = APEGroupTableViewCellDrawStyleBottomRound;
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self _ape_drawBottomRoundStyle];
}

@end