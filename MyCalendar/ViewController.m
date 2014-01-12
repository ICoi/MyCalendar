//
//  ViewController.m
//  MyCalendar
//
//  Created by ico on 14. 1. 11..
//  Copyright (c) 2014년 ico. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource>{
    NSInteger year;
    NSInteger month;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *yearAndMonthButtonLabel;


@end

@implementation ViewController

// 달력의 요일에 맞추어 세팅하는 함수
- (void)setCalendarYear:(NSInteger)inYear Month:(NSInteger)inMonth{
    // 2000년 1월 1일
    // 2010년 1월 1일
    // 2020년 1월 1일
    // 2030년 1월 1일
    // 2040년 1월 1일
    // 이정도는 미리 잡아놓고 계산 하는 편이 더 나을듯..
}

// 해당 숫자에 맞는 요일을 리턴해주는 함수
// 0 : 일요일 1: 월요일 2: 화요일 3: 수요일 4: 목요일 5: 금요일 6: 토요일
- (NSString *)showDayString:(NSInteger)inNum{
    NSString *tmpString = [NSString stringWithFormat:@""];
    switch ((int)inNum) {
        case 0:
            tmpString = [tmpString stringByAppendingString:@"SUN"];
            break;
        case 1:
            tmpString = [tmpString stringByAppendingString:@"MON"];
            break;
        case 2:
            tmpString = [tmpString stringByAppendingString:@"TUS"];
            break;
        case 3:
            tmpString = [tmpString stringByAppendingString:@"WED"];
            break;
        case 4:
            tmpString = [tmpString stringByAppendingString:@"TUR"];
            break;
        case 5:
            tmpString = [tmpString stringByAppendingString:@"FRI"];
            break;
        case 6:
            tmpString = [tmpString stringByAppendingString:@"SAT"];
            break;
        default:
            break;
    }
    return tmpString;
}

// bar에 년도와 요일 표시하는 부분의 글씨 편집하는 함수.
- (void)setYear:(NSInteger)inYear setMonth:(NSInteger)inMonth{
    NSString *tmpString = [NSString stringWithFormat:@"%d년 %d월",(int)inYear,(int)inMonth];
    self.yearAndMonthButtonLabel.title = tmpString;
}
// 달력 내부에 요일부분 버튼 누른경우
- (IBAction)clickedButton:(id)sender {
    UIButton *tmp = [UIButton alloc];
    tmp = sender;
    NSLog(@"day is %@",[tmp.superview.subviews[1] text]);
}

// 이전 달로 이동하는 버튼 누른 경우
- (IBAction)clickedBeforeButton:(id)sender {
    month--;
    if(month == 0){
        year--;
        month = 12;
    }
    [self setYear:year setMonth:month];
}

// 이 다음 달로 이동하는 버튼 누른 경우
- (IBAction)clickedAfterButton:(id)sender {
    month++;
    if(month == 13){
        year++;
        month = 1;
    }
    [self setYear:year setMonth:month];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if((int)indexPath.row < 7){
        // 요일 이름 적을 부분
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DAY_CELL" forIndexPath:indexPath];
        UILabel *dayLabel = (UILabel *)[cell viewWithTag:1];
        dayLabel.text = [self showDayString:indexPath.row];
        return cell;
    }
    else{
        // 날자를 적을 부분.
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DATE_CELL" forIndexPath:indexPath];
        UILabel *dateLabel = (UILabel *)[cell viewWithTag:2];
        dateLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row-6];
        return  cell;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 42;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    year = 2013;
    month = 1;
    [self setYear:year setMonth:month];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
