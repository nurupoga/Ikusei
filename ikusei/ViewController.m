//
//  ViewController.m
//  ikusei
//
//  Created by ohtatomotaka on 2015/01/18.
//  Copyright (c) 2015年 ohtatomotaka. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()

@end

@implementation ViewController{
    SystemSoundID sound_1;
    int displayX;
    int displayY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hittuujou" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &sound_1);
    NSTimer *time = [NSTimer
                     scheduledTimerWithTimeInterval:1 target:self selector:@selector(addCaracheter) userInfo:nil repeats:YES];
    
    CGRect r = [[UIScreen mainScreen] bounds];
    displayX= r.size.width;
    displayY= r.size.height;
    [self addCaracheter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addCaracheter{
    int ranX = arc4random() % displayX-50;
    int ranY = arc4random() % displayY-50;
    UIImageView *monster = [[UIImageView alloc] init];
    monster.image = [UIImage imageNamed:@"sraim.png"];
    monster.frame = CGRectMake(ranX, ranY, 100, 100);
    monster.userInteractionEnabled = YES;
    monster.tag = 2;
    [self.view addSubview:monster];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSLog(@"%d",touch.view.tag);
    if (touch.view.tag==2) {
        [touch.view removeFromSuperview];
        AudioServicesPlaySystemSound(sound_1);
        SumMoney=SumMoney+20;
        LmoneyLabel.text=[NSString stringWithFormat:@"%dG",SumMoney];
    }

}
@end
