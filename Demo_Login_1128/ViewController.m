//
//  ViewController.m
//  Demo_Login_1128
//
//  Created by Cyrilshanway on 2014/11/28.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Line.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    UITextField *memberNameText;
    UITextField *passwordText;
    
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *forgetButton;
    
    CALayer *_border;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
    
    // Add bottom line
    _border = [CALayer layer];
    
    _border.borderColor = [[UIColor colorWithRed:150.0/255.0 green:195.0/255.0 blue:35.0/255.0 alpha:1]CGColor];
    
    _border.borderWidth = 2;
    
    CALayer *layer = self.navigationController.navigationBar.layer;
    
    _border.frame = CGRectMake(0, layer.bounds.size.height, layer.bounds.size.width, 2);
    
    [layer addSublayer:_border];
    
}

- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [loginButton.layer setCornerRadius:5.0f];
    //loginButton.layer.cornerRadius = 5.0f;
    
    memberNameText = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 275, 40)];
    memberNameText.textColor = [UIColor darkGrayColor];
    memberNameText.delegate = self;
    memberNameText.textAlignment = NSTextAlignmentLeft;
    memberNameText.tag = 101;
    memberNameText.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:13.0];
    memberNameText.placeholder = @"Email";
    
    passwordText = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 275, 40)];
    passwordText.textColor = [UIColor blackColor];
    passwordText.delegate = self;
    passwordText.textAlignment = NSTextAlignmentLeft;
    [passwordText setSecureTextEntry:YES];
    passwordText.tag = 102;
    passwordText.font = [UIFont fontWithName:@"STHeitiTC-Medium" size:13.0];
    passwordText.placeholder = @"6-12位英數字，不含標點符號";
    
    //點到螢幕任何地方都會把鍵盤下降
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [gestureRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyboard{
    
    [self.view endEditing:YES];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0;
}
//分類
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//欄位高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}
//要顯示幾個欄位
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *requestIdentifier = @"LoginCell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:requestIdentifier];
            
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:requestIdentifier];
                cell.textLabel.textColor = [UIColor purpleColor];
                cell.detailTextLabel.textColor =[UIColor brownColor];
                cell.backgroundColor = [UIColor clearColor];
                
                cell.textLabel.font  = [UIFont fontWithName: @"STHeitiSC-Medium" size: 14.0];
                
                cell.detailTextLabel.font = [UIFont fontWithName: @"STHeitiSC-Medium" size: 14.0];
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.textAlignment = NSTextAlignmentLeft;
                cell.textLabel.textColor = [UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1];
                cell.backgroundColor = [UIColor whiteColor];
                cell.selectionStyle = UITableViewCellAccessoryNone;
            }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"";
            [cell.contentView addSubview:memberNameText];
            break;
        case 1:
            cell.textLabel.text = @"";
            [cell.contentView addSubview:passwordText];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"You pressed: %ld %ld", indexPath.section, indexPath.row);
    /*
     //不分section累加值
     NSInteger rowNumber = 0;
     
     for (NSInteger i = 0; i < indexPath.section; i++) {
     rowNumber += [self tableView:tableView numberOfRowsInSection:i];
     }
     
     rowNumber += indexPath.row;
     return rowNumber;
     NSLog(@"%ld",rowNumber);
     */
    
}

- (void)buttonPressed:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"You pressed the button %ld", button.tag);
}


- (IBAction)showOption1{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"請選擇"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消" destructiveButtonTitle:@"測試" otherButtonTitles:@"Email" ,@"Line", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag = 1;
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)showOption2{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"性別"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男" , @"女", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    actionSheet.tag = 2;
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"You Choose %ld in actionSheet %ld", buttonIndex, actionSheet.tag);
    
    switch (actionSheet.tag) {
        case 1:
        {
            if (buttonIndex == 1) {
                NSLog(@"Open Mail");
                [self openMail];
            }else if(buttonIndex == 2){
                [self openLine];
            }else{
                NSLog(@"Cancel");
            }
        }
            break;
        case 2:
        {
            if (buttonIndex == 0) {
                NSLog(@"Choose Male");
            }else{
                NSLog(@"Choose Female");
            }
        }
            break;
        default:
            break;
    }
    
}

-(void)openMail{
    NSString *emailTitle = @"Hello";
    NSString *messageBody = [NSString stringWithFormat:@"Test Message"];
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        
        //Present mail view on screen
        [self presentViewController:mc animated:YES completion:nil];
    }else{
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"測試"
                                                           message:@"Email 尚未設定"
                                                          delegate:nil
                                                 cancelButtonTitle:@"確定"
                                                 otherButtonTitles: nil];
        [alerView show];
    }
}

- (void)openLine{
    if (![Line isLineInstalled]) {
        NSLog(@"Line is not installed");
    }else{
        //[Line shareText:@"This is a test"];
        //準備掃某個範圍
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, self.view.opaque, 0.0);
        //從哪個view開始化
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *imageScreen = UIGraphicsGetImageFromCurrentImageContext();
        //指定到
        UIGraphicsEndImageContext();
        
        NSString *savePath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/share.png"];
        
        BOOL ret = [UIImagePNGRepresentation(imageScreen) writeToFile:savePath atomically:YES];
        
        //一次只能傳一樣東西
        //[Line shareImage:[UIImage imageNamed:@"test.jpg"]];
        [Line shareImage:imageScreen];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    NSLog(@"mailComposeController:result:error");
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed  :
            NSLog(@"Mail sent failed: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
