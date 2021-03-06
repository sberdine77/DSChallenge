//
//  ViewController.m
//  DSChallenge
//
//  Created by Sávio Berdine on 05/01/21.
//

#import "ListViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TableViewCell.h"

@interface ListViewController ()

@property UIAlertController *loadingAlert;
@property UIActivityIndicatorView *loadingIndicator;

@end

@implementation ListViewController

-(instancetype) initWithViewModel: (ListViewViewModel *) viewModel {
    self = [super initWithNibName:nil bundle:nil];
        if (!self) {
            return nil;
        }
        _viewModel = viewModel;
        return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Interface setup
    [self.tableView initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView registerClass:TableViewCell.self forCellReuseIdentifier:@"cellId"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationItem.title = @"Marketplace";
    self.navigationController.navigationBar.prefersLargeTitles = TRUE;
    
    
    //Loading alert while the API is returning stores data
    self.loadingAlert = [UIAlertController alertControllerWithTitle:@"Aguarde..." message:nil preferredStyle:UIAlertControllerStyleAlert];
    CGRect rect = CGRectMake(10, 5, 50, 50);
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:rect];
    self.loadingIndicator.hidesWhenStopped = YES;
    self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
    [self.loadingAlert.view addSubview:self.loadingIndicator];
    
    @weakify(self);
        // A loading indicator - Indicates if API request is currently underway.
    [RACObserve(self.viewModel, loadingStores) subscribeNext:^(NSNumber* loading) {
        @strongify(self);
        if ([loading boolValue]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.loadingIndicator startAnimating];
                [self presentViewController:self.loadingAlert animated:YES completion:nil];
                [self.tableView reloadData];
            });
            NSLog(@"TRUE");
            NSLog(@"%d", [loading boolValue]);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.loadingIndicator stopAnimating];
                [self.loadingAlert dismissViewControllerAnimated:YES completion:nil];
                [self.tableView reloadData];
            });
            NSLog(@"FALSE");
        }
    }];
    [self.viewModel getAllStores];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.prefersLargeTitles = TRUE;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    
    UIListContentConfiguration *content = [cell defaultContentConfiguration];
    
    content.text = self.viewModel.storesArray[indexPath.row].name;
    content.secondaryText = [NSString stringWithFormat:@"Id: %@", self.viewModel.storesArray[indexPath.row].storeId];
    
    cell.contentConfiguration = content;
    
//    cell.textLabel.text = self.viewModel.storesArray[indexPath.row].name;
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Id: %@", self.viewModel.storesArray[indexPath.row].storeId];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Tableview number of cells equal to the number of objects returned from the API
    return self.viewModel.storesArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *destination = self.viewModel.viewForSelectedStore(self.viewModel.storesArray[indexPath.row]);
    
    [self.navigationController showViewController:destination sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Lojas";
}

@end
