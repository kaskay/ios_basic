//
//  MYView.m
//  week10
//
//  Created by 이재성 on 2016. 5. 4..
//  Copyright © 2016년 JoyLee. All rights reserved.
//

#import "MYView.h"

@implementation MYView
@synthesize axisPoint,toRightDown,toLeftDown,toDown,toRight,toLeft,toRightUp;
CGPoint StartPoint;
CGPoint MovedPoint;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawline];
}

-(void)drawline{
    UIBezierPath *path = [UIBezierPath bezierPath];
    for(NSValue *valuetoGetBack in axisPoint){
        [path addLineToPoint:[valuetoGetBack CGPointValue]];
        [path moveToPoint:[valuetoGetBack CGPointValue]];
    }
    [path setLineWidth:3.0];
    [path stroke];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches]anyObject];
    axisPoint=[[NSMutableArray alloc]init];
    [axisPoint addObject:[NSValue valueWithCGPoint:[touch locationInView:touch.view]]];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches]anyObject];
    CGPoint nowPoint = [touches.anyObject locationInView:touch.view];
    [axisPoint addObject:[NSValue valueWithCGPoint:[touch locationInView:touch.view]]];
    [self checkDirection:nowPoint];
    StartPoint=nowPoint;
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self checkNumber];
    [self reset];
    [self setNeedsDisplay];
}

-(void)checkNumber{
    StartPoint=[axisPoint[0] CGPointValue];
    MovedPoint=[axisPoint[axisPoint.count-1] CGPointValue];
    if(toDown==1&&(toRight==0||toLeft==0)){
        NSLog(@"1");
    }
    else if(toLeftDown==1&&toRight==2){
        NSLog(@"2");
    }
    else if(toLeftDown==2&&toRightDown==2){
        NSLog(@"3");
    }
    else if(toRight==1&&toDown==1&&toLeft==1){
        NSLog(@"7");
    }
    
}
-(void)reset{
    self.toLeftDown=0;
    self.toRightDown=0;
    self.toRight=0;
    self.toLeft=0;
    self.toRightUp=0;
    self.toDown=0;
    self.left=NO;
    self.right=NO;
    self.leftDown=NO;
    self.down=NO;
    self.rightUp=NO;
    self.rightDown=NO;
}

-(void)checkDown:(CGPoint)nowPoint{
    if (nowPoint.y > StartPoint.y) {
        if(!self.down){
            self.down = YES;
            self.up = NO;
            toDown++;
        }
    }
}

-(void)checkLeft:(CGPoint)nowPoint{
    if (nowPoint.x < StartPoint.x) {
        if(!self.left){
            self.left = YES;
            self.right = NO;
            toLeft++;
        }
    }
}

-(void)checkRight:(CGPoint)nowPoint{
    if (nowPoint.x > StartPoint.x) {
        if(!self.right){
            self.right = YES;
            self.left = NO;
            toRight++;
        }
    }
}
-(void)checkLeftDown:(CGPoint)nowPoint{
    if (nowPoint.x < StartPoint.x && nowPoint.y > StartPoint.y) {
        if(!self.leftDown){
            self.leftDown = YES;
            self.rightDown = NO;
            toLeftDown++;
        }
    }
}

-(void)checkRightDown:(CGPoint)nowPoint{
    if (nowPoint.x > StartPoint.x && nowPoint.y > StartPoint.y) {
        if(!self.rightDown){
            self.rightDown = YES;
            self.leftDown = NO;
            toRightDown++;
        }
    }
}

-(void)checkRightUp:(CGPoint)nowPoint{
    if (nowPoint.x > StartPoint.x && nowPoint.y < StartPoint.y) {
        if(!self.rightUp){
            self.rightUp = YES;
            self.leftUp = NO;
            toRightUp++;
        }
    }
}


-(void)checkDirection:(CGPoint)nowPoint{
    [self checkRightDown:nowPoint];
    [self checkLeftDown:nowPoint];
    [self checkRight:nowPoint];
    [self checkLeft:nowPoint];
    [self checkRightUp:nowPoint];
    [self checkDown:nowPoint];
}

@end
