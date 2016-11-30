//
//  ViewController.m
//  喜马
//
//  Created by 鲁静亚 on 2016/11/30.
//  Copyright © 2016年 鲁静亚. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentedControl.h"
#import "FindBasicViewController.h"
#import "SubFindFactory.h"
@interface ViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic ,strong) HMSegmentedControl* segmentedControl;

@property (nonatomic, strong) NSMutableArray     *controllers;

@property (nonatomic, weak) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSMutableArray     *subTitleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"a",@"b"]];
    self.segmentedControl= segmentedControl;
    segmentedControl.frame = CGRectMake(0, 0, self.view.bounds.size.width, 36.0);
    segmentedControl.selectionIndicatorHeight = 5.0f;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleArrow;
    //        segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGB(0x707d84),NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
//    segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor AppBarTintColor]};
//    segmentedControl.selectionIndicatorColor = [UIColor AppBarTintColor];
    //        segmentedControl.backgroundColor = [UIColor AppSegmentTintColor];
    segmentedControl.borderType = HMSegmentedControlBorderTypeLeft | HMSegmentedControlBorderTypeRight;
//    segmentedControl.borderColor = [UIColor AppBarNewTintColor];
    segmentedControl.borderWidth = 0.5/[UIScreen mainScreen].scale;
    segmentedControl.segmentWidthEx = 90.0;
    segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleCustomize;
    
    [self.segmentedControl setSelectedSegmentIndex:1];
        
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    
    [self.view addSubview:self.pageViewController.view];
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl*)seng
{
    [self.pageViewController setViewControllers:@[[self.controllers objectAtIndex:self.segmentedControl.selectedSegmentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

}



#pragma mark - UIPageViewControllerDelegate/UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    return [self.controllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self indexForViewController:viewController];
    if(index == NSNotFound || index == self.controllers.count - 1) {
        return nil;
    }
    return [self.controllers objectAtIndex:index + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.controllers.count;
}



- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    UIViewController* v =previousViewControllers.firstObject;
    NSUInteger index = [self indexForViewController:viewController];
    [self.segmentedControl setSelectedSegmentIndex:index];
}

#pragma mark - private

- (NSInteger)indexForViewController:(UIViewController *)controller {
    return [self.controllers indexOfObject:controller];
}

#pragma mark - getter

- (UIPageViewController *)pageViewController {
    if(!_pageViewController) {
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionSpineLocationKey];
        UIPageViewController *page = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        page.delegate = self;
        page.dataSource = self;
        [page setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        page.view.frame = CGRectMake(0, 36, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-36);
        [self addChildViewController:page];
        _pageViewController = page;
    }
    return _pageViewController;
}

- (NSMutableArray *)controllers {
    if(!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
        for(NSString *title in self.subTitleArray) {
            FindBasicViewController *con = [SubFindFactory subFindControllerWithIdentifier:title];
            [_controllers addObject:con];
        }
    }
    return _controllers;
}


/**
 *  分类标题数组
 */
- (NSMutableArray *)subTitleArray {
    if(!_subTitleArray) {
        _subTitleArray = [[NSMutableArray alloc] initWithObjects:@"a",@"b",nil];
    }
    return _subTitleArray;
}



@end
