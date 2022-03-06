//
//  WeChatUITableViewController.m
//  xiaoyima
//
//  Created by qdazzle on 2022/3/4.
//

#import <Foundation/Foundation.h>
#import "WeChatUITableViewController.h"
#import "WeChatTalkUIView.h"
#import "WeChatUITableView.h"
#import "WeChatUITableViewCell.h"

@interface MessageModel ()

@end

@implementation MessageModel

@end

@interface WeChatUITableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet WeChatUITableView *ChatTableView;
@property (weak, nonatomic) IBOutlet UITextField *TextInput;
//@property (weak, nonatomic) IBOutlet SendButton *AddOrSend;
@property (weak, nonatomic) IBOutlet UIButton *OtherFunc;
@property (weak, nonatomic) IBOutlet UIButton *SendButton;
@property (weak, nonatomic) MyWeChatUITableViewCell *ChatTableViewCell;
@property (weak, nonatomic) IBOutlet UIButton *FaceButton;
@end

@implementation WeChatUITableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //_TextInput.delegate = self;
    _ChatTableView.delegate = self;
    _ChatTableView.dataSource = self;
    self.arrMessageModel = [[NSMutableArray alloc] init];
//
//        for (int i=0; i<10; i++) {
//
//            MessageModel *model = [[MessageModel alloc] init];
//
//            model.userAlias = i %2 == 0 ? @"Dear" : @"Me";
//            //从服务器或者本地读取
//            model.messageText = _TextInput.text;
//
//
//
//            [self.arrMessageModel addObject:model];
//
//        }
}
- (IBAction)FaceButtonOnClick:(id)sender {
       
}

- (IBAction)SendButtonClick:(id)sender {
    //同样，将数据加到list中，用的row
    MessageModel *model = [[MessageModel alloc] init];
    model.userAlias =@"Me";
    //从服务器或者本地读取
    model.messageText = _TextInput.text;
    model.datetime = [NSDate date];
    [self.arrMessageModel addObject:model];


    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:self.arrMessageModel.count-1 inSection:0];
    [_ChatTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
    [_ChatTableView reloadData];
    _TextInput.text=@"";
}
- (IBAction)OtherFuncClick:(id)sender {
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _SendButton.hidden=YES;
    [_SendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _SendButton.layer.cornerRadius=1.0f;
    _SendButton.layer.backgroundColor=[UIColor greenColor].CGColor;
    [_TextInput addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)textValueChanged
{
    if([@"" isEqual:_TextInput.text]){
        _SendButton.hidden=YES;
        _OtherFunc.hidden=NO;
    }else{
        _SendButton.hidden=NO;
        _OtherFunc.hidden=YES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = [self.arrMessageModel objectAtIndex:indexPath.row];
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrMessageModel.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MyWeChatUITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyChatCell" forIndexPath:indexPath];
    if(!cell) {
        cell = [[MyWeChatUITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MyChatCell"];
    }
    cell.messageModel = [self.arrMessageModel objectAtIndex:indexPath.row];
    return cell;
}

//
//- (void)encodeWithCoder:(nonnull NSCoder *)coder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];                 //收键盘
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_TextInput resignFirstResponder];           //收键盘
    return YES;
}
@end
