#import "SpecHelper.h"

#import <KPAStoryboardConvenience/UIStoryboard+KPAConvenience.h>
#import <KPAViewControllerTestHelper/KPAViewControllerTestHelper.h>

#import "TableViewDetailViewController.h"

SpecBegin(TableViewDetailViewController)

describe(@"TableViewDetailViewController", ^{
    __block TableViewDetailViewController *_viewController;

    before(^{
        _viewController = [[UIStoryboard mainStoryboard] instantiateViewControllerForClass:[TableViewDetailViewController class]];
    });

    it(@"shows how it was presented", ^{
        _viewController.presentationKind = @"Test";
        [KPAViewControllerTestHelper presentViewController:_viewController];
        expect(_viewController.presentationKindLabel.text).to.equal(@"Test");
    });

    it(@"raises an exception when presented without a presentation kind", ^{
        expect(^{
            [KPAViewControllerTestHelper presentViewController:_viewController];
        }).to.raise(NSInternalInconsistencyException);
    });
});

SpecEnd
