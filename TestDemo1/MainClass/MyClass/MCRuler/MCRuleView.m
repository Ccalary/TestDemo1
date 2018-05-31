//
//  MCRuleView.m
//  MCRuleDemo
//
//  Created by caohouhong on 2018/5/31.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCRuleView.h"
#import "MCRuleCollectionViewCell.h"
#import "MCRuleCollectionReusableView.h"
#define RULE_STEP_WIDTH  5.0
#define RULE_STEP_COUNT  20.0

#define MC_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

typedef void(^scrollBlock)(float x);

@interface MCRuleView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat viewWidth, viewHeight;
@property (nonatomic, copy) scrollBlock block;
@property (nonatomic, assign) BOOL isDrag; //是否拖拽
@end
@implementation MCRuleView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        self.viewWidth = self.frame.size.width;
        self.viewHeight = self.frame.size.height;
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame scrollBlock:(void(^)(float x)) block{
    if (self = [super initWithFrame:frame]){
        self.viewWidth = self.frame.size.width;
        self.viewHeight = self.frame.size.height;
        [self initView];
        if (block){
            self.block = block;
        }
    }
    return self;
}

- (void)initView {
    
    self.isDrag = YES;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    flowLayout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.viewWidth, self.viewHeight) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor greenColor];
    _collectionView.bounces         = NO;
    _collectionView.showsHorizontalScrollIndicator  = NO;
    _collectionView.showsVerticalScrollIndicator    = NO;
    _collectionView.dataSource      = self;
    _collectionView.delegate        = self;
    _collectionView.contentSize     = CGSizeMake(self.viewWidth, self.viewHeight);
    
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[MCRuleCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[MCRuleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [_collectionView registerClass:[MCRuleCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MCRuleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.isMultiple = ((indexPath.row % 10) == 0);
    if (cell.isMultiple){
        cell.content = [NSString stringWithFormat:@"%ld",indexPath.row * 100];
    }else {
        cell.content = @"";
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(RULE_STEP_WIDTH, self.viewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.viewWidth/2.0, self.viewHeight);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.viewWidth/2.0, self.viewHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
         MCRuleCollectionReusableView *headerView = (MCRuleCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        return headerView;
    }else {
        MCRuleCollectionReusableView *footerView = (MCRuleCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        return footerView;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isDrag) return; 
    CGFloat offsetX = scrollView.contentOffset.x;
    float count = offsetX*RULE_STEP_COUNT;
    if (self.block){
        self.block(count);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate){// 如果没有减速行为会走这里
       [self scrollViewStopAtDefinePosition:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewStopAtDefinePosition:scrollView];
}

// 停留在整数位置
- (void)scrollViewStopAtDefinePosition:(UIScrollView *)scrollView {
    if (!self.isDrag) return;
    CGFloat offsetX = scrollView.contentOffset.x;
    int index = (int)roundf(offsetX/RULE_STEP_WIDTH);
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentOffset = CGPointMake(index*RULE_STEP_WIDTH, scrollView.contentOffset.y);
    }completion:^(BOOL finished) {
        float count = index*RULE_STEP_COUNT*RULE_STEP_WIDTH;
        if (self.block){
            self.block(count);
        }
    }];
}

- (void)changePositonWithNum:(double)num {
    self.isDrag = NO;
    double postionX = num/RULE_STEP_COUNT;
    [UIView animateWithDuration:0.2 animations:^{
         self.collectionView.contentOffset = CGPointMake(postionX, self.collectionView.contentOffset.y);
    }completion:^(BOOL finished) {
        self.isDrag = YES;
    }];
}

@end
