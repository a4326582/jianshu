

#import "SystemNotificationView.h"

#define KNotiStatueOpen @"已开启    "
#define KNotiStatueClose @"未开启    "
@implementation SystemNotificationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
//        self.backgroundColor = BGColor;
        self.titleArr = @[@"声音",@"提醒",@"标记"];
        
        self.data = [NSMutableArray array];
        [self judgePushStatue];
        [self addSubview:self.tableView];
        [self.tableView reloadData];
    }
    return self;
}
/**
 *  tableView的get方法  懒加载
 *
 *  @return UITableView
 */
-(UITableView *)tableView
{
    if(_tableView==nil)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-10) style: UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = BGColor;
        _tableView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-64);
        UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        head.backgroundColor = BGColor;
        _tableView.tableHeaderView = head;
        UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        foot.backgroundColor = BGColor;
        
        _tableView.tableFooterView = foot;
        
    }
    return  _tableView;
}
#pragma mark - tableview 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data[section] count];;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"123"];
    }
    
    if(indexPath.section == 0){
        cell.textLabel.text  =  @"接收新消息通知";
    }else{
        cell.textLabel.text = self.titleArr[indexPath.row];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.text = self.data[indexPath.section][indexPath.row];
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
    [SVProgressHUD showSuccessWithStatus:@"如果你要开启或者关闭系统消息，请在iPhone的“设置”-“通知” 功能中，找到应用程序 进行修改" duration:5];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
/*
 UIUserNotificationTypeNone    = 0,      // the application may not present any UI upon a notification being received
 UIUserNotificationTypeBadge   = 1 << 0, // the application may badge its icon upon a notification being received
 UIUserNotificationTypeSound   = 1 << 1, // the application may play a sound upon a notification being received
 UIUserNotificationTypeAlert   = 1 << 2,
 */
-(void)judgePushStatue{
    bool b ;
    NSMutableArray *arrTwo = [NSMutableArray array];
    if (IS_OS_8_OR_LATER) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone == setting.types) {
            b = NO;
        }else{
            b = YES;
        }
        int typeSound = setting.types & UIUserNotificationTypeSound;
        int typeBadge = setting.types & UIUserNotificationTypeBadge;
        int typeAlert = setting.types & UIUserNotificationTypeAlert;
        
        if(typeSound !=0){
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueOpen]];
        }else{
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueClose]];
        }
        if(typeBadge !=0){
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueOpen]];
        }else{
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueClose]];
        }
        if(typeAlert !=0){
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueOpen]];
        }else{
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueClose]];
        }
        
        
    } else {
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        int typeSound = (type & UIRemoteNotificationTypeSound);
        int typeBadge = (type & UIRemoteNotificationTypeBadge);
        int typeAlert = (type & UIRemoteNotificationTypeAlert);
        NSLog(@"%d,%d,%d",typeBadge,typeSound,typeAlert);
        
        
        if(UIRemoteNotificationTypeNone != type){
            b = YES;
        }
        if(typeSound !=0){
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueOpen]];
        }else{
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueClose]];
        }
        if(typeBadge !=0){
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueOpen]];
        }else{
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueClose]];
        }
        if(typeAlert !=0){
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueOpen]];
        }else{
            [arrTwo addObject:[NSString stringWithFormat:@"%@",KNotiStatueClose]];
        }
    }

    if(b){
        _statue = KNotiStatueOpen;
    }else{
        _statue = KNotiStatueClose;
    }

    NSMutableArray *arrOne = [NSMutableArray array];
    [arrOne addObject:[NSString stringWithFormat:@"%@",_statue]];
    [self.data addObject:arrOne];
    if(b){
        [self.data addObject:arrTwo];
    }
  
    
    
}
@end
