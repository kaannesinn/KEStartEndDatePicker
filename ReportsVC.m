//
//  ReportsVC.m
//  kesin
//
//  Created by kesin on 19/12/16.
//  Copyright © 2016 kesin. All rights reserved.
//

#import "ReportsVC.h"

#define Btn_Selected_Color  [UIColor colorWithRed:17/255.0 green:157/255.0 blue:214/255.0 alpha:1.0]
#define Btn_Deselected_Color  [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0]

@interface ReportsVC ()

@property (strong, nonatomic) IBOutlet UIButton *btnStartDate;
@property (strong, nonatomic) IBOutlet UIButton *btnEndDate;
@property (strong, nonatomic) IBOutlet UIButton *btnListReport;
@property (nonatomic,strong) UIDatePicker *datePickerViewForStartDate;
@property (nonatomic,strong) UIDatePicker *datePickerViewForEndDate;

- (IBAction)startDateClicked:(id)sender;
- (IBAction)endDateClicked:(id)sender;
- (IBAction)listReportClicked:(id)sender;

@end

@implementation ReportsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBackButtonToLeftBarButtonItem];
    
    self.btnStartDate.layer.cornerRadius = 5.0;
    self.btnStartDate.layer.borderColor = UIColorFromRGB(0xEDEFF1).CGColor;
    self.btnStartDate.layer.borderWidth = 1.0;
    
    self.btnEndDate.layer.cornerRadius = 5.0;
    self.btnEndDate.layer.borderColor = UIColorFromRGB(0xEDEFF1).CGColor;
    self.btnEndDate.layer.borderWidth = 1.0;
    
    self.datePickerViewForStartDate = [[UIDatePicker alloc] init];
    [self.datePickerViewForStartDate setDate:[[NSDate date] dateByAddingTimeInterval:-60*60*24*30]];
    self.datePickerViewForEndDate = [[UIDatePicker alloc] init];
    [self.datePickerViewForEndDate setDate:[NSDate date]];
    
    [self.datePickerViewForStartDate setMaximumDate:[self.datePickerViewForEndDate date]];
    [self.datePickerViewForStartDate setDatePickerMode:UIDatePickerModeDate];
    self.datePickerViewForStartDate.frame = CGRectMake(0.f, 0.f, self.datePickerViewForStartDate.frame.size.width, 150.f);
    
    [self.datePickerViewForEndDate setMinimumDate:[self.datePickerViewForStartDate date]];
    [self.datePickerViewForEndDate setDatePickerMode:UIDatePickerModeDate];
    self.datePickerViewForEndDate.frame = CGRectMake(0.f, 0.f, self.datePickerViewForEndDate.frame.size.width, 150.f);
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd.MM.yyyy"];
    [self.btnStartDate setTitle:[df stringFromDate:[[NSDate date] dateByAddingTimeInterval:-60*60*24*30]] forState:UIControlStateNormal];
    [self.btnEndDate setTitle:[df stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    
    [self changeButtonTextColors:self.btnStartDate isSelected:NO];
    [self changeButtonTextColors:self.btnEndDate isSelected:NO];
    
    [self.btnListReport setBackgroundColor:[UIColor blackColor]];
    [self.btnListReport setTitle:@"GÖSTER" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark screen methods
- (IBAction)startDateClicked:(id)sender {
    [self.view endEditing:YES];
    
    [[[LGActionSheet alloc] initWithTitle:@"Başlangıç Tarihi"
                                     view:self.datePickerViewForStartDate
                             buttonTitles:@[BUTTON_CHOOSE]
                        cancelButtonTitle:ALERT_CANCEL
                   destructiveButtonTitle:nil
                            actionHandler:^(LGActionSheet *actionSheet, NSString *title, NSUInteger index) {
                                NSDateFormatter *df = [[NSDateFormatter alloc]init];
                                [df setDateFormat:@"dd.MM.yyyy"];
                                [self.btnStartDate setTitle:[df stringFromDate:[self.datePickerViewForStartDate date]] forState:UIControlStateNormal];
                                
                                [self.datePickerViewForStartDate setMaximumDate:[self.datePickerViewForEndDate date]];
                                [self.datePickerViewForEndDate setMinimumDate:[self.datePickerViewForStartDate date]];
                                
                                [self changeButtonTextColors:self.btnStartDate isSelected:YES];
                            }
                            cancelHandler:nil
                       destructiveHandler:nil] showAnimated:YES completionHandler:nil];
}

- (IBAction)endDateClicked:(id)sender {
    [self.view endEditing:YES];
    
    [[[LGActionSheet alloc] initWithTitle:@"Bitiş Tarihi"
                                     view:self.datePickerViewForEndDate
                             buttonTitles:@[BUTTON_CHOOSE]
                        cancelButtonTitle:ALERT_CANCEL
                   destructiveButtonTitle:nil
                            actionHandler:^(LGActionSheet *actionSheet, NSString *title, NSUInteger index) {
                                NSDateFormatter *df = [[NSDateFormatter alloc]init];
                                [df setDateFormat:@"dd.MM.yyyy"];
                                [self.btnEndDate setTitle:[df stringFromDate:[self.datePickerViewForEndDate date]] forState:UIControlStateNormal];
                                
                                [self.datePickerViewForStartDate setMaximumDate:[self.datePickerViewForEndDate date]];
                                [self.datePickerViewForEndDate setMinimumDate:[self.datePickerViewForStartDate date]];
                                
                                [self changeButtonTextColors:self.btnEndDate isSelected:YES];
                            }
                            cancelHandler:nil
                       destructiveHandler:nil] showAnimated:YES completionHandler:nil];
}

-(void)changeButtonTextColors:(UIButton*)button isSelected:(BOOL)isSelected{
    if ([button isEqual:self.btnStartDate]) {
        [self.btnStartDate setTitleColor:(isSelected ? Btn_Selected_Color : Btn_Deselected_Color) forState:UIControlStateNormal];
    }
    else if ([button isEqual:self.btnEndDate]) {
        [self.btnEndDate setTitleColor:(isSelected ? Btn_Selected_Color : Btn_Deselected_Color) forState:UIControlStateNormal];
    }
}

- (IBAction)listReportClicked:(id)sender {
}

@end
