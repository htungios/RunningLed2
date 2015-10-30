//
//  ViewController.m
//  RunningLed2
//
//  Created by Hoang Ngoc Tung on 30/10/2015.
//  Copyright (c) Năm 2015 HoangNgocTung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
    CGFloat _margin; // > ball radius
    int _numberOfBall;
    CGFloat _space;  // > ball diameter
    CGFloat _diameter;
    int _ballRow;
    int _ballColumn;
    NSTimer * _timer;
    int lastOnLed;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin =40;
    _diameter =24;
    _ballRow =8;
    _ballColumn = 8;
    
    lastOnLed = -1;
    //[self checkSizeOfApp];
    //[self numberOfBallvsSpace1];
    //[self numberOfBallvsSpace2];
    [self drawRowOfBallOfRow:_ballRow andballOfColumn:_ballColumn];
    _numberOfBall = _ballColumn*_ballRow;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(runningLed) userInfo:nil repeats:true];}
-(void) runningLed {
        if (lastOnLed != -1) {
            [self turnOffLed:lastOnLed];
        }
        if (lastOnLed != _numberOfBall - 1) {
            lastOnLed++;
        } else {  //Reach the last LED in row, move to first LED
            lastOnLed = 0;
        }
        [self turnOnLed:lastOnLed];
}
-(void) turnOnLed: (int) index {
    UIView* view = [self.view viewWithTag:index +100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}
-(void) turnOffLed: (int) index {

    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"gray"];
    }
}
-(CGFloat) spaceBetweenBallCenterWhenNumberOfBallIsKnown1 : (int) n {
    return (self.view.bounds.size.width - 2 * _margin) / (n-1);
}
-(CGFloat) spaceBetweenBallCenterWhenNumberOfBallIsKnown2 : (int) m {
    return (self.view.bounds.size.height - 2* _margin) / (m-1);
}
- (void) numberOfBallvsSpace1 {
    bool stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown1 : n];
        if (space <= _diameter) {
            stop = true;
        } else {
            NSLog(@"number of ball %d and space %3.0f",n,space);
        }
        n++;
    }
    
}
- (void) numberOfBallvsSpace2 {
    bool stop = false;
    int m = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown2 : m];
        if (space <= _diameter) {
            stop = true;
        } else {
            NSLog(@"number of ball %d and space %3.0f",m,space);
        }
        m++;
    }
    
}
- (void) placeGrayBallAtX: (CGFloat) x
                     andY: (CGFloat) y
                  withTag: (int) tag
{
    UIImageView* ball = [[ UIImageView alloc] initWithImage:[ UIImage imageNamed:@"gray.png"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    //NSLog(@"w of ball %3.0f and h off ball %3.0f", ball.bounds.size.width,ball.bounds.size.height);
}
- (void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width %3.0f with height %3.0f", size.width, size.height);
    
}
-(void) drawRowOfBallOfRow: (int) numberBallsOfRow andballOfColumn: (int) numberBallsOfCollum {
    CGFloat space1 = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown1:numberBallsOfRow];
    CGFloat space2 = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown2:numberBallsOfCollum];
    for (int i = 0; i< numberBallsOfRow; i++) {
        for (int j = 0; j< numberBallsOfCollum; j++) {
            [self placeGrayBallAtX:_margin + i * space1
                              andY:_margin + j * space2
                           withTag:100 + i * numberBallsOfCollum + j];
        }
    }
}
@end
