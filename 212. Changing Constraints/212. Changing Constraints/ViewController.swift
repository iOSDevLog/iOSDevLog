//
//  ViewController.swift
//  212. Changing Constraints
//
//  Created by iosdevlog on 15/11/29.
//  Copyright © 2015年 iosdevlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /* Image views for each planet (created in -createPlanetViews). */
    private var mercury: UIImageView!
    private var venus: UIImageView!
    private var earth: UIImageView!
    private var mars: UIImageView!
    private var jupiter: UIImageView!
    private var saturn: UIImageView!
    private var uranus: UIImageView!
    private var neptune: UIImageView!
    
    /* To do a basic animation (-changeLayout:), all that's needed is to activate and deactivate an array of constraints. To do more sophisticated animations, holding on to individual constraints instead allows for more control (below). */
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    /* Keeping these around for the more sophisticated animation between layouts found in -keyframeBasedLayoutChange:. If the animation is for a whole set of constraints at once (-changeLayout:), use an array of constraints as seen above with compactConstraints, regularConstraints, and sharedConstraints. */
    private var mercuryLeadingToTrailing: NSLayoutConstraint!
    private var venusLeadingToTrailing: NSLayoutConstraint!
    private var earthLeadingToTrailing: NSLayoutConstraint!
    private var marsLeadingToTrailing: NSLayoutConstraint!
    private var jupiterLeadingToTrailing: NSLayoutConstraint!
    private var saturnLeadingToTrailing: NSLayoutConstraint!
    private var uranusLeadingToTrailing: NSLayoutConstraint!
    private var neptuneLeadingToTrailing: NSLayoutConstraint!
    private var mercuryCenter: NSLayoutConstraint!
    private var venusCenter: NSLayoutConstraint!
    private var earthCenter: NSLayoutConstraint!
    private var marsCenter: NSLayoutConstraint!
    private var jupiterCenter: NSLayoutConstraint!
    private var saturnCenter: NSLayoutConstraint!
    private var uranusCenter: NSLayoutConstraint!
    private var neptuneCenter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.blackColor()
        self.createPlanetViews()
        self.createConstraints()
        self.setUpGestures()
    }
    
    private func createConstraints() {
        /* Constraint creation methods. See comments in each method for more detail. */
        self.planetSizes()
        self.createCompactConstraints()
        self.createRegularConstraints()
        /* Activate a set of constraints for initial layout. */
        NSLayoutConstraint.activateConstraints(regularConstraints)
        NSLayoutConstraint.activateConstraints(sharedConstraints)
    }
    
    /* Method to set identifiers on an array of constraints, used several times in the code. Identifiers make it much easier to debug layout problems later. */
    private func setLayoutIdentifier(identifier: String, forArray constraintsArray: [NSLayoutConstraint]) {
        for constraint in constraintsArray {
            constraint.identifier = identifier
        }
    }
    
    private func createPlanetViews() {
        /* Since 8 views are being created that have essentially identical setup code, just use a block to reduce code overhead.
        This could be also be done 'longhand' by setting up each planet with its own individual code, or in a separate method outside of this one rather than a block inside. */
        func planetCreate(planetName: String) -> UIImageView {
            let planet = UIImageView(image: UIImage(named: planetName)!)
            planet.translatesAutoresizingMaskIntoConstraints = false
            planet.contentMode = UIViewContentMode.ScaleAspectFit
            planet.accessibilityIdentifier = planetName
            /* These identifiers show up in logs, allowing for easier layout debugging. */
            self.view.addSubview(planet)
            return planet
        }
        mercury = planetCreate("Mercury");
        venus = planetCreate("Venus");
        earth = planetCreate("Earth");
        mars = planetCreate("Mars");
        jupiter = planetCreate("Jupiter");
        saturn = planetCreate("Saturn");
        uranus = planetCreate("Uranus");
        neptune = planetCreate("Neptune");
    }
    
    private func planetSizes() {
        /* Using Earth as the basis, create the sizes of the planets. This is easy to adjust in the future if needed for usability or accuracy.
        Also, constrain each planet's width to its own height so that the aspect ratio will be correct during layout.
        These sizes will adapt depending on the size of the environment the view is in so that all 8 planets will be visible. Notice that Earth's height is not directly created anywhere. This allows it to be a bit larger on larger screens (and cause the other planets to be larger as well) and shrink to fit on smaller screens (and reduce the other planets) while keeping the ratios constant. */
        let mercuryHeight = mercury.heightAnchor.constraintEqualToAnchor(earth.heightAnchor, multiplier: 0.38)
        let mercuryWidth  = mercury.widthAnchor.constraintEqualToAnchor(mercury.heightAnchor, multiplier: 1.0)
        let venusHeight   = venus.heightAnchor.constraintEqualToAnchor(earth.heightAnchor, multiplier: 0.95)
        let venusWidth    = venus.widthAnchor.constraintEqualToAnchor(venus.heightAnchor, multiplier: 1.0)
        let marsHeight    = mars.heightAnchor.constraintEqualToAnchor(earth.heightAnchor, multiplier: 0.53)
        let marsWidth     = mars.widthAnchor.constraintEqualToAnchor(mars.heightAnchor, multiplier: 1.0)
        let jupiterHeight = jupiter.heightAnchor.constraintEqualToAnchor(earth.heightAnchor, multiplier: 11.2)
        let jupiterWidth  = jupiter.widthAnchor.constraintEqualToAnchor(jupiter.heightAnchor, multiplier: 1.0)
        let saturnHeight  = saturn.heightAnchor.constraintEqualToAnchor(earth.heightAnchor, multiplier: 9.45)
        let saturnWidth   = saturn.widthAnchor.constraintEqualToAnchor(saturn.heightAnchor, multiplier: 1.5)
        let uranusHeight  = uranus.heightAnchor.constraintEqualToAnchor(earth.heightAnchor, multiplier: 4.0)
        let uranusWidth   = uranus.widthAnchor.constraintEqualToAnchor(uranus.heightAnchor, multiplier: 1.0)
        let neptuneHeight = neptune.heightAnchor.constraintEqualToAnchor(earth.heightAnchor, multiplier: 3.88)
        let neptuneWidth  = neptune.widthAnchor.constraintEqualToAnchor(neptune.heightAnchor, multiplier: 1.0)
        let earthWidth    = earth.widthAnchor.constraintEqualToAnchor(earth.heightAnchor)
        mercuryHeight.identifier = "mercuryHeight";
        mercuryWidth.identifier = "mercuryWidth";
        venusHeight.identifier = "venusHeight";
        venusWidth.identifier = "venusWidth";
        marsHeight.identifier = "marsHeight";
        marsWidth.identifier = "marsWidth";
        jupiterHeight.identifier = "jupiterHeight";
        jupiterWidth.identifier = "jupiterWidth";
        saturnHeight.identifier = "saturnHeight";
        saturnWidth.identifier = "saturnWidth ";
        uranusHeight.identifier = "uranusHeight";
        uranusWidth.identifier = "uranusWidth ";
        neptuneHeight.identifier = "neptuneHeight";
        neptuneWidth.identifier = "neptuneWidth";
        earthWidth.identifier = "earthWidth";
        NSLayoutConstraint.activateConstraints([mercuryHeight, venusHeight, marsHeight, jupiterHeight, saturnHeight, uranusHeight, neptuneHeight, mercuryWidth, venusWidth, earthWidth, marsWidth, jupiterWidth, saturnWidth, uranusWidth, neptuneWidth])
    }
    
    private func createCompactConstraints() {
        /* The constraints for a horizontally compact layout. Don't activate until needed. Don't bother to recreate constraints if they already exist. */
        if compactConstraints.count > 0 {
            return
        }
        /* Simplify creating multiple similar constraints using a block. As with creating the planet views, this could be done individually or in a method outside of this one instead of a block, but since they are so similar, this reduces the amount of code required. Each planet gets its centerXAnchor set to the centerXAnchor of the superview. That means that, in a compact horizontal setting, the planets will be aligned by their centers in the middle of the superview. */
        func createCenterXConstraint(planetToCenter: UIImageView, _ identifierName: String) -> NSLayoutConstraint {
            let newConstraint = planetToCenter.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor)
            newConstraint.identifier = identifierName
            return newConstraint
        }
        mercuryCenter = createCenterXConstraint(mercury, "mercuryCenterX");
        venusCenter   = createCenterXConstraint(venus, "venusCenterX");
        earthCenter   = createCenterXConstraint(earth, "earthCenterX");
        marsCenter    = createCenterXConstraint(mars, "marsCenterX");
        jupiterCenter = createCenterXConstraint(jupiter, "jupiterCenterX");
        saturnCenter  = createCenterXConstraint(saturn, "saturnCenterX");
        uranusCenter  = createCenterXConstraint(uranus, "uranusCenterX");
        neptuneCenter = createCenterXConstraint(neptune, "neptuneCenterX");
        compactConstraints = [mercuryCenter, venusCenter, earthCenter, marsCenter, jupiterCenter, saturnCenter, uranusCenter, neptuneCenter]
    }
    private func createRegularConstraints() {
        /* The constraints for a horizontally regular layout. Don't activate until needed. Constraints shared between the two layouts are also created here. Don't recreate constraints if they already exist. */
        if regularConstraints.count > 0 && sharedConstraints.count > 0 {
            return
        }
        /* Initial setup of layout guides. Layout guides do not show up in the view; they are used as spacers for more complex layouts. Here are layout guides on either side of each planet. They base their widths off of each other to end up with the nice, slightly curved layout of the planets (bottom of this method). These are easier to track and involve less code than using 'dummy' spacer views. */
        func newLayoutGuide(identifierName: String) -> UILayoutGuide {
            let newGuide = UILayoutGuide()
            newGuide.identifier = identifierName
            self.view.addLayoutGuide(newGuide)
            return newGuide
        }
        let leadingMercuryGuide = newLayoutGuide("leadingMercuryGuide");
        let leadingVenusGuide = newLayoutGuide("leadingVenusGuide");
        let leadingEarthGuide = newLayoutGuide("leadingEarthGuide");
        let leadingMarsGuide = newLayoutGuide("leadingMarsGuide");
        let leadingJupiterGuide = newLayoutGuide("leadingJupiterGuide");
        let leadingSaturnGuide = newLayoutGuide("leadingSaturnGuide");
        let leadingUranusGuide = newLayoutGuide("leadingUranusGuide");
        let leadingNeptuneGuide = newLayoutGuide("leadingNeptuneGuide");
        let trailingMercuryGuide = newLayoutGuide("trailingMercuryGuide");
        let trailingVenusGuide = newLayoutGuide("trailingVenusGuide");
        let trailingEarthGuide = newLayoutGuide("trailingEarthGuide");
        let trailingMarsGuide = newLayoutGuide("trailingMarsGuide");
        let trailingJupiterGuide = newLayoutGuide("trailingJupiterGuide");
        let trailingSaturnGuide = newLayoutGuide("trailingSaturnGuide");
        let trailingUranusGuide = newLayoutGuide("trailingUranusGuide");
        let trailingNeptuneGuide = newLayoutGuide("trailingNeptuneGuide");
        let topLayoutGuide = self.topLayoutGuide
        let planetsAndGuides: [String: AnyObject] = [
            "mercury": mercury,
            "venus": venus,
            "earth": earth,
            "mars": mars,
            "jupiter": jupiter,
            "saturn": saturn,
            "uranus": uranus,
            "neptune": neptune,
            "leadingMercuryGuide": leadingMercuryGuide,
            "leadingVenusGuide": leadingVenusGuide,
            "leadingEarthGuide": leadingEarthGuide,
            "leadingMarsGuide": leadingMarsGuide,
            "leadingJupiterGuide": leadingJupiterGuide,
            "leadingSaturnGuide": leadingSaturnGuide,
            "leadingUranusGuide": leadingUranusGuide,
            "leadingNeptuneGuide": leadingNeptuneGuide,
            "trailingMercuryGuide": trailingMercuryGuide,
            "trailingVenusGuide": trailingVenusGuide,
            "trailingEarthGuide": trailingEarthGuide,
            "trailingMarsGuide": trailingMarsGuide,
            "trailingJupiterGuide": trailingJupiterGuide,
            "trailingSaturnGuide": trailingSaturnGuide,
            "trailingUranusGuide": trailingUranusGuide,
            "trailingNeptuneGuide": trailingNeptuneGuide,
            "topLayoutGuide": topLayoutGuide]
        /* Use the layout guides to create the vertical spacing. This could also be done with the planet views themselves. */
        let topToBottom = NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide]-[leadingMercuryGuide]-[leadingVenusGuide]-[leadingEarthGuide]-[leadingMarsGuide]-[leadingJupiterGuide][leadingSaturnGuide][leadingUranusGuide]-[leadingNeptuneGuide]-20-|",
            options: [],
            metrics: [:],
            views: planetsAndGuides)
        sharedConstraints = topToBottom
        self.setLayoutIdentifier("topToBottom", forArray: topToBottom)
        /* Set up the horizontal relationships for the planets and their layout guides using the visual format language (VFL). */
        func newHorizontalArray(layoutString: String, _ arrayID: String) {
            let horizontalConstraintsArray = NSLayoutConstraint.constraintsWithVisualFormat(layoutString,
                options: NSLayoutFormatOptions.AlignAllCenterY,
                metrics: [:],
                views: planetsAndGuides)
            sharedConstraints += horizontalConstraintsArray
            self.setLayoutIdentifier(arrayID, forArray: horizontalConstraintsArray)
        }
        newHorizontalArray("|[leadingMercuryGuide][mercury][trailingMercuryGuide]|", "hMercury")
        newHorizontalArray("|[leadingVenusGuide][venus][trailingVenusGuide]|", "hVenus")
        newHorizontalArray("|[leadingEarthGuide][earth][trailingEarthGuide]|", "hEarth")
        newHorizontalArray("|[leadingMarsGuide][mars][trailingMarsGuide]|", "hMars")
        newHorizontalArray("|[leadingJupiterGuide][jupiter][trailingJupiterGuide]|", "hJupiter")
        newHorizontalArray("|[leadingSaturnGuide][saturn][trailingSaturnGuide]|", "hSaturn")
        newHorizontalArray("|[leadingUranusGuide][uranus][trailingUranusGuide]|", "hUranus")
        newHorizontalArray("|[leadingNeptuneGuide][neptune][trailingNeptuneGuide]|", "hNeptune")
        /* Make the leading guides the same height as their respective planets to ensure the vertical spacing looks right. This could be tweaked if needed to make the spacing less uniform or overlap a bit for when the planets aren't vertically aligned or if a different layout was desired. */
        func guideHeightToPlanetHeight(layoutGuide: UILayoutGuide, _ planet: UIImageView, _ identifier: String) -> NSLayoutConstraint {
            let guideHeightToPlanet = layoutGuide.heightAnchor.constraintEqualToAnchor(planet.heightAnchor)
            guideHeightToPlanet.identifier = identifier
            return guideHeightToPlanet
        }
        let guideHeightToMercury = guideHeightToPlanetHeight(leadingMercuryGuide, mercury, "guideHeightToMercury")
        let guideHeightToVenus   = guideHeightToPlanetHeight(leadingVenusGuide, venus, "guideHeightToVenus")
        let guideHeightToEarth   = guideHeightToPlanetHeight(leadingEarthGuide, earth, "guideHeightToEarth")
        let guideHeightToMars    = guideHeightToPlanetHeight(leadingMarsGuide, mars, "guideHeightToMars")
        let guideHeightToJupiter = guideHeightToPlanetHeight(leadingJupiterGuide, jupiter, "guideHeightToJupiter")
        let guideHeightToSaturn  = guideHeightToPlanetHeight(leadingSaturnGuide, saturn, "guideHeightToSaturn")
        let guideHeightToUranus  = guideHeightToPlanetHeight(leadingUranusGuide, uranus, "guideHeightToUranus")
        let guideHeightToNeptune = guideHeightToPlanetHeight(leadingNeptuneGuide, neptune, "guideHeightToNeptune")
        sharedConstraints += [guideHeightToMercury, guideHeightToVenus, guideHeightToEarth, guideHeightToMars, guideHeightToJupiter, guideHeightToSaturn, guideHeightToUranus, guideHeightToNeptune]
        /* Here, individual constraints need to be created (rather than bulk creation using a block) as each value is different. Fotunately, anchors make this very easy to do. Each planet is already tied to its leading and trailing layout guides, and now all that's needed is a ratio between the guides to space the planets properly. Trying to set up this alignment without guides is possible, but much less adaptive, and takes a lot more code. */
        mercuryLeadingToTrailing = leadingMercuryGuide.widthAnchor.constraintEqualToAnchor( trailingMercuryGuide.widthAnchor, multiplier: 0.02)
        venusLeadingToTrailing   = leadingVenusGuide.widthAnchor.constraintEqualToAnchor(trailingVenusGuide.widthAnchor, multiplier: 0.03)
        earthLeadingToTrailing   = leadingEarthGuide.widthAnchor.constraintEqualToAnchor(trailingEarthGuide.widthAnchor, multiplier: 0.06)
        marsLeadingToTrailing    = leadingMarsGuide.widthAnchor.constraintEqualToAnchor(trailingMarsGuide.widthAnchor, multiplier: 0.1)
        jupiterLeadingToTrailing = leadingJupiterGuide.widthAnchor.constraintEqualToAnchor(trailingJupiterGuide.widthAnchor, multiplier: 0.2)
        saturnLeadingToTrailing  = leadingSaturnGuide.widthAnchor.constraintEqualToAnchor(trailingSaturnGuide.widthAnchor, multiplier: 1.0)
        uranusLeadingToTrailing  = leadingUranusGuide.widthAnchor.constraintEqualToAnchor(trailingUranusGuide.widthAnchor, multiplier: 2.7)
        neptuneLeadingToTrailing = leadingNeptuneGuide.widthAnchor.constraintEqualToAnchor(trailingNeptuneGuide.widthAnchor, multiplier: 10)
        mercuryLeadingToTrailing.identifier = "leadingTrailingAnchorMercury";
        venusLeadingToTrailing.identifier = "leadingTrailingAnchorVenus";
        earthLeadingToTrailing.identifier = "leadingTrailingAnchorEarth";
        marsLeadingToTrailing.identifier = "leadingTrailingAnchorMars";
        jupiterLeadingToTrailing.identifier = "leadingTrailingAnchorJupiter";
        saturnLeadingToTrailing.identifier = "leadingTrailingAnchorSaturn";
        uranusLeadingToTrailing.identifier = "leadingTrailingAnchorUranus";
        neptuneLeadingToTrailing.identifier = "leadingTrailingAnchorNeptune";
        regularConstraints = [mercuryLeadingToTrailing, venusLeadingToTrailing, earthLeadingToTrailing, marsLeadingToTrailing, saturnLeadingToTrailing, jupiterLeadingToTrailing,  uranusLeadingToTrailing, neptuneLeadingToTrailing]
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        /* Check the horizontal trait environment and adjust the layout accordingly. Only deactivate active constraints. */
        if self.traitCollection.containsTraitsInCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Compact)) {
            if regularConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(regularConstraints)
                NSLayoutConstraint.activateConstraints(compactConstraints)
            }
        } else {
            if compactConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(compactConstraints)
                NSLayoutConstraint.activateConstraints(regularConstraints)
            }
        }
    }
    
    func changeLayout(tapGesture: UITapGestureRecognizer) {
        /* When screen is double-tapped, toggle between layouts and animate the change using UIView animation. */
        if tapGesture.state == UIGestureRecognizerState.Ended {
            let regularConstraint = regularConstraints.first!
            let compactConstraint = compactConstraints.first!
            if regularConstraint.active {
                UIView.animateWithDuration(1.0) {
                    NSLayoutConstraint.deactivateConstraints(self.regularConstraints)
                    NSLayoutConstraint.activateConstraints(self.compactConstraints)
                    self.view.layoutIfNeeded()
                }
            } else if compactConstraint.active {
                UIView.animateWithDuration(1.0) {
                    NSLayoutConstraint.deactivateConstraints(self.compactConstraints)
                    NSLayoutConstraint.activateConstraints(self.regularConstraints)
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func keyframeBasedLayoutChange(twoFingerDoubleTap: UITapGestureRecognizer) {
        /* Keyframe animations give more control over how the transition looks. The different timings create different effects.
        If the control doesn't need to be this fine-grained, keeping a reference to the entire array of constraints is enough, as shown with the other tap gesture.
        Try adjusting the timing and options of the constraint changes and see how that affects the animation. */
        if twoFingerDoubleTap.state == UIGestureRecognizerState.Ended {
            let regularConstraint = regularConstraints.first!
            let compactConstraint = compactConstraints.first!
            if regularConstraint.active {
                UIView.animateKeyframesWithDuration(1.5,
                    delay: 0.0,
                    options: UIViewKeyframeAnimationOptions.CalculationModeLinear,
                    animations: {
                        self.animateToCompact()
                    },
                    completion: {finished in
                })
            } else if compactConstraint.active {
                UIView.animateKeyframesWithDuration(1.5,
                    delay: 0.0,
                    options: UIViewKeyframeAnimationOptions.CalculationModeLinear,
                    animations: {
                        self.animateToRegular()
                    },
                    completion: {finished in
                })
            }
        }
    }
    
    private func animateToRegular() {
        /* For this set of animations, compact constraints (vertical line of planets) are deactivated and regular constraints (arc of planets) activated in small groups. All animations start at the same time but then take variable amounts of time to finish, leading to a wave effect. Change the durations or relative start times to see different effects.
        This is called from -keyframeBasedLayoutChange:. */
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0) {
            NSLayoutConstraint.deactivateConstraints([self.mercuryCenter])
            NSLayoutConstraint.activateConstraints([self.mercuryLeadingToTrailing])
            self.view.layoutIfNeeded()
        }
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.9) {
            NSLayoutConstraint.deactivateConstraints([self.venusCenter, self.neptuneCenter])
            NSLayoutConstraint.activateConstraints([self.venusLeadingToTrailing, self.neptuneLeadingToTrailing])
            self.view.layoutIfNeeded()
        }
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.7) {
            NSLayoutConstraint.deactivateConstraints([self.earthCenter, self.uranusCenter])
            NSLayoutConstraint.activateConstraints([self.earthLeadingToTrailing, self.uranusLeadingToTrailing])
            self.view.layoutIfNeeded()
        }
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
            NSLayoutConstraint.deactivateConstraints([self.marsCenter, self.jupiterCenter, self.saturnCenter])
            NSLayoutConstraint.activateConstraints([self.marsLeadingToTrailing, self.jupiterLeadingToTrailing, self.saturnLeadingToTrailing])
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateToCompact() {
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 1.0) {
            NSLayoutConstraint.deactivateConstraints([self.marsLeadingToTrailing, self.jupiterLeadingToTrailing, self.saturnLeadingToTrailing])
            NSLayoutConstraint.activateConstraints([self.marsCenter, self.jupiterCenter, self.saturnCenter])
            self.view.layoutIfNeeded()
        }
        UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 0.9) {
            NSLayoutConstraint.deactivateConstraints([self.earthLeadingToTrailing, self.uranusLeadingToTrailing])
            NSLayoutConstraint.activateConstraints([self.earthCenter, self.uranusCenter])
            self.view.layoutIfNeeded()
        }
        UIView.addKeyframeWithRelativeStartTime(0.3, relativeDuration: 0.7) {
            NSLayoutConstraint.deactivateConstraints([self.venusLeadingToTrailing, self.neptuneLeadingToTrailing])
            NSLayoutConstraint.activateConstraints([self.venusCenter, self.neptuneCenter])
            self.view.layoutIfNeeded()
        }
        UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5) {
            NSLayoutConstraint.deactivateConstraints([self.mercuryLeadingToTrailing])
            NSLayoutConstraint.activateConstraints([self.mercuryCenter])
            self.view.layoutIfNeeded()
        }
    }
    
    private func setUpGestures() {
        /* Double-tap will trigger the 'basic' layout animation. Double-tapping with two fingers (hold down option in the simulator to get multiple fingers) will trigger the keyframe animation. */
        let doubleTap = UITapGestureRecognizer(target: self, action: "changeLayout:")
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(doubleTap)
        let twoFingerDoubleTap = UITapGestureRecognizer(target: self, action: "keyframeBasedLayoutChange:")
        twoFingerDoubleTap.numberOfTapsRequired = 2
        twoFingerDoubleTap.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoFingerDoubleTap)
    }
}

