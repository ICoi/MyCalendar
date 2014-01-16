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
    NSInteger startDate;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *yearAndMonthButtonLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;


@end

@implementation ViewController

// 달력의 요일에 맞추어 세팅하는 함수
// 해당 년 월의 1일의 요일 값을 리턴한다.
- (NSInteger)setCalendarYear:(NSInteger)inYear Month:(NSInteger)inMonth{
    // 2000년 1월 1일 토요일 (6)
    // 2012년 1월 1일 일요일 (0)
    // 2024년 1월 1일 월요일 (1)
    // 2036년 1월 1일 화요일 (2)
    // 이정도는 미리 잡아놓고 계산 하는 편이 더 나을듯..
    
    // 윤년을 제외하고전 전 년도보다 하루 늦춰짐
    // 윤년에는 2일 늦춰짐..
    
    // TODO 여기부분 마저 채우기..
    
    return 0;
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
    
    
    // 새로 1일의 시작 날자 설정
    startDate = [self calculateDayWithYear:year withMonth:month withDate:1];
  //  startDate++;
    startDate %= 7;
    NSLog(@"%d - %d - %d ",year,month,startDate);
    self.yearAndMonthButtonLabel.title = tmpString;
}


// 요일을 리턴해주는 함수
// 0 : 일요일 1 : 월요일 2 : 화요일 3: 수요일 4:목요일 5:금요일 6 :토요일
- (NSInteger)calculateDayWithYear:(NSInteger)inYear withMonth:(NSInteger)inMonth withDate:(NSInteger)inDate{
    if (inMonth <= 2){
        --inYear;
        inMonth += 12;
    }

    NSInteger resultDay = ( (21*((int)inYear/100)/4) + (5*((int)inYear%100)/4) + (26*((int)inMonth+1)/10) + (int)inDate - 1 ) % 7;
    return resultDay;
}
/*
 int GetDayOfTheWeek(int year, int month, int date)
 {
 if ( month <= 2 )
 {
 --year;
 month += 12;
 }
 return ( (21*(year/100)/4) + (5*(year%100)/4) + (26*(month+1)/10) + date - 1 ) % 7;
 }
 */
// 달력 내부에 요일부분 버튼 누른경우
- (IBAction)clickedButton:(id)sender {
    UIButton *tmp = [UIButton alloc];
    tmp = sender;
    NSString *tmpString = [NSString alloc];
    tmpString = [tmp.superview.subviews[1] text];
    NSInteger clickedDate = [tmpString integerValue];
    NSInteger result = [self calculateDayWithYear:year withMonth:month withDate:clickedDate];
    
    
    NSLog(@"day is %@",tmpString);
}

// 이전 달로 이동하는 버튼 누른 경우
- (IBAction)clickedBeforeButton:(id)sender {
    month--;
    if(month == 0){
        year--;
        month = 12;
    }
    
    
    [self setYear:year setMonth:month];
    [self.collection reloadData];
}

// 이 다음 달로 이동하는 버튼 누른 경우
- (IBAction)clickedAfterButton:(id)sender {
    month++;
    if(month == 13){
        year++;
        month = 1;
    }
    [self setYear:year setMonth:month];
    [self.collection reloadData];
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
        
        NSInteger writeDate = indexPath.row - 6 - startDate;
        NSString *writeDateStr = [NSString alloc];
        
        // TODO setCalendarYear 이거 함수이용해서 해야함!!
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DATE_CELL" forIndexPath:indexPath];
        UILabel *dateLabel = (UILabel *)[cell viewWithTag:2];
        
        // 일단 달력 윗줄에 빈공간 계산하기
        if((writeDate <= 0) || (writeDate > 31)){
            // 여기는 빈공간
            writeDateStr = @" ";
        }
        else if(writeDate == 31){
            if((month == 2) || (month == 4) || (month == 6 ) || (month == 9) || (month == 11)){
                writeDateStr = @" ";
            }
            else{
                writeDateStr = [NSString stringWithFormat:@"%d",writeDate];
            }
        }
        else if(writeDate == 30){
            if(month == 2){
                writeDateStr = @" ";
            }
            else {
                writeDateStr = [NSString stringWithFormat:@"%d",writeDate];
            }
        }
        else if(writeDate  == 29)
        {
            // 여기는 채워질 부분
            if( (month != 2) || (((year % 4) == 0) && ((year & 100) != 0))){
                writeDateStr = [NSString stringWithFormat:@"%d",writeDate];
            }
            else{
                writeDateStr = @" ";
            }
        }
        else{
            writeDateStr = [NSString stringWithFormat:@"%d",writeDate];
        }
        
        // 달력 아랫줄 끝나는 공간 계산하기
        // 2월달의경우 -> 윤년이 아니면 28일까지 윤년이면 29일까지
        // 1 3 5 7 8 10 12월은 31일까지
        // 4 6 9 11월은 30일까지 존재함.
        
        dateLabel.text = writeDateStr;
        return  cell;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 49;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    year = 2013;
    month = 1;
    [self setYear:year setMonth:month];
    
    
    // 여기는 요일 구하는거 테스트 하려고 한 거
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
