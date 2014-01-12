//
//  ViewController.m
//  MyCalendar
//
//  Created by ico on 14. 1. 11..
//  Copyright (c) 2014년 ico. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource>

@end

@implementation ViewController
- (IBAction)clickedButton:(id)sender {
    UIButton *tmp = [UIButton alloc];
    tmp = sender;
    NSLog(@"Button clicked!");
    NSLog(@"day is %@",[tmp.superview.subviews[1] text ]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DAY_CELL" forIndexPath:indexPath];
    UILabel *dayLabel = (UILabel *)[cell viewWithTag:1];
    dayLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 31;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
