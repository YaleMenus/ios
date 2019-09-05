#import "ViewController.h"
#import "Firebase.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize bKCrowds;
@synthesize bRCrowds;
@synthesize cCCrowds;
@synthesize dCCrowds;
@synthesize bFCrowds;
@synthesize mCCrowds;
@synthesize jECrowds;
@synthesize pMCrowds;
@synthesize pCCrowds;
@synthesize sYCrowds;
@synthesize sMCrowds;
@synthesize eSCrowds;
@synthesize tDCrowds;
@synthesize tCCrowds;

- (void) check {
    
    NSString *url = @"http://sites.google.com/view/yalemenus/";
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    NSString *kill = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];

    // No need to throw error if kill switch check fails, since in that case user will
    // proceed as if the kill switch was off, and will get another error anyway.
    if (err) {}
    
    if ([kill containsString:@"Yale Menus 1"]) {
        
        [FIRAnalytics logEventWithName:@"Kill1" parameters:@{}];
        [self killMessage:@"\nThis app relies on data from Yale Dining to display up-to-date information, but the datasource from Yale Dining has changed, and this version of the app isn't able to read it. We're working on a fix, and will push it out to the App Store as soon as we can. In the meantime, you can try the official Yale Dining app. We apologize for the inconvenience." withTitle:@"Data Changed"];
        
    }
    
    if ([kill containsString:@"Yale Menus 2"]) {
        
        [FIRAnalytics logEventWithName:@"Kill2" parameters:@{}];
        [self killMessage:@"\nThis app relies on data from Yale Dining to display up-to-date information, but the datasource from Yale Dining has changed, and this version of the app isn't able to read it. Luckily, we were able to rewrite the app to make it work again. Please download the newest version from the App Store to resume using our app. We apologize for the inconvenience." withTitle:@"Data Changed"];
        
    }
    
    if ([kill containsString:@"Yale Menus 3"]) {
        
        [FIRAnalytics logEventWithName:@"Kill3" parameters:@{}];
        [self killMessage:@"\nThis app relies on data from Yale Dining to display up-to-date information, but the datasource from Yale Dining has changed, and this version of the app isn't able to read it. We don't plan to release a fix at this time. If you are interested in updating the app to accommodate this change, please email us at yalemenus@gmail.com. We would be glad to speak with you." withTitle:@"Data Changed"];
        
    }
    
    if ([kill containsString:@"Yale Menus 4"]) {
        
        [FIRAnalytics logEventWithName:@"Kill4" parameters:@{}];
        [self killMessage:@"\nThe Yale Dining system is down today, so we aren't able to retrieve meal data. We apologize for the inconvenience and hope to have the app running again as soon as possible. Yale usually resolves these outages within 24 hours." withTitle:@"Yale Dining System Down"];
        
    }
    
    if ([kill containsString:@"YMkill"]) {
        
        [FIRAnalytics logEventWithName:@"YMkill" parameters:@{}];
        
        [self whiteOut];
    }
    
    if ([kill containsString:@"Yale Menus v2.2"]) {
        
        askForSample = TRUE;
        
    }
    
    if ([kill containsString:@"Yale Menus Special Alert"]) {
        [FIRAnalytics logEventWithName:@"YM_Special_Alert" parameters:@{}];
        if ([kill containsString:@"White Out"]) {
            [self whiteOut];
        }
        NSArray *specialAlertTitleArray = [kill componentsSeparatedByString:@"Alert Title"];
        NSString *specialAlertTitle = specialAlertTitleArray[1];
        NSArray *specialAlertArray = [kill componentsSeparatedByString:@"Yale Menus Special Alert"];
        NSString *specialAlert = @"\n";
        specialAlert = [specialAlert stringByAppendingString:specialAlertArray[1]];
        specialAlert = [specialAlert stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        [self killMessage:specialAlert withTitle:specialAlertTitle];
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL showedSwipeReminder = [defaults integerForKey:@"Showed Swipe Reminder"];
    BOOL showedAllergyReminder = [defaults integerForKey:@"Showed Allergy Reminder"] + [defaults integerForKey:@"Peanuts"] + [defaults integerForKey:@"Vegetarian"] + [defaults integerForKey:@"Vegan"] + [defaults integerForKey:@"Dairy"] + [defaults integerForKey:@"Gluten"] + [defaults integerForKey:@"Eggs"] + [defaults integerForKey:@"Soy"] + [defaults integerForKey:@"Pork"] + [defaults integerForKey:@"Nuts"] + [defaults integerForKey:@"Alcohol"] + [defaults integerForKey:@"Shellfish"] + [defaults integerForKey:@"Seafood"]; //if you've showed the allergy reminder, or if they've set any allergy prefs, don't show the alert
    
    if ([kill containsString:@"Swipe"] && !showedSwipeReminder) {
        [FIRAnalytics logEventWithName:@"Swipe_Reminder" parameters:@{}];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Vote With a Swipe!"
                                      message:@"\nDid you know that you can swipe left to dislike or swipe right to like individual menu items?\n\nIf you do this, we'll anonymously share your responses with Yale to help them understand student food preferences.\n\nWe'll also put a small thumbs up or thumbs down next to that menu item when it comes up in the future so you know what to eat or avoid."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Got it!"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        [defaults setInteger:1 forKey:@"Showed Swipe Reminder"];
    }
    
    if ([kill containsString:@"Allergy"] && !showedAllergyReminder) {
        [FIRAnalytics logEventWithName:@"Allergy_Reminder" parameters:@{}];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Mark Your Allergies on Yale Menus!"
                                     message:@"\nDid you know that you can indicate your allergies and/or food preferences in Yale Menus? Just tap the gear in the upper-right corner of any menu, and choose what you're allergic to. We'll gray out any future menu items that Yale believes to contain these ingredients."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Got it!"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        [defaults setInteger:1 forKey:@"Showed Allergy Reminder"];
    }
}

-(void) killMessage:(NSString*)message withTitle: (NSString*) title {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)whiteOut {
    killed = TRUE;
    
    UIImageView *whiteView =[[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    whiteView.image=[UIImage imageNamed:@"White"];
    whiteView.userInteractionEnabled = YES; //to prevent other background buttons from still working
    [self.view addSubview:whiteView];
    
    UILabel *dead = [[UILabel alloc] init];
    dead.numberOfLines = 0;
    [dead setFrame:CGRectMake(12,190,350,200)];
    dead.backgroundColor=[UIColor clearColor];
    dead.textColor=[UIColor blackColor];
    dead.userInteractionEnabled=YES;
    dead.font = [UIFont fontWithName:@"Optima" size:24];
    dead.text = @"This version of Yale Menus is no longer operational.";
    [self.view addSubview:dead];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnToApp) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger tutorialDefaults = [defaults integerForKey:@"Tutorial"];
    NSInteger newTutorialDefaults = [defaults integerForKey:@"2.2FeaturesTutorialShown"];
    if (!killed && (tutorialDefaults == 1) && (newTutorialDefaults != 1)) [self newFeatures];
    if (!killed && (tutorialDefaults != 1)) [self startTutorial];
    if (!killed && (tutorialDefaults == 1)) [self downloadCrowds];
    //first time: tutorial and no crowds
    //other time: crowds and no tutorial
    //when tutorial is done, it will call the downloadCrowds method itself
    //this way, internet connectivity warnings don't interrupt the tutorial
    
    [self check];
}


-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) switchAllergies {
    iCantEat.hidden = !(showAllergies);
    
    peanuts.hidden = !(showAllergies);
    vegetarian.hidden = !(showAllergies);
    vegan.hidden = !(showAllergies);
    dairy.hidden = !(showAllergies);
    gluten.hidden = !(showAllergies);
    eggs.hidden = !(showAllergies);
    soy.hidden = !(showAllergies);
    pork.hidden = !(showAllergies);
    nuts.hidden = !(showAllergies);
    alcohol.hidden = !(showAllergies);
    shellfish.hidden = !(showAllergies);
    seafood.hidden = !(showAllergies);
    
    peanutView.hidden = !(showAllergies);
    vegetarianView.hidden = !(showAllergies);
    veganView.hidden = !(showAllergies);
    dairyView.hidden = !(showAllergies);
    glutenView.hidden = !(showAllergies);
    eggsView.hidden = !(showAllergies);
    soyView.hidden = !(showAllergies);
    porkView.hidden = !(showAllergies);
    nutsView.hidden = !(showAllergies);
    alcoholView.hidden = !(showAllergies);
    shellfishView.hidden = !(showAllergies);
    seafoodView.hidden = !(showAllergies);
    
    disclaimer.hidden = !(showAllergies);
    homeFromAllergies.hidden = !(showAllergies);
    
    allergiesButton.hidden = showAllergies;
    backToHomeButton.hidden = showAllergies;
    
    [self.view addSubview:iCantEat];
    
    [self.view addSubview:peanuts];
    [self.view addSubview:vegetarian];
    [self.view addSubview:vegan];
    [self.view addSubview:dairy];
    [self.view addSubview:gluten];
    [self.view addSubview:eggs];
    [self.view addSubview:soy];
    [self.view addSubview:pork];
    [self.view addSubview:nuts];
    [self.view addSubview:alcohol];
    [self.view addSubview:shellfish];
    [self.view addSubview:seafood];
    
    [self.view addSubview:peanutView];
    [self.view addSubview:vegetarianView];
    [self.view addSubview:veganView];
    [self.view addSubview:dairyView];
    [self.view addSubview:glutenView];
    [self.view addSubview:eggsView];
    [self.view addSubview:soyView];
    [self.view addSubview:porkView];
    [self.view addSubview:nutsView];
    [self.view addSubview:alcoholView];
    [self.view addSubview:shellfishView];
    [self.view addSubview:seafoodView];
    
    [self.view addSubview:disclaimer];
    
    [self.view addSubview:homeFromAllergies];
    
    daySegments.hidden = showAllergies;
    mealSegments.hidden = showAllergies;
    
    noMeals.hidden = showAllergies;
    partialNoMeals.hidden = showAllergies;
    sample.hidden = showAllergies;
    sample.enabled = (!showAllergies);
    sample.userInteractionEnabled = (!showAllergies);
    
    menuDiningHall.hidden = showAllergies;
    tableView.hidden = showAllergies;
    menuDate.hidden = showAllergies;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //TO USE TEST DATA:
    //askForSample = TRUE;
    //END USE FOR TEST DATA
    
    showAllergies = FALSE;
    [self switchAllergies];
    
    white.alpha = 1;
    white.hidden = TRUE;
    daySegments.hidden = TRUE;
    mealSegments.hidden = TRUE;
    lbl1.hidden = TRUE;
    lbl2.hidden = TRUE;
    lbl3.hidden = TRUE;
    backToHomeButton.hidden = TRUE;
    
    skipTutorial.hidden = TRUE;
    
    breakfastButton.enabled = NO;
    breakfastButton.userInteractionEnabled = NO;
    lunchButton.enabled = NO;
    lunchButton.userInteractionEnabled = NO;
    dinnerButton.enabled = NO;
    dinnerButton.userInteractionEnabled = NO;
    
    menuDiningHall.hidden = TRUE;
    menuMeal.hidden = TRUE;
    //backToMealsButton.hidden = TRUE;
    tableView.hidden = TRUE;
    menuDate.hidden = TRUE;
    allergiesButton.hidden = TRUE;
    
    noMeals.hidden = TRUE;
    partialNoMeals.hidden = TRUE;
    sample.hidden = TRUE;
    [sample.titleLabel setTextAlignment:NSTextAlignmentCenter];
    showSample = FALSE;
    sample.enabled = NO;
    sample.userInteractionEnabled = NO;
    
    isToday = TRUE;
    datesInverted = FALSE;
    
    infoButton.titleLabel.adjustsFontSizeToFitWidth = YES; //ensures these buttons will be readable on small phones
    infoButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    homeFromAllergies.titleLabel.adjustsFontSizeToFitWidth = YES;
    homeFromAllergies.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    //segmented control setup
    UIFont *font = [UIFont fontWithName:@"Optima"size:14];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [daySegments setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [daySegments addTarget:self action:@selector(changeDay) forControlEvents:UIControlEventValueChanged]; //listen for changes to segmented control and call changeDay when the segmented control changes selected segment
    [mealSegments setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [mealSegments addTarget:self action:@selector(changeMeal) forControlEvents:UIControlEventValueChanged];
    
    [switchPeanut addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchVegetarian addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchVegan addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchDairy addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchGluten addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchEggs addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchSoy addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchPork addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchNuts addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchAlcohol addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchShellfish addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    [switchSeafood addTarget:self action:@selector(changeAllergy:) forControlEvents:UIControlEventValueChanged];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(leftSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [tableView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(rightSwipe:)];
    recognizer.delegate = self;
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [tableView addGestureRecognizer:recognizer];
}

- (void) changeAllergy : (UISwitch*) sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:[switchPeanut isOn] forKey:@"Peanuts"];
    [defaults setInteger:[switchVegetarian isOn] forKey:@"Vegetarian"];
    [defaults setInteger:[switchVegan isOn] forKey:@"Vegan"];
    [defaults setInteger:[switchDairy isOn] forKey:@"Dairy"];
    [defaults setInteger:[switchGluten isOn] forKey:@"Gluten"];
    [defaults setInteger:[switchEggs isOn] forKey:@"Eggs"];
    [defaults setInteger:[switchSoy isOn] forKey:@"Soy"];
    [defaults setInteger:[switchPork isOn] forKey:@"Pork"];
    [defaults setInteger:[switchNuts isOn] forKey:@"Nuts"];
    [defaults setInteger:[switchAlcohol isOn] forKey:@"Alcohol"];
    [defaults setInteger:[switchShellfish isOn] forKey:@"Shellfish"];
    [defaults setInteger:[switchSeafood isOn] forKey:@"Seafood"];
    [defaults synchronize];
    
    if ([sender isEqual:switchPeanut]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Peanut", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchPeanut isOn]]}];
    if ([sender isEqual:switchVegetarian]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Vegetarian", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchVegetarian isOn]]}];
    if ([sender isEqual:switchVegan]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Vegan", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchVegan isOn]]}];
    if ([sender isEqual:switchDairy]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Dairy", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchDairy isOn]]}];
    if ([sender isEqual:switchGluten]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Gluten", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchGluten isOn]]}];
    if ([sender isEqual:switchEggs]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Eggs", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchEggs isOn]]}];
    if ([sender isEqual:switchSoy]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Soy", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchSoy isOn]]}];
    if ([sender isEqual:switchPork]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Pork", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchPork isOn]]}];
    if ([sender isEqual:switchNuts]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Nuts", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchNuts isOn]]}];
    if ([sender isEqual:switchAlcohol]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Alcohol", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchAlcohol isOn]]}];
    if ([sender isEqual:switchShellfish]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Shellfish", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchShellfish isOn]]}];
    if ([sender isEqual:switchSeafood]) [FIRAnalytics logEventWithName:@"Allergen_Changed" parameters:@{@"Allergen":@"Seafood", @"New_Switch_State_0off_1on":[NSNumber numberWithBool:[switchSeafood isOn]]}];
}

- (IBAction)showAllergiesScreen:(id)sender {
    [FIRAnalytics logEventWithName:@"Show_Allergies_Screen" parameters:@{}];
    
    showAllergies = TRUE;
    [self switchAllergies];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Disclaimer"
                                  message:@"On the following page, you have the option to indicate food restrictions. While we offer this feature as a convenience to our users with food allergies/intolerances/aversions, we cannot and do not guarantee that an item marked as not containing a certain ingredient actually does not contain that ingredient, because we rely on imperfect data from Yale.\n\nIf eating a certain type of food could make you sick, stay in communication with dining hall workers about potential allergens, and do not rely on the data here to tell you what you can and cannot eat — again, we provide this merely as a convenience."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"I understand and agree."
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [self hideAllergiesScreen:nil];
                                 
                             }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger peanutYesNo = [defaults integerForKey:@"Peanuts"];
    NSInteger vegetarianYesNo = [defaults integerForKey:@"Vegetarian"];
    NSInteger veganYesNo = [defaults integerForKey:@"Vegan"];
    NSInteger dairyYesNo = [defaults integerForKey:@"Dairy"];
    NSInteger glutenYesNo = [defaults integerForKey:@"Gluten"];
    NSInteger eggsYesNo = [defaults integerForKey:@"Eggs"];
    NSInteger soyYesNo = [defaults integerForKey:@"Soy"];
    NSInteger porkYesNo = [defaults integerForKey:@"Pork"];
    NSInteger nutsYesNo = [defaults integerForKey:@"Nuts"];
    NSInteger alcoholYesNo = [defaults integerForKey:@"Alcohol"];
    NSInteger shellfishYesNo = [defaults integerForKey:@"Shellfish"];
    NSInteger seafoodYesNo = [defaults integerForKey:@"Seafood"];
    
    if (peanutYesNo == 1) [switchPeanut setOn:TRUE];
    if (vegetarianYesNo == 1) [switchVegetarian setOn:TRUE];
    if (veganYesNo == 1) [switchVegan setOn:TRUE];
    if (dairyYesNo == 1) [switchDairy setOn:TRUE];
    if (glutenYesNo == 1) [switchGluten setOn:TRUE];
    if (eggsYesNo == 1) [switchEggs setOn:TRUE];
    if (soyYesNo == 1) [switchSoy setOn:TRUE];
    if (porkYesNo == 1) [switchPork setOn:TRUE];
    if (nutsYesNo == 1) [switchNuts setOn:TRUE];
    if (alcoholYesNo == 1) [switchAlcohol setOn:TRUE];
    if (shellfishYesNo == 1) [switchShellfish setOn:TRUE];
    if (seafoodYesNo == 1) [switchSeafood setOn:TRUE];
}

- (IBAction)hideAllergiesScreen:(id)sender {
    showAllergies = FALSE;
    [self switchAllergies];
    [tableView reloadData];
    if (bKButton.hidden == FALSE) {[self backToHome:nil];} //if the user has the dialog open, then puts the app in the background without choosing an option, then when s/he comes back and presses cancel, would otherwise go back to both the meal screen and the allergy screen = BAD. The disclaimer wouldn't ever be hidden unless the user had been shunted back to the home page
}

- (IBAction)refresh:(id)sender {
    [FIRAnalytics logEventWithName:@"Refresh_on_homescreen" parameters:@{}];
    reloadButton.hidden = TRUE;
    [activityIndicator startAnimating];
    [self downloadCrowds];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showRefresh) userInfo:nil repeats:NO];
    //downloading crowds happens very quickly, hence the need to show the indicator for at least 0.5 seconds
}

- (void) showRefresh {
    [activityIndicator stopAnimating];
    reloadButton.hidden = FALSE;
}

- (void)makeCollegeButtons {
    //Recreated these buttons in IB, so this method is no longer necessary
    //Calls to this method have been removed, but it is being retained for archival purposes
    //(The only existing call was at the beginning of viewDidLoad)
    
    bKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bKButton setFrame:CGRectMake(37, 64, 55, 61)];
    [bKButton setImage:[UIImage imageNamed:@"BK.png"] forState:UIControlStateNormal];
    [self.view addSubview:bKButton];
    
    bRButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bRButton setFrame:CGRectMake(160, 64, 55, 61)];
    [bRButton setImage:[UIImage imageNamed:@"BR.png"] forState:UIControlStateNormal];
    [self.view addSubview:bRButton];
    
    cCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cCButton setFrame:CGRectMake(160, 185, 55, 61)];
    [cCButton setImage:[UIImage imageNamed:@"CC.png"] forState:UIControlStateNormal];
    [self.view addSubview:cCButton];
    
    dCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dCButton setFrame:CGRectMake(284, 64, 55, 61)];
    [dCButton setImage:[UIImage imageNamed:@"DC.png"] forState:UIControlStateNormal];
    [self.view addSubview:dCButton];
    
    bFButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bFButton setFrame:CGRectMake(37, 185, 55, 61 )];
    [bFButton setImage:[UIImage imageNamed:@"BF.png"] forState:UIControlStateNormal];
    [self.view addSubview:bFButton];
    
    mCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mCButton setFrame:CGRectMake(284, 185, 55, 61)];
    [mCButton setImage:[UIImage imageNamed:@"MC.png"] forState:UIControlStateNormal];
    [self.view addSubview:mCButton];
    
    jEButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jEButton setFrame:CGRectMake(37, 306, 55, 61)];
    [jEButton setImage:[UIImage imageNamed:@"JE.png"] forState:UIControlStateNormal];
    [self.view addSubview:jEButton];
    
    pMButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pMButton setFrame:CGRectMake(160, 306, 55, 61)];
    [pMButton setImage:[UIImage imageNamed:@"PM.png"] forState:UIControlStateNormal];
    [self.view addSubview:pMButton];
    
    pCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pCButton setFrame:CGRectMake(284, 306, 55, 61)];
    [pCButton setImage:[UIImage imageNamed:@"PC.png"] forState:UIControlStateNormal];
    [self.view addSubview:pCButton];
    
    sYButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sYButton setFrame:CGRectMake(37, 427, 55, 61)];
    [sYButton setImage:[UIImage imageNamed:@"SY.png"] forState:UIControlStateNormal];
    [self.view addSubview:sYButton];
    
    sMButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sMButton setFrame:CGRectMake(160, 427, 55, 61)];
    [sMButton setImage:[UIImage imageNamed:@"SM.png"] forState:UIControlStateNormal];
    [self.view addSubview:sMButton];
    
    eSButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [eSButton setFrame:CGRectMake(284, 427, 55, 61)];
    [eSButton setImage:[UIImage imageNamed:@"ES.png"] forState:UIControlStateNormal];
    [self.view addSubview:eSButton];
    
    tDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tDButton setFrame:CGRectMake(37, 548, 55, 61)];
    [tDButton setImage:[UIImage imageNamed:@"TD.png"] forState:UIControlStateNormal];
    [self.view addSubview:tDButton];
    
    tCButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tCButton setFrame:CGRectMake(160, 548, 55, 61)];
    [tCButton setImage:[UIImage imageNamed:@"TC.png"] forState:UIControlStateNormal];
    [self.view addSubview:tCButton];
    
    [bKButton addTarget: self action:@selector(bKGo:) forControlEvents:UIControlEventTouchUpInside];
    [bRButton addTarget: self action:@selector(bRGo:) forControlEvents:UIControlEventTouchUpInside];
    [cCButton addTarget: self action:@selector(cCGo:) forControlEvents:UIControlEventTouchUpInside];
    [dCButton addTarget: self action:@selector(dCGo:) forControlEvents:UIControlEventTouchUpInside];
    [bFButton addTarget: self action:@selector(bFGo:) forControlEvents:UIControlEventTouchUpInside];
    [mCButton addTarget: self action:@selector(mCGo:) forControlEvents:UIControlEventTouchUpInside];
    [jEButton addTarget: self action:@selector(jEGo:) forControlEvents:UIControlEventTouchUpInside];
    [pMButton addTarget: self action:@selector(pMGo:) forControlEvents:UIControlEventTouchUpInside];
    [pCButton addTarget: self action:@selector(pCGo:) forControlEvents:UIControlEventTouchUpInside];
    [sYButton addTarget: self action:@selector(sYGo:) forControlEvents:UIControlEventTouchUpInside];
    [sMButton addTarget: self action:@selector(sMGo:) forControlEvents:UIControlEventTouchUpInside];
    [eSButton addTarget: self action:@selector(eSGo:) forControlEvents:UIControlEventTouchUpInside];
    [tDButton addTarget: self action:@selector(tDGo:) forControlEvents:UIControlEventTouchUpInside];
    [tCButton addTarget: self action:@selector(tCGo:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)info:(id)sender {
    [FIRAnalytics logEventWithName:@"Info_Button" parameters:@{}];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Information and License"
                                 message:@"\nThanks for choosing Yale Menus! Yale Menus was created by Yalies who wanted a more user-friendly way to track menu items, allergens, and crowding in Yale’s dining halls.\n\nTo review the tutorial you saw when you first opened the app, tap \"View Tutorial.\"\n\n\"Yale\" and \"Yale University\" are registered trademarks of Yale University. This application is maintained, hosted, and operated independently of Yale University. The statements and information contained in this application are not reviewed, approved or endorsed by Yale.\n\nThis app was built by Eric Foster (Yale GH '20), with help from Jacob Malinowski (Yale GH '20) and David Foster (Yale GH '23)."
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];

    UIAlertAction* tutorial = [UIAlertAction
                               actionWithTitle:@"View Tutorial"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [self tutorialFromInfo];
                               }];

    [alert addAction:ok];
    [alert addAction:tutorial];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)initButtons {
    // Recreated these buttons in IB, so this method is no longer necessary
    // Calls to this method have been removed, but it is being retained for archival purposes
    // (The only existing call was at the beginning of viewDidLoad)
    
    backToHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backToHomeButton.hidden = TRUE;
    [backToHomeButton setFrame:CGRectMake(16, 25, 40, 40)];
    [self.view addSubview:backToHomeButton];
    
    breakfastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    breakfastButton.hidden = TRUE;
    [breakfastButton setFrame:CGRectMake(0, 79, 375, 150)];
    [self.view addSubview:breakfastButton];
    
    lbl1 = [[UILabel alloc] init];
    lbl1.hidden = TRUE;
    [lbl1 setFrame:CGRectMake(115,190,146,29)];
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.textColor=[UIColor whiteColor];
    lbl1.userInteractionEnabled=YES;
    lbl1.font = [UIFont fontWithName:@"Optima" size:24];
    [self.view addSubview:lbl1];
    
    lunchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lunchButton.hidden = TRUE;
    [lunchButton setFrame:CGRectMake(0, 275, 375, 150)];
    [self.view addSubview:lunchButton];
    
    lbl2 = [[UILabel alloc] init];
    lbl2.hidden = TRUE;
    [lbl2 setFrame:CGRectMake(115,385,146,29)];
    lbl2.backgroundColor=[UIColor clearColor];
    lbl2.textColor=[UIColor whiteColor];
    lbl2.userInteractionEnabled=YES;
    lbl2.font = [UIFont fontWithName:@"Optima" size:24];
    [self.view addSubview:lbl2];
    
    lbl2 = [[UILabel alloc] init];
    lbl2.hidden = TRUE;
    [lbl2 setFrame:CGRectMake(115,385,146,29)];
    lbl2.backgroundColor=[UIColor clearColor];
    lbl2.textColor=[UIColor whiteColor];
    lbl2.userInteractionEnabled=YES;
    lbl2.font = [UIFont fontWithName:@"Optima" size:24];
    [self.view addSubview:lbl2];
    
    dinnerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dinnerButton.hidden = TRUE;
    [dinnerButton setFrame:CGRectMake(0, 471, 375, 150)];
    [self.view addSubview:dinnerButton];
    
    lbl3 = [[UILabel alloc] init];
    lbl3.hidden = TRUE;
    [lbl3 setFrame:CGRectMake(115,580,146,29)];
    lbl3.backgroundColor=[UIColor clearColor];
    lbl3.textColor=[UIColor whiteColor];
    lbl3.userInteractionEnabled=YES;
    lbl3.font = [UIFont fontWithName:@"Optima" size:24];
    [self.view addSubview:lbl3];
    
    [backToHomeButton addTarget: self action:@selector(backToHome:) forControlEvents:UIControlEventTouchUpInside];
    [breakfastButton addTarget: self action:@selector(breakfast) forControlEvents:UIControlEventTouchUpInside];
    [lunchButton addTarget: self action:@selector(lunch) forControlEvents:UIControlEventTouchUpInside];
    [dinnerButton addTarget: self action:@selector(dinner) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)getSample:(id)sender {
    [FIRAnalytics logEventWithName:@"User_Requested_Sample_Data" parameters:@{@"Dining_Hall":diningHall}];
    
    showSample = TRUE;
    sample.hidden = TRUE;
    sample.enabled = NO;
    sample.userInteractionEnabled = NO;
    askForSample = FALSE; //don't want to show this again
    noMeals.hidden = TRUE; //don't need to hide partialNoMeals because that won't show if you're given the option to see a sample
    tableView.hidden = FALSE; //this would have been hidden before because there were no meals
    isToday = TRUE;
    [daySegments insertSegmentWithTitle:@"Today's Meals" atIndex:0 animated:FALSE];
    [daySegments insertSegmentWithTitle:@"Tomorrow's Meals" atIndex:1 animated:FALSE];
    [self getMealTimes];
    [self menuScreenSetup];
}

- (void) menuScreenSetup { //should only run once per dining hall click, and isToday should always be true when it's called
    [FIRAnalytics logEventWithName:@"Menu_Screen_Setup" parameters:@{@"Dining_Hall":diningHall}];
    
    daySegments.selectedSegmentIndex = 0;
    
    bKButton.hidden = TRUE;
    bRButton.hidden = TRUE;
    cCButton.hidden = TRUE;
    dCButton.hidden = TRUE;
    bFButton.hidden = TRUE;
    mCButton.hidden = TRUE;
    jEButton.hidden = TRUE;
    pMButton.hidden = TRUE;
    pCButton.hidden = TRUE;
    sYButton.hidden = TRUE;
    sMButton.hidden = TRUE;
    eSButton.hidden = TRUE;
    tDButton.hidden = TRUE;
    tCButton.hidden = TRUE;
    
    reloadButton.hidden = TRUE;
    
    infoButton.hidden = TRUE;
    
    title1.hidden = TRUE;
    title2.hidden = TRUE;
    
    /* THIS IS LEGACY CODE FROM THE MEAL SELECTOR INTERFACE
     breakfastButton.hidden = TRUE;
     breakfastButton.enabled = NO;
     breakfastButton.userInteractionEnabled = NO;
     lunchButton.hidden = TRUE;
     lunchButton.enabled = NO;
     lunchButton.userInteractionEnabled = NO;
     dinnerButton.hidden = TRUE;
     dinnerButton.enabled = NO;
     dinnerButton.userInteractionEnabled = NO;
     */
    
    backToHomeButton.hidden = FALSE;
    [self.view addSubview:backToHomeButton];
    
    NSString *dhall;
    
    if ([diningHall isEqualToString:@"BK"]) dhall = @"Berkeley";
    if ([diningHall isEqualToString:@"BR"]) dhall = @"Branford";
    if ([diningHall isEqualToString:@"DC"]) dhall = @"Davenport";
    if ([diningHall isEqualToString:@"BF"]) dhall = @"Franklin";
    if ([diningHall isEqualToString:@"CC"]) dhall = @"Hopper";
    if ([diningHall isEqualToString:@"MC"]) dhall = @"Morse";
    if ([diningHall isEqualToString:@"JE"]) dhall = @"J.E.";
    if ([diningHall isEqualToString:@"PM"]) dhall = @"Murray";
    if ([diningHall isEqualToString:@"PC"]) dhall = @"Pierson";
    if ([diningHall isEqualToString:@"SY"]) dhall = @"Saybrook";
    if ([diningHall isEqualToString:@"SM"]) dhall = @"Silliman";
    if ([diningHall isEqualToString:@"ES"]) dhall = @"Stiles";
    if ([diningHall isEqualToString:@"TD"]) dhall = @"T.D.";
    if ([diningHall isEqualToString:@"TC"]) dhall = @"Trumbull";
    
    if ([actualDiningHall isEqualToString:@"SY"] && [diningHall isEqualToString:@"BR"]) dhall = @"Saybrook";
    if ([actualDiningHall isEqualToString:@"ES"] && [diningHall isEqualToString:@"MC"]) dhall = @"Stiles";
    
    menuDiningHall.text = dhall;
    menuDiningHall.hidden = FALSE;
    
    [self.view addSubview:menuDiningHall];
    
    allergiesButton.hidden = FALSE;
    
    [self.view addSubview:allergiesButton];
    
    NSString *noMealsString = [NSString stringWithFormat:@"%@ has no meals today or tomorrow.",dhall];
    
    if (hasAnyMeals) { //initialize the day segment picker
        if (isToday) {
            isToday = FALSE;
            [self getMealTimes];
            
            if (!hasAnyMeals) {
                [daySegments removeSegmentAtIndex:1 animated:FALSE];
                [daySegments setFrame:CGRectMake(daySegments.frame.origin.x, daySegments.frame.origin.y, (daySegments.frame.size.width)/2,daySegments.frame.size.height)];
                daySegments.selectedSegmentIndex = 0;
                partialNoMeals.text = @"No meals tomorrow.";
                partialNoMeals.hidden = FALSE;
                [self.view addSubview:partialNoMeals];
            }
            
            isToday = TRUE;
            [self getMealTimes];
        }
        
        if (!isToday) {
            isToday = TRUE;
            [self getMealTimes];
            
            if (!hasAnyMeals) {
                [daySegments removeSegmentAtIndex:0 animated:FALSE];
                [daySegments setFrame:CGRectMake(daySegments.frame.origin.x, daySegments.frame.origin.y, (daySegments.frame.size.width)/2,daySegments.frame.size.height)];
                daySegments.selectedSegmentIndex = 0; //now 0 is tomorrow
                partialNoMeals.text = @"No meals today.";
                partialNoMeals.hidden = FALSE;
                [self.view addSubview:partialNoMeals];
            }
            
            isToday = FALSE;
            [self getMealTimes];
        }
    }
    
    if (!hasAnyMeals) {
        if (isToday) {
            [FIRAnalytics logEventWithName:@"No_Meals_Today" parameters:@{@"Dining_Hall":diningHall}];
            
            isToday = FALSE;
            [self getMealTimes];
            
            if (hasAnyMeals) {
                [daySegments removeSegmentAtIndex:0 animated:FALSE];
                [daySegments setFrame:CGRectMake(daySegments.frame.origin.x, daySegments.frame.origin.y, (daySegments.frame.size.width)/2,daySegments.frame.size.height)];
                daySegments.selectedSegmentIndex = 0; //since now tomorrow is index 0
                partialNoMeals.text = @"No meals today.";
                partialNoMeals.hidden = FALSE;
                [self.view addSubview:partialNoMeals];
            } else {
                [FIRAnalytics logEventWithName:@"No_Meals_At_All" parameters:@{@"Dining_Hall":diningHall}];
                
                tableView.hidden = TRUE;
                noMeals.text = noMealsString;
                [self.view addSubview:noMeals];
                noMeals.hidden = FALSE;
                [daySegments removeAllSegments];
                
                if (askForSample) {
                    sample.hidden = FALSE;
                    noMeals.hidden = TRUE;
                    sample.enabled = YES;
                    sample.userInteractionEnabled = YES;
                    [self.view addSubview:sample];
                }
            }
        }
        
        else {
            [FIRAnalytics logEventWithName:@"No_Meals_Tomorrow" parameters:@{@"Dining_Hall":diningHall}];
            
            isToday = TRUE;
            [self getMealTimes];
            
            if (hasAnyMeals) {
                [daySegments removeSegmentAtIndex:1 animated:FALSE];
                [daySegments setFrame:CGRectMake(daySegments.frame.origin.x, daySegments.frame.origin.y, (daySegments.frame.size.width)/2,daySegments.frame.size.height)];
                daySegments.selectedSegmentIndex = 0;
                partialNoMeals.text = @"No meals tomorrow.";
                partialNoMeals.hidden = FALSE;
                [self.view addSubview:partialNoMeals];
                [self mealAutoSelect];
            } else {
                [FIRAnalytics logEventWithName:@"No_Meals_At_All" parameters:@{@"Dining_Hall":diningHall}];
                
                tableView.hidden = TRUE;
                noMeals.text = noMealsString;
                [self.view addSubview:noMeals];
                noMeals.hidden = FALSE;
                [daySegments removeAllSegments];
                
                if (askForSample) {
                    sample.hidden = FALSE;
                    noMeals.hidden = TRUE;
                    sample.enabled = YES;
                    sample.userInteractionEnabled = YES;
                    [self.view addSubview:sample];
                }
            }
        }
    }
    
    white.hidden = FALSE;
    
    daySegments.hidden = FALSE;
    mealSegments.hidden = FALSE;
    
    [self makeMealSegments];
}

- (void) makeMealSegments {
    NSNumber *analyticsDay; //use this for firebase tracking below
    if (isToday) analyticsDay = @0;
    if (!isToday) analyticsDay = @1;
    
    [FIRAnalytics logEventWithName:@"Make_Meal_Segments" parameters:@{@"Dining_Hall":diningHall,@"Day":analyticsDay}];
    
    [mealSegments removeAllSegments];
    
    if (hasBreakfast) {
        int index = (int) [mealSegments numberOfSegments];
        
        [mealSegments insertSegmentWithTitle:@"Breakfast" atIndex:index animated:FALSE];
        
        /*breakfastButton.hidden = FALSE;
         breakfastButton.enabled = YES;
         breakfastButton.userInteractionEnabled = YES;
         [breakfastButton setImage:[UIImage imageNamed:@"Breakfast.png"] forState:UIControlStateNormal];
         [self.view addSubview:breakfastButton];
         
         lbl1.hidden = FALSE;*/
        
        if ((hotToday && isToday) || (hotTomorrow && !isToday)) {
            mealOneTime = hotTime;
        }
        
        if ((!hotToday && isToday) || (!hotTomorrow && !isToday)) {
            mealOneTime = continentalTime;
        }
        
        //[self.view addSubview:lbl1];
    }
    
    if (hasLunch) {
        /*lunchButton.hidden = FALSE;
         lunchButton.enabled = YES;
         lunchButton.userInteractionEnabled = YES;
         [lunchButton setImage:[UIImage imageNamed:@"Lunch.png"] forState:UIControlStateNormal];
         [self.view addSubview:lunchButton];
         
         lbl2.hidden = FALSE;
         lbl2.text = lunchTime;
         [self.view addSubview:lbl2];*/
        int index = (int) [mealSegments numberOfSegments];
        [mealSegments insertSegmentWithTitle:@"Lunch" atIndex:index animated:FALSE];
        mealTwoTime = lunchTime;
    }
    
    if (hasBrunch) {
        /*lunchButton.hidden = FALSE;
         lunchButton.enabled = YES;
         lunchButton.userInteractionEnabled = YES;
         [lunchButton setImage:[UIImage imageNamed:@"Brunch.png"] forState:UIControlStateNormal];
         [self.view addSubview:lunchButton];
         
         lbl2.hidden = FALSE;
         lbl2.text = brunchTime;
         [self.view addSubview:lbl2];*/
        int index = (int) [mealSegments numberOfSegments];
        [mealSegments insertSegmentWithTitle:@"Brunch" atIndex:index animated:FALSE];
        mealTwoTime = brunchTime;
    }
    
    if (hasDinner) {
        /*dinnerButton.hidden = FALSE;
         dinnerButton.enabled = YES;
         dinnerButton.userInteractionEnabled = YES;
         [dinnerButton setImage:[UIImage imageNamed:@"Dinner"] forState:UIControlStateNormal];
         [self.view addSubview:dinnerButton];
         
         lbl3.hidden = FALSE;
         lbl3.text= dinnerTime;
         [self.view addSubview:lbl3];*/
        int index = (int) [mealSegments numberOfSegments];
        [mealSegments insertSegmentWithTitle:@"Dinner" atIndex:index animated:FALSE];
        mealThreeTime = dinnerTime;
    }
    
    if (isToday) [self mealAutoSelect]; //doesn't make sense to do autoselect for tomorrow's meals
    
    if (!isToday && ([mealSegments numberOfSegments] != 0)) {
        mealSegments.selectedSegmentIndex = 0; //just select the first segment, whichever it is
        [self changeMeal];
    }
}

- (void) changeMeal {
    //initializing to -1 so the lower if statements can still check against them but will not find a match if the meal doesn't exist
    int breakfastIndex = -1;
    int lunchIndex = -1;
    int brunchIndex = -1;
    int dinnerIndex = -1;
    
    for (int i=0; i < [mealSegments numberOfSegments]; i++) {
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Breakfast"]) breakfastIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Lunch"]) lunchIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Brunch"]) brunchIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Dinner"]) dinnerIndex = i;
    }
    
    if (mealSegments.selectedSegmentIndex == breakfastIndex) [self breakfast];
    if (mealSegments.selectedSegmentIndex == lunchIndex) [self lunch];
    if (mealSegments.selectedSegmentIndex == brunchIndex) [self lunch];
    if (mealSegments.selectedSegmentIndex == dinnerIndex) [self dinner];
}


- (void) mealAutoSelect {
    NSCalendar* curCalendar = [NSCalendar currentCalendar];
    [curCalendar setTimeZone: [NSTimeZone timeZoneWithName:@"America/New_York"]]; //system timezone may be different from CT
    const unsigned units    = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* comps = [curCalendar components:units fromDate:NSDate.date];
    long hour = [comps hour];
    long min  = [comps minute];
    long sec  = [comps second];
    
    int secs = (int) (((hour * 60) + min) * 60 + sec); //gives the number of seconds since midnight right now in CT
    
    static int breakfastEnd = 39600; //there are 39600 seconds between midnight and 11am
    static int lunchEnd = 50400; //there are 50400 seconds between midnight and 2pm
    
    //need to initialize these ints to silence warnings
    int breakfastIndex = -1;
    int lunchIndex = -1;
    int brunchIndex = -1;
    int dinnerIndex = -1;
    
    for (int i=0; i < [mealSegments numberOfSegments]; i++) {
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Breakfast"]) breakfastIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Lunch"]) lunchIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Brunch"]) brunchIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Dinner"]) dinnerIndex = i;
    }
    
    if (secs >= 0 && secs < breakfastEnd) { //it's breakfast time
        if (hasBreakfast) mealSegments.selectedSegmentIndex = breakfastIndex;
        else if (hasLunch) mealSegments.selectedSegmentIndex = lunchIndex;
        else if (hasBrunch) mealSegments.selectedSegmentIndex = brunchIndex;
        else mealSegments.selectedSegmentIndex = dinnerIndex;
    }
    
    if (secs >= breakfastEnd && secs < lunchEnd) { //it's lunchtime or brunchtime
        if (hasLunch) mealSegments.selectedSegmentIndex = lunchIndex;
        else if (hasBrunch) mealSegments.selectedSegmentIndex = brunchIndex;
        else if (hasDinner) mealSegments.selectedSegmentIndex = dinnerIndex;
        else mealSegments.selectedSegmentIndex = breakfastIndex;
    }
    
    if (secs >= lunchEnd) { //it's dinnertime
        if (hasDinner) mealSegments.selectedSegmentIndex = dinnerIndex;
        else if (hasBrunch) mealSegments.selectedSegmentIndex = brunchIndex;
        else if (hasLunch) mealSegments.selectedSegmentIndex = lunchIndex;
        else mealSegments.selectedSegmentIndex = breakfastIndex;
    }
    
    //above methods will select the right segment on the picker, but now need to actually show that meal's menu
    
    if (mealSegments.selectedSegmentIndex == breakfastIndex) [self breakfast];
    if (mealSegments.selectedSegmentIndex == lunchIndex) [self lunch];
    if (mealSegments.selectedSegmentIndex == brunchIndex) [self lunch];
    if (mealSegments.selectedSegmentIndex == dinnerIndex) [self dinner];
}

//got rid of these methods (makeToday, makeTomorrow, and swapDays) when we replaced the button with the segmented control
//after confirming the segmented control works with real data (can't confirm with v1.0 since no data), delete these methods for v1.1

/*- (void) makeToday {
 
 [FIRAnalytics logEventWithName:@"Make_Today" parameters:@{@"Dining_Hall":diningHall}];
 
 isToday = TRUE;
 
 [daySelector setTitle: @"Tap to show tomorrow's meals" forState: UIControlStateNormal];
 [daySelector setTitle: @"Tap to show tomorrow's meals" forState: UIControlStateApplication];
 [daySelector setTitle: @"Tap to show tomorrow's meals" forState: UIControlStateHighlighted];
 [daySelector setTitle: @"Tap to show tomorrow's meals" forState: UIControlStateReserved];
 [daySelector setTitle: @"Tap to show tomorrow's meals" forState: UIControlStateSelected];
 [daySelector setTitle: @"Tap to show tomorrow's meals" forState: UIControlStateDisabled];
 
 
 }
 
 - (void) makeTomorrow {
 
 [FIRAnalytics logEventWithName:@"Make_Tomorrow" parameters:@{@"Dining_Hall":diningHall}];
 
 [daySelector setTitle: @"Tap to show today's meals" forState: UIControlStateNormal];
 [daySelector setTitle: @"Tap to show today's meals" forState: UIControlStateApplication];
 [daySelector setTitle: @"Tap to show today's meals" forState: UIControlStateHighlighted];
 [daySelector setTitle: @"Tap to show today's meals" forState: UIControlStateReserved];
 [daySelector setTitle: @"Tap to show today's meals" forState: UIControlStateSelected];
 [daySelector setTitle: @"Tap to show today's meals" forState: UIControlStateDisabled];
 
 isToday = FALSE;
 
 }*/

- (void) changeDay {
    if (isToday) {
        [FIRAnalytics logEventWithName:@"Make_Tomorrow" parameters:@{@"Dining_Hall":diningHall}];
        
        isToday = FALSE;
        [self getMealTimes];
        [self makeMealSegments];
    } else {
        [FIRAnalytics logEventWithName:@"Make_Today" parameters:@{@"Dining_Hall":diningHall}];
        
        isToday = TRUE;
        [self getMealTimes];
        [self makeMealSegments];
    }
}

/*- (IBAction)swapDays:(id)sender {
 
 [FIRAnalytics logEventWithName:@"Swap_Days" parameters:@{@"Dining_Hall":diningHall}];
 
 
 if (isToday) {
 
 [self makeTomorrow];
 [self getMealTimes];
 [self makeMealButtons];
 
 }
 
 else {
 
 [self makeToday];
 [self getMealTimes];
 [self makeMealButtons];
 
 }
 
 }*/

- (void)hideButton {
    white.hidden = FALSE;
}

- (IBAction)bKGo:(id)sender {
    diningHall = @"BK";
    [FIRAnalytics logEventWithName:@"TapBK" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)bRGo:(id)sender {
    diningHall = @"BR";
    actualDiningHall = @"BR"; //to avoid confusion with Saybrook
    [FIRAnalytics logEventWithName:@"TapBR" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)cCGo:(id)sender {
    diningHall = @"CC";
    [FIRAnalytics logEventWithName:@"TapCC" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)dCGo:(id)sender {
    diningHall = @"DC";
    [FIRAnalytics logEventWithName:@"TapDC" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)bFGo:(id)sender {
    diningHall = @"BF";
    [FIRAnalytics logEventWithName:@"TapBF" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)mCGo:(id)sender {
    diningHall = @"MC";
    actualDiningHall = @"MC"; //to avoid confusion with Stiles
    [FIRAnalytics logEventWithName:@"TapMC" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)jEGo:(id)sender {
    diningHall = @"JE";
    [FIRAnalytics logEventWithName:@"TapJE" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)pMGo:(id)sender {
    diningHall = @"PM";
    [FIRAnalytics logEventWithName:@"TapPM" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)pCGo:(id)sender {
    diningHall = @"PC";
    [FIRAnalytics logEventWithName:@"TapPC" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)sYGo:(id)sender {
    diningHall = @"BR"; //Saybrook meals are reported under Branford
    actualDiningHall = @"SY"; //for menu display purposes
    [FIRAnalytics logEventWithName:@"TapSY" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)sMGo:(id)sender {
    diningHall = @"SM";
    [FIRAnalytics logEventWithName:@"TapSM" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)eSGo:(id)sender {
    diningHall = @"MC"; //Stiles meals are reported under Morse
    actualDiningHall = @"ES"; //for menu display purposes
    [FIRAnalytics logEventWithName:@"TapES" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)tDGo:(id)sender {
    diningHall = @"TD";
    [FIRAnalytics logEventWithName:@"TapTD" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}

- (IBAction)tCGo:(id)sender {
    diningHall = @"TC";
    [FIRAnalytics logEventWithName:@"TapTC" parameters:@{}];
    
    [self getMealTimes];
    [self menuScreenSetup];
}



/* THIS WAS TO LET USERS GO BACK TO THE MEAL SELECTOR SCREEN, BUT WE'VE REMOVED THAT SCREEN
 - (IBAction)backToMeals:(id)sender {
 
 [FIRAnalytics logEventWithName:@"Back_To_Meals" parameters:@{@"Dining_Hall":diningHall}];
 
 backToMealsButton.hidden = TRUE;
 white.hidden = FALSE;
 menuDiningHall.hidden = TRUE;
 menuDiningHall.enabled = NO;
 menuDiningHall.userInteractionEnabled = NO;
 menuMeal.hidden = TRUE;
 tableView.hidden = TRUE;
 menuDate.hidden = TRUE;
 [self makeMealButtons];
 
 }*/

- (IBAction)backToHome:(id)sender {
    //if the user just opens the app and then homes out, dining hall won't have a value and this will crash it
    if (diningHall != nil) [FIRAnalytics logEventWithName:@"Back_To_Home" parameters:@{@"Dining_Hall":diningHall}];
    
    backToHomeButton.hidden = TRUE;
    
    /*breakfastButton.hidden = TRUE;
     breakfastButton.enabled = NO;
     breakfastButton.userInteractionEnabled = NO;
     lunchButton.hidden = TRUE;
     lunchButton.enabled = NO;
     lunchButton.userInteractionEnabled = NO;
     dinnerButton.hidden = TRUE;
     dinnerButton.enabled = NO;
     dinnerButton.userInteractionEnabled = NO;
     lbl1.hidden = TRUE;
     lbl2.hidden = TRUE;
     lbl3.hidden = TRUE;*/
    
    white.hidden = TRUE;
    daySegments.hidden = TRUE;
    mealSegments.hidden = TRUE;
    
    if ([daySegments numberOfSegments] == 1) {
        [daySegments removeAllSegments];
        [daySegments setFrame:CGRectMake(daySegments.frame.origin.x, daySegments.frame.origin.y, (daySegments.frame.size.width)*2,daySegments.frame.size.height)];
        [daySegments insertSegmentWithTitle:@"Today's Meals" atIndex:0 animated:FALSE];
        [daySegments insertSegmentWithTitle:@"Tomorrow's Meals" atIndex:1 animated:FALSE];
    }
    
    if ([daySegments numberOfSegments] == 0) {
        [daySegments insertSegmentWithTitle:@"Today's Meals" atIndex:0 animated:FALSE];
        [daySegments insertSegmentWithTitle:@"Tomorrow's Meals" atIndex:1 animated:FALSE];
    }
    
    noMeals.hidden = TRUE;
    partialNoMeals.hidden = TRUE;
    sample.hidden = TRUE;
    sample.enabled = NO;
    sample.userInteractionEnabled = NO;
    
    bKButton.hidden = FALSE;
    bRButton.hidden = FALSE;
    cCButton.hidden = FALSE;
    dCButton.hidden = FALSE;
    bFButton.hidden = FALSE;
    mCButton.hidden = FALSE;
    jEButton.hidden = FALSE;
    pMButton.hidden = FALSE;
    pCButton.hidden = FALSE;
    sYButton.hidden = FALSE;
    sMButton.hidden = FALSE;
    eSButton.hidden = FALSE;
    tDButton.hidden = FALSE;
    tCButton.hidden = FALSE;
    
    infoButton.hidden = FALSE;
    reloadButton.hidden = FALSE;
    
    title1.hidden = FALSE;
    title2.hidden = FALSE;
    
    menuDiningHall.hidden = TRUE;
    tableView.hidden = TRUE;
    menuDate.hidden = TRUE;
    
    allergiesButton.hidden = TRUE;
    
    [self downloadCrowds];
    daySegments.selectedSegmentIndex = 0;
    isToday = TRUE;
    //[self makeToday];
}

- (void) returnToApp {
    [FIRAnalytics logEventWithName:@"Reopen_App_From_Background" parameters:@{}];
    
    [self check];
    showAllergies = FALSE;
    [self switchAllergies];
    [self backToHome:nil];
}

- (void)downloadCrowds {
    [FIRAnalytics logEventWithName:@"Download_Crowds" parameters:@{}];
    
    NSString *url = @"http://yaledining.org/fasttrack/locations.cfm?version=3";
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    NSString *html2 = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    if (err) {
        [FIRAnalytics logEventWithName:@"Network_Error" parameters:@{}];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Unable to download data"
                                     message:@"Please check your network connection and try again."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];

        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSNumberFormatter *formatCrowdNumbers = [[NSNumberFormatter alloc] init];
        
        NSArray* bKCrowding = [html2 componentsSeparatedByString: @"Berkeley\",\"Residential"];
        NSString* bKCrowd = [bKCrowding objectAtIndex:1];
        NSArray* bKTwo = [bKCrowd componentsSeparatedByString:@","];
        NSString* bKNumber = [bKTwo objectAtIndex:1];
        NSNumber *analyticsCrowd = [formatCrowdNumbers numberFromString:bKNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"BK", @"Crowdedness":analyticsCrowd}];
        if ([[bKTwo objectAtIndex:4] isEqualToString:@"1"]) bKNumber = @"0"; //if dining hall is closed, set crowd to 0
        
        NSArray* bRCrowding = [html2 componentsSeparatedByString: @"Branford\",\"Residential"];
        NSString* bRCrowd = [bRCrowding objectAtIndex:1];
        NSArray* bRTwo = [bRCrowd componentsSeparatedByString:@","];
        NSString* bRNumber = [bRTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:bRNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"BR", @"Crowdedness":analyticsCrowd}];
        if ([[bRTwo objectAtIndex:4] isEqualToString:@"1"]) bRNumber = @"0";
        
        NSArray* cCCrowding = [html2 componentsSeparatedByString: @"Hopper\",\"Residential"];
        NSString* cCCrowd = [cCCrowding objectAtIndex:1];
        NSArray* cCTwo = [cCCrowd componentsSeparatedByString:@","];
        NSString* cCNumber = [cCTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:cCNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"CC", @"Crowdedness":analyticsCrowd}];
        if ([[cCTwo objectAtIndex:4] isEqualToString:@"1"]) cCNumber = @"0";
        
        NSArray* dCCrowding = [html2 componentsSeparatedByString: @"Davenport\",\"Residential"];
        NSString* dCCrowd = [dCCrowding objectAtIndex:1];
        NSArray* dCTwo = [dCCrowd componentsSeparatedByString:@","];
        NSString* dCNumber = [dCTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:dCNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"DC", @"Crowdedness":analyticsCrowd}];
        if ([[dCTwo objectAtIndex:4] isEqualToString:@"1"]) dCNumber = @"0";
        
        NSArray* mCCrowding = [html2 componentsSeparatedByString: @"Morse\",\"Residential"];
        NSString* mCCrowd = [mCCrowding objectAtIndex:1];
        NSArray* mCTwo = [mCCrowd componentsSeparatedByString:@","];
        NSString* mCNumber = [mCTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:mCNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"MC", @"Crowdedness":analyticsCrowd}];
        if ([[mCTwo objectAtIndex:4] isEqualToString:@"1"]) mCNumber = @"0";
        
        NSArray* jECrowding = [html2 componentsSeparatedByString: @"Jonathan Edwards\",\"Residential"];
        NSString* jECrowd = [jECrowding objectAtIndex:1];
        NSArray* jETwo = [jECrowd componentsSeparatedByString:@","];
        NSString* jENumber = [jETwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:jENumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"JE", @"Crowdedness":analyticsCrowd}];
        if ([[jETwo objectAtIndex:4] isEqualToString:@"1"]) jENumber = @"0";
        
        NSArray* pCCrowding = [html2 componentsSeparatedByString: @"Pierson\",\"Residential"];
        NSString* pCCrowd = [pCCrowding objectAtIndex:1];
        NSArray* pCTwo = [pCCrowd componentsSeparatedByString:@","];
        NSString* pCNumber = [pCTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:pCNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"PC", @"Crowdedness":analyticsCrowd}];
        if ([[pCTwo objectAtIndex:4] isEqualToString:@"1"]) pCNumber = @"0";
        
        NSArray* sMCrowding = [html2 componentsSeparatedByString: @"Silliman\",\"Residential"];
        NSString* sMCrowd = [sMCrowding objectAtIndex:1];
        NSArray* sMTwo = [sMCrowd componentsSeparatedByString:@","];
        NSString* sMNumber = [sMTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:sMNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"SM", @"Crowdedness":analyticsCrowd}];
        if ([[sMTwo objectAtIndex:4] isEqualToString:@"1"]) sMNumber = @"0";
        
        NSArray* tDCrowding = [html2 componentsSeparatedByString: @"Timothy Dwight\",\"Residential"];
        NSString* tDCrowd = [tDCrowding objectAtIndex:1];
        NSArray* tDTwo = [tDCrowd componentsSeparatedByString:@","];
        NSString* tDNumber = [tDTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:tDNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"TD", @"Crowdedness":analyticsCrowd}];
        if ([[tDTwo objectAtIndex:4] isEqualToString:@"1"]) tDNumber = @"0";
        
        NSArray* sYCrowding = [html2 componentsSeparatedByString: @"Saybrook\",\"Residential"];
        NSString* sYCrowd = [sYCrowding objectAtIndex:1];
        NSArray* sYTwo = [sYCrowd componentsSeparatedByString:@","];
        NSString* sYNumber = [sYTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:sYNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"SY", @"Crowdedness":analyticsCrowd}];
        if ([[sYTwo objectAtIndex:4] isEqualToString:@"1"]) sYNumber = @"0";
        
        NSArray* eSCrowding = [html2 componentsSeparatedByString: @"Stiles\",\"Residential"];
        NSString* eSCrowd = [eSCrowding objectAtIndex:1];
        NSArray* eSTwo = [eSCrowd componentsSeparatedByString:@","];
        NSString* eSNumber = [eSTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:eSNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"ES", @"Crowdedness":analyticsCrowd}];
        if ([[eSTwo objectAtIndex:4] isEqualToString:@"1"]) eSNumber = @"0";
        
        NSArray* tCCrowding = [html2 componentsSeparatedByString: @"Trumbull\",\"Residential"];
        NSString* tCCrowd = [tCCrowding objectAtIndex:1];
        NSArray* tCTwo = [tCCrowd componentsSeparatedByString:@","];
        NSString* tCNumber = [tCTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:tCNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"TC", @"Crowdedness":analyticsCrowd}];
        if ([[tCTwo objectAtIndex:4] isEqualToString:@"1"]) tCNumber = @"0";
        
        NSArray* bFCrowding = [html2 componentsSeparatedByString: @"Franklin\",\"Residential"];
        NSString* bFCrowd = [bFCrowding objectAtIndex:1];
        NSArray* bFTwo = [bFCrowd componentsSeparatedByString:@","];
        NSString* bFNumber = [bFTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:bFNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"BF", @"Crowdedness":analyticsCrowd}];
        if ([[bFTwo objectAtIndex:4] isEqualToString:@"1"]) bFNumber = @"0";
        
        NSArray* pMCrowding = [html2 componentsSeparatedByString: @"Murray\",\"Residential"];
        NSString* pMCrowd = [pMCrowding objectAtIndex:1];
        NSArray* pMTwo = [pMCrowd componentsSeparatedByString:@","];
        NSString* pMNumber = [pMTwo objectAtIndex:1];
        analyticsCrowd = [formatCrowdNumbers numberFromString:pMNumber];
        [FIRAnalytics logEventWithName:@"Crowding" parameters:@{@"Dining_Hall":@"PM", @"Crowdedness":analyticsCrowd}];
        if ([[pMTwo objectAtIndex:4] isEqualToString:@"1"]) pMNumber = @"0";
        
        if (showSample) {
            //Test code simulates crowding
            bKNumber = @"8";
            bRNumber = @"3";
            cCNumber = @"7";
            dCNumber = @"1";
            mCNumber = @"9";
            jENumber = @"6";
            pCNumber = @"2";
            sMNumber = @"10";
            tDNumber = @"5";
            sYNumber = @"3";
            tCNumber = @"7";
            eSNumber = @"9";
            bFNumber = @"5";
            pMNumber = @"3";
        }
        
        NSString* bKImageString = [NSString stringWithFormat:@"%@.png",bKNumber];
        NSString* bRImageString = [NSString stringWithFormat:@"%@.png",bRNumber];
        NSString* cCImageString = [NSString stringWithFormat:@"%@.png",cCNumber];
        NSString* dCImageString = [NSString stringWithFormat:@"%@.png",dCNumber];
        NSString* mCImageString = [NSString stringWithFormat:@"%@.png",mCNumber];
        NSString* jEImageString = [NSString stringWithFormat:@"%@.png",jENumber];
        NSString* pCImageString = [NSString stringWithFormat:@"%@.png",pCNumber];
        NSString* sMImageString = [NSString stringWithFormat:@"%@.png",sMNumber];
        NSString* tDImageString = [NSString stringWithFormat:@"%@.png",tDNumber];
        NSString* tCImageString = [NSString stringWithFormat:@"%@.png",tCNumber];
        NSString* sYImageString = [NSString stringWithFormat:@"%@.png",sYNumber];
        NSString* eSImageString = [NSString stringWithFormat:@"%@.png",eSNumber];
        NSString* bFImageString = [NSString stringWithFormat:@"%@.png",bFNumber];
        NSString* pMImageString = [NSString stringWithFormat:@"%@.png",pMNumber];
        
        bKCrowds.image = [UIImage imageNamed: bKImageString];
        bRCrowds.image = [UIImage imageNamed: bRImageString];
        cCCrowds.image = [UIImage imageNamed: cCImageString];
        dCCrowds.image = [UIImage imageNamed: dCImageString];
        bFCrowds.image = [UIImage imageNamed: bFImageString];
        mCCrowds.image = [UIImage imageNamed: mCImageString];
        jECrowds.image = [UIImage imageNamed: jEImageString];
        pMCrowds.image = [UIImage imageNamed: pMImageString];
        pCCrowds.image = [UIImage imageNamed: pCImageString];
        sYCrowds.image = [UIImage imageNamed: sYImageString];
        sMCrowds.image = [UIImage imageNamed: sMImageString];
        eSCrowds.image = [UIImage imageNamed: eSImageString];
        tDCrowds.image = [UIImage imageNamed: tDImageString];
        tCCrowds.image = [UIImage imageNamed: tCImageString];
    }
}

- (NSString*) processMeal : (NSString*) meal withDate : (NSString*) today {
    NSArray* mealTimes = [html componentsSeparatedByString:meal];
    
    NSString *veryFirstItem = [NSString stringWithFormat:@"%@",mealTimes[1]];
    NSArray *firstArray = [veryFirstItem componentsSeparatedByString:@"\""];
    NSString *veryFirstDate = firstArray[2];
    NSString *veryLastItem = [NSString stringWithFormat:@"%@",mealTimes.lastObject];
    NSArray *lastArray = [veryLastItem componentsSeparatedByString:@"\""];
    NSString *veryLastDate = lastArray[2];
    
    NSString *time = @"";
    
    if ([veryFirstDate isEqualToString:today] && ![veryFirstDate isEqualToString:veryLastDate]) {
        mealToday = TRUE;
        mealTomorrow = TRUE;
        datesInverted = FALSE;
    }
    
    if (![veryFirstDate isEqualToString:today] && [veryLastDate isEqualToString:today]) {
        [FIRAnalytics logEventWithName:@"Inverted_Dates" parameters:@{@"Dining_Hall":diningHall}];
        
        mealToday = TRUE;
        mealTomorrow = TRUE;
        datesInverted = TRUE;
    }
    
    if ([veryFirstDate isEqualToString:today] && [veryLastDate isEqualToString:today]) {
        mealToday = TRUE;
        mealTomorrow = FALSE;
        datesInverted = FALSE;
    }
    
    if (![veryFirstDate isEqualToString:today] && ![veryLastDate isEqualToString:today]) {
        mealToday = FALSE;
        mealTomorrow = TRUE;
        datesInverted = FALSE;
    }
    
    
    if (mealToday + mealTomorrow == 2) { //these are booleans so they sum to 2 when both are true
        time = [self processTwoMeals:mealTimes];
    }
    
    if (mealToday + mealTomorrow == 1) {
        time = [self processOneMeal:mealTimes];
    }
    
    return time;
    //No need for zero because this method won't be called unless a meal string is found in the html
}

- (NSString*) processOneMeal : (NSArray*) mealTimes {
    [FIRAnalytics logEventWithName:@"Process_One_Meal" parameters:@{@"Dining_Hall":diningHall}];
    
    NSString *firstMenuItemString;
    firstMenuItemString = mealTimes[1];
    
    NSArray *firstMenuItemArray = [firstMenuItemString componentsSeparatedByString:@"\""];
    
    NSString *opening = firstMenuItemArray[8];
    NSString *closing = firstMenuItemArray[10];
    
    NSString *opening1 = [opening substringToIndex:[opening length]-3];
    NSString *closing1 = [closing substringToIndex:[closing length]-3];
    
    //Remove leading zeroes from times
    if ([[opening1 substringToIndex:1] isEqualToString:@"0"]) opening1 = [opening1 substringFromIndex:1];
    if ([[closing1 substringToIndex:1] isEqualToString:@"0"]) closing1 = [closing1 substringFromIndex:1];
    
    NSString *timePart1 = [opening1 stringByAppendingString:@" – "];
    NSString *time = [timePart1 stringByAppendingString:closing1];
    
    //This statement runs when you want today's times but there is only a meal tomorrow
    //Or when you want tomorrow's times but there is only a meal today
    //This if statement may not be necessary if the methods receiving the time won't
    //act on it when there is no meal — it might be possible to just leave the wrong time
    
    if (mealToday != isToday) {
        time = @"";
    }
    
    return time;
}

- (NSString*) processTwoMeals : (NSArray*) mealTimes {
    [FIRAnalytics logEventWithName:@"Process_Two_Meals" parameters:@{@"Dining_Hall":diningHall}];
    
    NSString *time;
    NSString *firstMenuItemString;
    
    firstMenuItemString = isToday ? mealTimes[1] : mealTimes.lastObject;
    
    NSArray *firstMenuItemArray = [firstMenuItemString componentsSeparatedByString:@"\""];
    
    NSString *opening = firstMenuItemArray[8];
    NSString *closing = firstMenuItemArray[10];
    
    NSString *opening1 = [opening substringToIndex:[opening length]-3];
    NSString *closing1 = [closing substringToIndex:[closing length]-3];
    
    // Remove leading zeroes from times
    if ([[opening1 substringToIndex:1] isEqualToString:@"0"]) opening1 = [opening1 substringFromIndex:1];
    if ([[closing1 substringToIndex:1] isEqualToString:@"0"]) closing1 = [closing1 substringFromIndex:1];
    
    NSString *timePart1 = [opening1 stringByAppendingString:@" – "];
    time = [timePart1 stringByAppendingString:closing1];
    
    int numEntries = (int) [mealTimes count];
    int n = 1;
    while (n < numEntries) {
        
        NSString *nthString = [NSString stringWithFormat:@"%@",mealTimes[n]];
        NSArray *nthArray = [nthString componentsSeparatedByString:@"\""];
        NSString *nthDate = nthArray[2];
        
        NSString *nplusonethString = [NSString stringWithFormat:@"%@",mealTimes[n+1]];
        NSArray *nplusonethArray = [nplusonethString componentsSeparatedByString:@"\""];
        NSString *nplusonethDate = nplusonethArray[2];
        
        if ([nplusonethDate isEqualToString:nthDate]) {
            n++;
        } else {
            switchpoint = n;
            break;
        }
    }
    return time;
}

- (void)getMealTimes {
    [FIRAnalytics logEventWithName:@"Get_Meal_Times" parameters:@{@"Dining_Hall":diningHall}];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"America/New_York"]; //system timezone may be different from CT
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:timeZone];
    formatter.dateFormat = @"MMMM, d yyyy";
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSString *today = [date stringByAppendingString:@" 00:00:00"]; //use for comparison against downloaded date
    
    hasBreakfast = FALSE;
    hasBrunch = FALSE;
    hasLunch = FALSE;
    hasDinner = FALSE;
    
    continentalBreakfastToday = FALSE;
    hotBreakfastToday = FALSE;
    lunchToday = FALSE;
    brunchToday = FALSE;
    dinnerToday = FALSE;
    continentalBreakfastTomorrow = FALSE;
    hotBreakfastTomorrow = FALSE;
    lunchTomorrow = FALSE;
    brunchTomorrow = FALSE;
    dinnerTomorrow = FALSE;
    
    NSArray *diningHalls = @[@"nil",@"BK",@"BR",@"CC",@"DC",@"MC",@"JE",@"PC",@"SM",@"TD",@"TC",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"nil",@"BF",@"PM"];
    
    int i = 1;
    // diningHall is a global variable that was set when a homepage button was tapped
    while(diningHall != diningHalls[i]) {
        i++;
    }
    if (diningHall == diningHalls[i]) {
        locationCode = i;
    }
    
    NSString* locationCodeString = [NSString stringWithFormat:@"%i", locationCode];
    
    NSString *base = @"http://yaledining.org/fasttrack/menus.cfm?version=3&Location=";
    NSString *url = [base stringByAppendingString:locationCodeString];
    
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    html = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    if (showSample) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Dining Data" ofType:@"txt"];
        html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    if (err) {
        [FIRAnalytics logEventWithName:@"Network_Error" parameters:@{}];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Unable to download data"
                                     message:@"Please check your network connection and try again."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    /*COURSES TEST CODE
     
     int n = 1;
     
     while (n < 37) {
     
     NSArray* mealTimes = [html componentsSeparatedByString:@"[5"];
     
     NSString *veryFirstItem = [NSString stringWithFormat:@"%@",mealTimes[n]];
     NSArray *firstArray = [veryFirstItem componentsSeparatedByString:@"\""];
     NSLog(@"An example of %@ is %@", firstArray[7], firstArray[9]);
     
     n++;
     }
     
     */
    
    if ([html containsString:@"Contl. Bkfst."]) {
        [FIRAnalytics logEventWithName:@"Continental_Breakfast_Found_In_Mealfile" parameters:@{@"Dining_Hall":diningHall}];
        
        continentalTime = [self processMeal : @"Contl. Bkfst." withDate :  today];
        
        continentalBreakfastToday = mealToday;
        continentalBreakfastTomorrow = mealTomorrow;
        
        if ((isToday && mealToday) || ((!isToday) && mealTomorrow)) hasBreakfast = TRUE;
        if (mealToday) hotToday = FALSE;
        if (mealTomorrow) hotTomorrow = FALSE;
        
        if ((isToday && (!mealToday)) || ((!isToday) && (!mealTomorrow))) hasBreakfast = FALSE;
        if (mealToday + mealTomorrow == 2) continentalSwitchpoint = switchpoint;
    }
    
    
    if ([html containsString:@"Hot Breakfast"]) {
        [FIRAnalytics logEventWithName:@"Hot_Breakfast_Found_In_Mealfile" parameters:@{@"Dining_Hall":diningHall}];
        
        hotTime = [self processMeal : @"Hot Breakfast" withDate :  today];
        
        hotBreakfastToday = mealToday;
        hotBreakfastTomorrow = mealTomorrow;
        
        if ((isToday && mealToday) || ((!isToday) && mealTomorrow)) hasBreakfast = TRUE;
        if (mealToday) hotToday = TRUE;
        if (mealTomorrow) hotTomorrow = TRUE;
        
        if ((isToday && (!mealToday && !continentalBreakfastToday)) || ((!isToday) && (!mealTomorrow && !continentalBreakfastTomorrow))) hasBreakfast = FALSE;
        if (mealToday + mealTomorrow == 2) hotSwitchpoint = switchpoint;
    }
    
    if ([html containsString:@"Lunch"]) {
        [FIRAnalytics logEventWithName:@"Lunch_Found_In_Mealfile" parameters:@{@"Dining_Hall":diningHall}];
        
        lunchTime = [self processMeal : @"Lunch" withDate :  today];
        
        lunchToday = mealToday;
        lunchTomorrow = mealTomorrow;
        
        if ((isToday && mealToday) || ((!isToday) && mealTomorrow)) hasLunch = TRUE;
        if ((isToday && (!mealToday)) || ((!isToday) && (!mealTomorrow))) hasLunch = FALSE;
        if (mealToday + mealTomorrow == 2) lunchSwitchpoint = switchpoint;
    }
    
    if ([html containsString:@"Brunch"]) {
        [FIRAnalytics logEventWithName:@"Brunch_Found_In_Mealfile" parameters:@{@"Dining_Hall":diningHall}];
        
        brunchTime = [self processMeal : @"Brunch" withDate :  today];
        
        brunchToday = mealToday;
        brunchTomorrow = mealTomorrow;
        
        if ((isToday && mealToday) || ((!isToday) && mealTomorrow)) hasBrunch = TRUE;
        if ((isToday && (!mealToday)) || ((!isToday) && (!mealTomorrow))) hasBrunch = FALSE;
        if (mealToday + mealTomorrow == 2) brunchSwitchpoint = switchpoint;
    }
    
    if ([html containsString:@"Dinner"]) {
        [FIRAnalytics logEventWithName:@"Dinner_Found_In_Mealfile" parameters:@{@"Dining_Hall":diningHall}];
        
        dinnerTime = [self processMeal : @"Dinner" withDate :  today];
        
        dinnerToday = mealToday;
        dinnerTomorrow = mealTomorrow;
        
        if ((isToday && mealToday) || ((!isToday) && mealTomorrow)) hasDinner = TRUE;
        if ((isToday && (!mealToday)) || ((!isToday) && (!mealTomorrow))) hasDinner = FALSE;
        if (mealToday + mealTomorrow == 2) dinnerSwitchpoint = switchpoint;
    }
    
    // Whether there are any meals at all on the day you're checking
    hasAnyMeals = hasBreakfast || hasLunch || hasBrunch || hasDinner;
}

- (void) mealProcessor : (NSString*)meal withToday : (BOOL)mealTod andTomorrow : (BOOL)mealTom withSwitchpoint : (int)switchpointForMeal {
    NSNumber *analyticsDay; //use this for firebase tracking below
    if (isToday) analyticsDay = @0;
    if (!isToday) analyticsDay = @1;
    NSNumber *analyticsMeal;
    if ([meal isEqualToString:@"Contl. Bkfst."]) analyticsMeal = @0;
    if ([meal isEqualToString:@"Hot Breakfast"]) analyticsMeal = @1;
    if ([meal isEqualToString:@"Lunch"]) analyticsMeal = @2;
    if ([meal isEqualToString:@"Brunch"]) analyticsMeal = @3;
    if ([meal isEqualToString:@"Dinner"]) analyticsMeal = @4;
    [FIRAnalytics logEventWithName:@"Show_Menu" parameters:@{@"Dining_Hall":diningHall,@"Meal_0cbr_1hbr_2lu_3bru_4_din":analyticsMeal,@"Day_0today_1tomorrow":analyticsDay}];
    
    entreeList = nil;
    courseList = nil;
    menuIDList = nil;
    
    if (mealTod + mealTom == 1) {
        NSArray* mealObjects = [html componentsSeparatedByString:meal];
        int entrees = (int) mealObjects.count - 1;
        
        entreeList = [NSMutableArray array];
        courseList = [NSMutableArray array];
        menuIDList = [NSMutableArray array];
        
        for (int i = 0; i < entrees; i++) {
            
            NSString *mealText = mealObjects[i+1];
            NSArray *componentsOfText = [mealText componentsSeparatedByString:@"\""];
            [entreeList addObject:componentsOfText[6]];
            [courseList addObject:componentsOfText[4]];
            
            NSString *itemIDLargerString = componentsOfText[5];
            NSArray *itemIDComponents = [itemIDLargerString componentsSeparatedByString:@".0,"];
            
            [menuIDList addObject:itemIDComponents[1]];
            
            [FIRAnalytics logEventWithName:@"Menu_Item_Viewed" parameters:@{@"Dining_Hall":diningHall,@"Meal_0cbr_1hbr_2lu_3bru_4_din":analyticsMeal,@"Day_0today_1tomorrow":analyticsDay,@"Menu_Item":componentsOfText[6],@"Course":componentsOfText[4],@"ID":menuIDList[i]}];
        }
    }
    
    if (mealTod + mealTom == 2) {
        NSArray* mealObjects = [html componentsSeparatedByString:meal];
        int totalEntrees = (int) mealObjects.count - 1;
        
        entreeList = [NSMutableArray array];
        courseList = [NSMutableArray array];
        menuIDList = [NSMutableArray array];
        
        int start = ((isToday && !datesInverted) || (!isToday && datesInverted)) ? 0 : switchpointForMeal;
        int end = ((isToday && !datesInverted) || (!isToday && datesInverted)) ? switchpointForMeal : totalEntrees;
        
        for (int i = start; i < end; i++) {
            
            NSString *mealText = mealObjects[i+1];
            NSArray *componentsOfText = [mealText componentsSeparatedByString:@"\""];
            [entreeList addObject:componentsOfText[6]];
            [courseList addObject:componentsOfText[4]];
            
            NSString *itemIDLargerString = componentsOfText[5];
            NSArray *itemIDComponents = [itemIDLargerString componentsSeparatedByString:@".0,"];
            
            [menuIDList addObject:itemIDComponents[1]];
            
            [FIRAnalytics logEventWithName:@"Menu_Item_Viewed" parameters:@{@"Dining_Hall":diningHall,@"Meal":meal,@"Day":analyticsDay,@"Menu_Item":componentsOfText[6],@"Course":componentsOfText[4],@"ID":menuIDList[i-start]}];
        }
    }
    
    NSString *menuDateDay;
    
    if (isToday) menuDateDay = @"today";
    else menuDateDay = @"tomorrow";
    
    NSString *mealTitle;
    
    if ([meal isEqualToString:@"Contl. Bkfst."]) {
        mealTitle = @"Breakfast";
        mealTime = mealOneTime;
    }
    if ([meal isEqualToString:@"Hot Breakfast"]) {
        mealTitle = @"Hot Breakfast";
        mealTime = mealOneTime;
    }
    if ([meal isEqualToString:@"Brunch"]) {
        mealTitle = @"Brunch";
        mealTime = mealTwoTime;
    }
    if ([meal isEqualToString:@"Lunch"]) {
        mealTitle = @"Lunch";
        mealTime = mealTwoTime;
    }
    if ([meal isEqualToString:@"Dinner"]) {
        mealTitle = @"Dinner";
        mealTime = mealThreeTime;
    }
    
    NSString *menuDateString = [NSString stringWithFormat:@"%@ hours %@: %@",mealTitle,menuDateDay,mealTime];
    menuDate.text = menuDateString;
    menuDate.hidden = FALSE;
    [self.view addSubview:menuDate];
    
    [tableView reloadData];
    [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO]; //scroll back to the top of the menu
    tableView.hidden = FALSE;
}

- (void)breakfast {
    if ((isToday && hotToday) || ((!isToday) && hotTomorrow)) [self mealProcessor:@"Hot Breakfast" withToday:hotBreakfastToday andTomorrow:hotBreakfastTomorrow withSwitchpoint:hotSwitchpoint];
    if ((isToday && (!hotToday)) || ((!isToday) && (!hotTomorrow))) [self mealProcessor:@"Contl. Bkfst." withToday:continentalBreakfastToday andTomorrow:continentalBreakfastTomorrow withSwitchpoint:continentalSwitchpoint];
}

- (void)lunch {
    if ((isToday && lunchToday) || ((!isToday) && lunchTomorrow)) [self mealProcessor:@"Lunch" withToday:lunchToday andTomorrow:lunchTomorrow withSwitchpoint:lunchSwitchpoint];
    if ((isToday && brunchToday) || ((!isToday) && brunchTomorrow)) [self mealProcessor:@"Brunch" withToday:brunchToday andTomorrow:brunchTomorrow withSwitchpoint:brunchSwitchpoint];
}

- (void)dinner {
    [self mealProcessor:@"Dinner" withToday:dinnerToday andTomorrow:dinnerTomorrow withSwitchpoint:dinnerSwitchpoint];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [entreeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier]; //throws a warning because this hides the IBOutlet, but we don't want to be messing with that here anyway
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //don't want to keep residual grayouts from previous menus
    cell.textLabel.alpha = 1;
    cell.imageView.alpha = 1;
    
    NSString *itemName = [entreeList objectAtIndex:indexPath.row];
    cell.textLabel.text = itemName;
    NSString *course = [courseList objectAtIndex:indexPath.row];
    
    if ([course isEqualToString:@"Asian Station - Starch"]) course = @"Entrees";
    if ([itemName containsString:@"urger"]) course = @"Burgers";
    if ([itemName containsString:@"Perdu"]) course = @"Morning Sweets";
    if ([course isEqualToString:@"Whole Grain"]) course = @"Starches";
    if ([course isEqualToString:@"Sandwich"]) course = @"Morning Sweets";
    if ([course isEqualToString:@"Greens & Vegetables"]) course = @"The Vegetables";
    
    NSString *itemPath = [[NSBundle mainBundle] pathForResource:itemName ofType:@"png"];
    BOOL itemFileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemPath];
    itemPath = [[NSBundle mainBundle] pathForResource:course ofType:@"png"];
    BOOL courseFileExists = [[NSFileManager defaultManager] fileExistsAtPath:itemPath];
    
    if (itemFileExists) cell.imageView.image = [UIImage imageNamed:itemName];
    else if (courseFileExists) cell.imageView.image = [UIImage imageNamed:course];
    else cell.imageView.image = [UIImage imageNamed:@"Entrees.png"];
    
    CGSize itemSize = CGSizeMake(65, 65);
    UIGraphicsBeginImageContextWithOptions(itemSize, false, 0);
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //The line below stopped working when we started building against iOS 11, so we now use the six lines above
    //cell.imageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    NSString *grayImageString;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int currentPref = (int)[defaults integerForKey:[menuIDList objectAtIndex:indexPath.row]];
    if (currentPref == 0) grayImageString = @"";
    if (currentPref == 1) grayImageString = @"Thumbs Down.png";
    if (currentPref == 2) grayImageString = @"Thumbs Up.png";
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:grayImageString]];
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.backgroundColor = [UIColor colorWithRed:(indexPath.row % 2 == 0 ? 250 : 255)/256.0
                                           green:250/256.0
                                            blue:255/256.0
                                           alpha:1.0];
    
    cell.textLabel.font = [UIFont fontWithName:@"Optima" size:20.0];
    
    NSInteger peanutYesNo = [defaults integerForKey:@"Peanuts"];
    NSInteger vegetarianYesNo = [defaults integerForKey:@"Vegetarian"];
    NSInteger veganYesNo = [defaults integerForKey:@"Vegan"];
    NSInteger dairyYesNo = [defaults integerForKey:@"Dairy"];
    NSInteger glutenYesNo = [defaults integerForKey:@"Gluten"];
    NSInteger eggsYesNo = [defaults integerForKey:@"Eggs"];
    NSInteger soyYesNo = [defaults integerForKey:@"Soy"];
    NSInteger porkYesNo = [defaults integerForKey:@"Pork"];
    NSInteger nutsYesNo = [defaults integerForKey:@"Nuts"];
    NSInteger alcoholYesNo = [defaults integerForKey:@"Alcohol"];
    NSInteger shellfishYesNo = [defaults integerForKey:@"Shellfish"];
    NSInteger seafoodYesNo = [defaults integerForKey:@"Seafood"];
    
    // Checking for allergens makes scrolling choppy, so don't check if no allergens
    if (peanutYesNo == 1 || vegetarianYesNo == 1 || veganYesNo == 1 || dairyYesNo == 1 || glutenYesNo == 1 || eggsYesNo == 1 || soyYesNo == 1 || porkYesNo == 1 || nutsYesNo == 1 || alcoholYesNo == 1 || shellfishYesNo == 1 || seafoodYesNo == 1) {
        
        NSString *base = @"http://www.yaledining.org/fasttrack/menuitem-codes.cfm?version=3&MenuItemID=";
        NSString *menuID = [menuIDList objectAtIndex:indexPath.row];
        NSString *url = [base stringByAppendingString:menuID];
        
        NSURL *urlRequest = [NSURL URLWithString:url];
        NSError *err = nil;
        
        NSString *allergyHTML = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
        
        NSArray *allergens = [allergyHTML componentsSeparatedByString:@".0,"];
        
        NSString *firstEl = allergens[1];
        NSString *firstElTrimmed = [firstEl substringFromIndex:[firstEl length] - 1];
        
        if (([firstElTrimmed isEqualToString:@"1"] && alcoholYesNo == 1) ||
            ([allergens[2] isEqualToString:@"1"] && nutsYesNo == 1) ||
            ([allergens[3] isEqualToString:@"1"] && shellfishYesNo == 1) ||
            ([allergens[4] isEqualToString:@"1"] && peanutYesNo == 1) ||
            ([allergens[5] isEqualToString:@"1"] && dairyYesNo == 1) ||
            ([allergens[6] isEqualToString:@"1"] && eggsYesNo == 1) ||
            // if vegan trait NOT shown
            ([allergens[7] isEqualToString:@"0"] && veganYesNo == 1) ||
            ([allergens[8] isEqualToString:@"1"] && porkYesNo == 1) ||
            ([allergens[9] isEqualToString:@"1"] && seafoodYesNo == 1) ||
            ([allergens[10] isEqualToString:@"1"] && soyYesNo == 1) ||
            // Skip allergen section 11 (wheat), which is redundant with gluten
            ([allergens[12] isEqualToString:@"1"] && glutenYesNo == 1) ||
             // if vegetarian trait NOT shown
            ([allergens[13] isEqualToString:@"0"] && vegetarianYesNo == 1)) {
            // Gray out cell
            cell.textLabel.alpha = 0.3;
            cell.imageView.alpha = 0.3;
        }
        
        if (err) {
            [FIRAnalytics logEventWithName:@"Network_Error" parameters:@{}];
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Unable to download data"
                                         message:@"Please check your network connection and try again."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: this could be cleaner
    NSNumber *analyticsDay = isToday ? @0 : @1;
    
    [FIRAnalytics logEventWithName:@"Show_Ingredients" parameters:@{@"Dining_Hall":diningHall,@"Menu_Item":[entreeList objectAtIndex:indexPath.row],@"Day_0today_1tomorrow":analyticsDay}];
    
    NSString *base = @"http://www.yaledining.org/fasttrack/menuitem-ingredients.cfm?version=3&MenuItemID=";
    NSString *menuID = [menuIDList objectAtIndex:indexPath.row];
    NSString *url = [base stringByAppendingString:menuID];
    
    NSURL *urlRequest = [NSURL URLWithString:url];
    NSError *err = nil;
    
    NSString *ingredientsHTML = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
    
    NSArray *ingredientsArray = [ingredientsHTML componentsSeparatedByString:@"\""];
    
    NSString *ingredients = @"";
    
    for (int i = 4; i < ([ingredientsArray count])/2; i++) {
        ingredients = [ingredients stringByAppendingString:ingredientsArray[2*i+1]];
        ingredients = [ingredients stringByAppendingString:@", "];
    }
    
    if ([ingredients length] > 2) ingredients = [ingredients substringToIndex:[ingredients length] - 2]; //get rid of the last comma and space
    
    NSString *baseAl = @"http://www.yaledining.org/fasttrack/menuitem-codes.cfm?version=3&MenuItemID=";
    NSString *urlAl = [baseAl stringByAppendingString:menuID];
    
    NSURL *urlRequestAl = [NSURL URLWithString:urlAl];
    NSError *errAl = nil;
    
    NSString *allergyHTML = [NSString stringWithContentsOfURL:urlRequestAl encoding:NSUTF8StringEncoding error:&errAl];
    
    NSArray *allergensArray = [allergyHTML componentsSeparatedByString:@".0,"];
    
    NSString *firstEl = allergensArray[1];
    NSString *firstElTrimmed = [firstEl substringFromIndex:[firstEl length] - 1];
    
    NSString *allergens = @"\nAllergens: ";
    
    if ([allergensArray[4] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Peanuts, "];
    if ([allergensArray[13] isEqualToString: @"0"]) allergens = [allergens stringByAppendingString:@"Meat, "];
    if ([allergensArray[7] isEqualToString: @"0"]) allergens = [allergens stringByAppendingString:@"Animal Products, "];
    if ([allergensArray[5] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Dairy, "];
    if ([allergensArray[12] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Gluten, "];
    if ([allergensArray[6] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Eggs, "];
    if ([allergensArray[10] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Soy, "];
    if ([allergensArray[8] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Pork, "];
    if ([allergensArray[2] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Nuts, "];
    if ([firstElTrimmed isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Alcohol, "];
    if ([allergensArray[3] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Shellfish, "];
    if ([allergensArray[9] isEqualToString: @"1"]) allergens = [allergens stringByAppendingString:@"Seafood, "];
    
    if ([allergens length] > 14) {
        allergens = [allergens substringToIndex:[allergens length] - 2]; //get rid of the last comma and space
        allergens = [allergens stringByAppendingString:@"\n\n"];
    }
    
    else allergens = @"\n";
    
    NSString *popupString = [NSString stringWithFormat:@"%@Ingredients: %@\n\nDisclaimer: This information is provided for your convenience, but we cannot guarantee it is perfect. Do not rely on this information if incorrect information might cause you harm.",allergens,ingredients];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:[entreeList objectAtIndex:indexPath.row]
                                 message:popupString
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* back = [UIAlertAction
                           actionWithTitle:@"Back"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
                           {
                               [alert dismissViewControllerAnimated:YES completion:nil];
                           }];
    
    [alert addAction:back];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void) tutorialFromInfo {
    [FIRAnalytics logEventWithName:@"Tutorial_From_Info" parameters:@{}];
    
    [self startTutorial];
}

- (void) startTutorial {
    [FIRAnalytics logEventWithName:@"Start_Tutorial" parameters:@{}];
    
    introButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [introButton setFrame:[[UIScreen mainScreen] bounds]];
    [introButton setImage:[UIImage imageNamed:@"Intro.jpg"] forState:UIControlStateNormal];
    [introButton addTarget: self action:@selector(tutorialPageTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:introButton];
    
    skipTutorial.hidden = FALSE;
    [self.view addSubview:skipTutorial];
    [skipTutorial addTarget: self action:@selector(skipTutorial) forControlEvents:UIControlEventTouchUpInside];
}

- (void) skipTutorial {
    [FIRAnalytics logEventWithName:@"Skip_Tutorial" parameters:@{}];
    
    [introButton removeFromSuperview];
    [skipTutorial removeFromSuperview];
    
    [self downloadCrowds];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"Tutorial"];
    [defaults setInteger:1 forKey:@"2.2FeaturesTutorialShown"];
    [defaults synchronize];
}

- (void) newFeatures {
    [FIRAnalytics logEventWithName:@"New_Features_Tutorial" parameters:@{}];
    
    introButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [introButton setFrame:[[UIScreen mainScreen] bounds]];
    [introButton setImage:[UIImage imageNamed:@"New Features.jpg"] forState:UIControlStateNormal];
    [introButton addTarget: self action:@selector(newFeaturesTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:introButton];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"2.2FeaturesTutorialShown"];
    [defaults synchronize];
}

- (void) newFeaturesTwo {
    [FIRAnalytics logEventWithName:@"Tutorial_Swipe" parameters:@{}];
    
    [introButton removeFromSuperview];
    swipeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [swipeButton setFrame:[[UIScreen mainScreen] bounds]];
    [swipeButton setImage:[UIImage imageNamed:@"Swipe.jpg"] forState:UIControlStateNormal];
    [swipeButton addTarget: self action:@selector(tutorialPageSeven) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:swipeButton];
}

- (void) tutorialPageTwo {
    [FIRAnalytics logEventWithName:@"Tutorial_Pg2" parameters:@{}];
    
    [skipTutorial removeFromSuperview];
    [introButton removeFromSuperview];
    iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconButton setFrame:[[UIScreen mainScreen] bounds]];
    [iconButton setImage:[UIImage imageNamed:@"Icon.jpg"] forState:UIControlStateNormal];
    [iconButton addTarget: self action:@selector(tutorialPageThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconButton];
}

- (void) tutorialPageThree {
    [FIRAnalytics logEventWithName:@"Tutorial_Pg3" parameters:@{}];
    
    [iconButton removeFromSuperview];
    refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setFrame:[[UIScreen mainScreen] bounds]];
    [refreshButton setImage:[UIImage imageNamed:@"Refresh.jpg"] forState:UIControlStateNormal];
    [refreshButton addTarget: self action:@selector(tutorialPageFour) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshButton];
}

- (void) tutorialPageFour {
    [FIRAnalytics logEventWithName:@"Tutorial_Pg4" parameters:@{}];
    
    [refreshButton removeFromSuperview];
    mealsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mealsButton setFrame:[[UIScreen mainScreen] bounds]];
    [mealsButton setImage:[UIImage imageNamed:@"Meals.jpg"] forState:UIControlStateNormal];
    [mealsButton addTarget: self action:@selector(tutorialPageFive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mealsButton];
}

- (void) tutorialPageFive {
    [FIRAnalytics logEventWithName:@"Tutorial_Pg5" parameters:@{}];
    
    [mealsButton removeFromSuperview];
    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setFrame:[[UIScreen mainScreen] bounds]];
    [menuButton setImage:[UIImage imageNamed:@"Menu.jpg"] forState:UIControlStateNormal];
    [menuButton addTarget: self action:@selector(tutorialPageSix) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButton];
}

- (void) tutorialPageSix {
    [FIRAnalytics logEventWithName:@"Tutorial_Pg6" parameters:@{}];
    
    [menuButton removeFromSuperview];
    gearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [gearButton setFrame:[[UIScreen mainScreen] bounds]];
    [gearButton setImage:[UIImage imageNamed:@"Allergies.jpg"] forState:UIControlStateNormal];
    [gearButton addTarget: self action:@selector(swipeTutorial) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gearButton];
}

- (void) swipeTutorial {
    [FIRAnalytics logEventWithName:@"Tutorial_Swipe" parameters:@{}];
    
    [gearButton removeFromSuperview];
    swipeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [swipeButton setFrame:[[UIScreen mainScreen] bounds]];
    [swipeButton setImage:[UIImage imageNamed:@"Swipe.jpg"] forState:UIControlStateNormal];
    [swipeButton addTarget: self action:@selector(tutorialPageSeven) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:swipeButton];
}

- (void) tutorialPageSeven {
    [FIRAnalytics logEventWithName:@"Tutorial_Pg7" parameters:@{}];
    [swipeButton removeFromSuperview];
    closingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closingButton setFrame:[[UIScreen mainScreen] bounds]];
    [closingButton setImage:[UIImage imageNamed:@"Closing.jpg"] forState:UIControlStateNormal];
    [closingButton addTarget: self action:@selector(closeTutorial) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closingButton];
}

- (void) closeTutorial {
    [FIRAnalytics logEventWithName:@"Finish_Tutorial" parameters:@{}];
    
    [closingButton removeFromSuperview];
    
    [self downloadCrowds];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"Tutorial"];
    [defaults setInteger:1 forKey:@"2.2FeaturesTutorialShown"]; //don't need users to see the update if they see the whole thing
    [defaults synchronize];
}

- (void) animateSwipeIsLeft : (BOOL) left withRecognizer : (UISwipeGestureRecognizer *) gestureRecognizer {
    NSString *blueImageString;
    int frameSet;
    
    if (left) {
        blueImageString = @"Thumbs Down Blue.png";
        frameSet =  -350;
    } else {
        blueImageString = @"Thumbs Up Blue.png";
        frameSet = 350;
    }
    
    // Find the current meal to include in analytics
    // Initializing to -1 so the lower if statements can still check against them but will not find a match if the meal doesn't exist
    int breakfastIndex = -1;
    int lunchIndex = -1;
    int brunchIndex = -1;
    int dinnerIndex = -1;
    
    for (int i = 0; i < [mealSegments numberOfSegments]; i++) {
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Breakfast"]) breakfastIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Lunch"]) lunchIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Brunch"]) brunchIndex = i;
        if ([[mealSegments titleForSegmentAtIndex:i] isEqualToString:@"Dinner"]) dinnerIndex = i;
    }
    
    NSNumber *analyticsMeal;
    if (mealSegments.selectedSegmentIndex == breakfastIndex) analyticsMeal = @0;
    if (mealSegments.selectedSegmentIndex == lunchIndex) analyticsMeal = @1;
    if (mealSegments.selectedSegmentIndex == brunchIndex) analyticsMeal = @2;
    if (mealSegments.selectedSegmentIndex == dinnerIndex) analyticsMeal = @3;
    
    CGPoint location = [gestureRecognizer locationInView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"Showed Swipe Reminder"];
    int currentPref = (int)[defaults integerForKey:[menuIDList objectAtIndex:indexPath.row]];
    
    // 1 means dislike; 2 means like
    // If the user reexpresses the same preference, nothing happens wrt NSUserDefaults or analytics
    
    if (currentPref == 1 && left == FALSE) { //before you disliked it; now you like it
        [defaults setInteger:2 forKey:[menuIDList objectAtIndex:indexPath.row]];
        [FIRAnalytics logEventWithName:@"Swipe" parameters:@{@"Menu_Item":[entreeList objectAtIndex:indexPath.row], @"Item_ID":[menuIDList objectAtIndex:indexPath.row], @"Direction_1dislike_2like":@2, @"Rating_Type_0firsttime_1changed_2erased":@1, @"Dining_Hall":diningHall, @"Meal_0breakfast_1lunch_2brunch_3dinner":analyticsMeal}];
    }
    
    if (currentPref == 2 && left == TRUE) { //before you liked it; now you dislike it
        [defaults setInteger:1 forKey:[menuIDList objectAtIndex:indexPath.row]];
        [FIRAnalytics logEventWithName:@"Swipe" parameters:@{@"Menu_Item":[entreeList objectAtIndex:indexPath.row], @"Item_ID":[menuIDList objectAtIndex:indexPath.row], @"Direction_1dislike_2like":@1, @"Rating_Type_0firsttime_1changed_2erased":@1, @"Dining_Hall":diningHall, @"Meal_0breakfast_1lunch_2brunch_3dinner":analyticsMeal}];
    }
    
    if (currentPref == 0 && left == FALSE) { //new like
        [defaults setInteger:2 forKey:[menuIDList objectAtIndex:indexPath.row]];
        [FIRAnalytics logEventWithName:@"Swipe" parameters:@{@"Menu_Item":[entreeList objectAtIndex:indexPath.row], @"Item_ID":[menuIDList objectAtIndex:indexPath.row], @"Direction_1dislike_2like":@2, @"Rating_Type_0firsttime_1changed_2erased":@0, @"Dining_Hall":diningHall, @"Meal_0breakfast_1lunch_2brunch_3dinner":analyticsMeal}];
    }
    
    if (currentPref == 0 && left == TRUE) { //new dislike
        [defaults setInteger:1 forKey:[menuIDList objectAtIndex:indexPath.row]];
        [FIRAnalytics logEventWithName:@"Swipe" parameters:@{@"Menu_Item":[entreeList objectAtIndex:indexPath.row], @"Item_ID":[menuIDList objectAtIndex:indexPath.row], @"Direction_1dislike_2like":@1, @"Rating_Type_0firsttime_1changed_2erased":@0, @"Dining_Hall":diningHall, @"Meal_0breakfast_1lunch_2brunch_3dinner":analyticsMeal}];
    }
    
    if (currentPref == 1 && left == TRUE) { //erase your dislike
        [defaults setInteger:0 forKey:[menuIDList objectAtIndex:indexPath.row]];
        [FIRAnalytics logEventWithName:@"Swipe" parameters:@{@"Menu_Item":[entreeList objectAtIndex:indexPath.row], @"Item_ID":[menuIDList objectAtIndex:indexPath.row], @"Direction_1dislike_2like":@1, @"Rating_Type_0firsttime_1changed_2erased":@2, @"Dining_Hall":diningHall, @"Meal_0breakfast_1lunch_2brunch_3dinner":analyticsMeal}];
        blueImageString = @"";
    }
    
    if (currentPref == 2 && left == FALSE) { //erase your like
        [defaults setInteger:0 forKey:[menuIDList objectAtIndex:indexPath.row]];
        [FIRAnalytics logEventWithName:@"Swipe" parameters:@{@"Menu_Item":[entreeList objectAtIndex:indexPath.row], @"Item_ID":[menuIDList objectAtIndex:indexPath.row], @"Direction_1dislike_2like":@2, @"Rating_Type_0firsttime_1changed_2erased":@2, @"Dining_Hall":diningHall, @"Meal_0breakfast_1lunch_2brunch_3dinner":analyticsMeal}];
        blueImageString = @"";
    }
    
    [defaults synchronize];
    
    currentPref = (int)[defaults integerForKey:[menuIDList objectAtIndex:indexPath.row]];
    
    NSString *grayImageString;
    if (currentPref == 0) grayImageString = @"";
    if (currentPref == 1) grayImageString = @"Thumbs Down.png";
    if (currentPref == 2) grayImageString = @"Thumbs Up.png";
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:grayImageString]];
    
    [UIView animateWithDuration:.5
                     animations:^{
                         [cell setFrame:CGRectMake(frameSet, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
                     }
                     completion:^(BOOL finished) {
                         cell.alpha = 0;
                         [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
                         [UIView animateWithDuration:1
                                          animations:^{
                                              cell.alpha = 1;
                                          }];
                         //                         [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
                     }];
    
    UIImage *thumbsdownImage = [UIImage imageNamed:blueImageString];
    UIImageView *thumbsdownView =[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2), (self.view.frame.size.height / 2), 0,0)];
    thumbsdownView.image = thumbsdownImage;
    [self.view addSubview:thumbsdownView];
    [UIView animateWithDuration:.35
                     animations:^{
                         [thumbsdownView setFrame:CGRectMake((self.view.frame.size.width / 2) - (thumbsdownImage.size.width / 2), (self.view.frame.size.height / 2) - (thumbsdownImage.size.height / 2), thumbsdownImage.size.width, thumbsdownImage.size.height)];
                         [self.view addSubview:thumbsdownView];}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.05
                                          animations:^{
                                              [thumbsdownView setFrame:CGRectMake((self.view.frame.size.width / 2) - (.93*thumbsdownImage.size.width / 2), (self.view.frame.size.height / 2) - (.93*thumbsdownImage.size.height / 2), .93*thumbsdownImage.size.width, .93*thumbsdownImage.size.height)];
                                              [self.view addSubview:thumbsdownView];
                                              
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.05
                                                               animations:^{
                                                                   [thumbsdownView setFrame:CGRectMake((self.view.frame.size.width / 2) - (.97*thumbsdownImage.size.width / 2), (self.view.frame.size.height / 2) - (.97*thumbsdownImage.size.height / 2), .97*thumbsdownImage.size.width, .97*thumbsdownImage.size.height)];
                                                                   [self.view addSubview:thumbsdownView];}];
                                          }
                          ];
                     }];
    
    
    
    double delayInSeconds = 0.8;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:.25
                         animations:^{
                             thumbsdownView.alpha = 0; }];
    });
    
    delayInSeconds = 1.0;
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [thumbsdownView removeFromSuperview];
        
    });
    
}


- (void)leftSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [self animateSwipeIsLeft:TRUE withRecognizer:gestureRecognizer];
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    [self animateSwipeIsLeft:FALSE withRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
