//
//  ViewController.m
//  Example
//
//  Created by Ana Luiza on 18/10/24.
//

#import "ViewController.h"
#import "GithubFramework.h"
#import "GithubRepositoryModel.h"
#import "GitTagModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSArray<GitHubRepositoryModel *> *repositories;
@property (nonatomic, strong) NSArray<GitTagModel *> *tags;
@property (nonatomic, strong) GithubFramework *githubRepositories;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.githubRepositories = [GithubFramework sharedManager];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];

    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 40)];
    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextField.placeholder = @"Buscar usuário";
    [self.view addSubview:self.searchTextField];

    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(20, 150, self.view.frame.size.width - 40, 40);
    [searchButton setTitle:@"Buscar" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - 200)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)searchUser {
    NSString *username = self.searchTextField.text;
    [self.githubRepositories fetchRepositoriesForUser:username completion:^(NSArray *repositories, NSError *error) {
        if (error) {
            NSLog(@"Erro: %@", error.localizedDescription);
            return;
        }
        self.repositories = repositories;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    GitHubRepositoryModel *repo = self.repositories[indexPath.row];
    cell.textLabel.text = repo.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GitHubRepositoryModel *repo = self.repositories[indexPath.row];
    [self.githubRepositories fetchRepositoriesTag:repo.tagsURL completion:^(NSArray * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Erro: %@", error.localizedDescription);
            return;
        }
        self.tags = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.tags count] == 0) {
                NSLog(@"Sem tags");
            } else {
                for (GitTagModel *tag in self.tags) {
                    NSLog(tag.name);
                };
            }
        });
    }];
}

@end
