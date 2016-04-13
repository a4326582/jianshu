#import <UIKit/UIKit.h>

@interface SystemNotificationView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSString *statue;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSArray *titleArr;


@end
