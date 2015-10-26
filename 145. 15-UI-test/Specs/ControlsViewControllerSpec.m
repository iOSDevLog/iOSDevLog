#import "SpecHelper.h"

#import <KPAStoryboardConvenience/UIStoryboard+KPAConvenience.h>
#import <KPAViewControllerTestHelper.h>

#import "ControlsViewController.h"

SpecBegin(ControlsViewController)

describe(@"ControlsViewController", ^{
    __block ControlsViewController *_viewController;

    before(^{
        // Note that we're testing Strings everywhere. In a real world situation it would be better if the string was provided by a dependency that could be stubbed or faked. I've left that out for the sake of simplicity.
        _viewController = [[UIStoryboard mainStoryboard]
                           instantiateViewControllerForClass:[ControlsViewController class]];
    });

    it(@"updates the state label when the button is pressed", ^{
        [KPAViewControllerTestHelper presentViewController:_viewController];
        [_viewController.button sendActionsForControlEvents:UIControlEventTouchUpInside];
        expect(_viewController.buttonStateLabel.text).to.equal(@"Pressed");
    });

    it(@"updates the segment label when the selected segment changes", ^{
        [KPAViewControllerTestHelper presentViewController:_viewController];
        _viewController.segmentedControl.selectedSegmentIndex = 1;
        [_viewController.segmentedControl sendActionsForControlEvents:UIControlEventValueChanged];
        expect(_viewController.segmentLabel.text).to.equal(@"Segment 1");
    });
});

SpecEnd
