//
//  CMViewController.m
//  CMTabbarView
//
//  Created by momo605654602@gmail.com on 03/07/2017.
//  Copyright (c) 2017 momo605654602@gmail.com. All rights reserved.
//

#import "CMViewController.h"
#import "CMTabbarView.h"
#import "DemoCell.h"

static NSUInteger const kCMDefaultSelected = 0;

@interface CMViewController ()<CMTabbarViewDelegate,CMTabbarViewDatasouce,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) CMTabbarView *tabbarView;
@property (strong, nonatomic) NSArray *datas;

@end

@implementation CMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.datas = @[@"Objective-C",@"Swift",@"Ruby"];
    [self.view insertSubview:self.collectionView belowSubview:self.tabbarView];
    [self.view addSubview:self.tabbarView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.datas = @[@"Objective-C",@"Swift",@"Ruby",@"C++",@"JAVA",@"C",@"Apple",@"iPhone",@"iOS",@"Orange",@"Moyun",@"Penny",@"Module-Class-Class",@"Class",@"Class"];
        [self.collectionView reloadData];
        [self.tabbarView reloadData];
        self.collectionView.contentOffset = CGPointMake(self.view.bounds.size.width*kCMDefaultSelected, 0);
    });
}

- (CMTabbarView *)tabbarView
{
    if (!_tabbarView) {
        _tabbarView = [[CMTabbarView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
        _tabbarView.delegate = self;
        _tabbarView.dataSource = self;
        _tabbarView.defaultSelectedIndex = kCMDefaultSelected;
        _tabbarView.indicatorScrollType = CMTabbarIndicatorScrollTypeSpring;
//        _tabbarView.tabPadding = 5.0f;
        
        _tabbarView.selectionType = CMTabbarSelectionBox;
        _tabbarView.indicatorAttributes = @{CMTabIndicatorColor:[UIColor orangeColor]};
        //_tabbarView.normalAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
        //_tabbarView.selectedAttributes = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
        //_tabbarView.needTextGradient = false;
    }
    return _tabbarView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[DemoCell class] forCellWithReuseIdentifier:NSStringFromClass([DemoCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.pagingEnabled = true;
        _collectionView.contentOffset = CGPointMake(self.view.bounds.size.width*kCMDefaultSelected, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSArray<NSString *> *)tabbarTitlesForTabbarView:(CMTabbarView *)tabbarView
{
    return self.datas;
}

- (void)tabbarView:(CMTabbarView *)tabbarView1 didSelectedAtIndex:(NSInteger)index
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DemoCell class]) forIndexPath:indexPath];
    cell.title = [NSString stringWithFormat:@"%ld",indexPath.row];
    
//    cell.backgroundColor = indexPath.row % 2 ? [UIColor orangeColor] : [UIColor yellowColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_tabbarView setTabbarOffsetX:(scrollView.contentOffset.x)/self.view.bounds.size.width];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
