#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

    IBOutlet UIImageView *bKCrowds;
    IBOutlet UIImageView *bRCrowds;
    IBOutlet UIImageView *cCCrowds;
    IBOutlet UIImageView *dCCrowds;
    IBOutlet UIImageView *bFCrowds;
    IBOutlet UIImageView *mCCrowds;
    IBOutlet UIImageView *jECrowds;
    IBOutlet UIImageView *pMCrowds;
    IBOutlet UIImageView *pCCrowds;
    IBOutlet UIImageView *sYCrowds;
    IBOutlet UIImageView *sMCrowds;
    IBOutlet UIImageView *eSCrowds;
    IBOutlet UIImageView *tDCrowds;
    IBOutlet UIImageView *tCCrowds;
    
    IBOutlet UIImageView *white;
    
    IBOutlet UIButton *bKButton;
    IBOutlet UIButton *bRButton;
    IBOutlet UIButton *cCButton;
    IBOutlet UIButton *dCButton;
    IBOutlet UIButton *bFButton;
    IBOutlet UIButton *mCButton;
    IBOutlet UIButton *jEButton;
    IBOutlet UIButton *pMButton;
    IBOutlet UIButton *pCButton;
    IBOutlet UIButton *sYButton;
    IBOutlet UIButton *sMButton;
    IBOutlet UIButton *eSButton;
    IBOutlet UIButton *tDButton;
    IBOutlet UIButton *tCButton;
    
    IBOutlet UIButton *reloadButton;
    
    IBOutlet UIButton *backToHomeButton;
    IBOutlet UIButton *breakfastButton;
    IBOutlet UIButton *lunchButton;
    IBOutlet UIButton *dinnerButton;
    
    IBOutlet UILabel *lbl1;
    IBOutlet UILabel *lbl2;
    IBOutlet UILabel *lbl3;
    
    IBOutlet UIButton *daySelector;
    
    IBOutlet UISegmentedControl *control;
    
    NSString *diningHall;
    
    int locationCode;
    
    NSString *firstMealTime;
    NSString *secondMealTime;
    NSString *thirdMealTime;
    
    NSString *continentalTime;
    NSString *hotTime;
    NSString *lunchTime;
    NSString *brunchTime;
    NSString *dinnerTime;
    
    NSString *html;
    
    NSMutableArray *mealData;
    
    BOOL hasBreakfast;
    BOOL hasBrunch;
    BOOL hasLunch;
    BOOL hasDinner;
    BOOL hotToday;
    BOOL hotTomorrow;
    
    BOOL hotBreakfastToday;
    BOOL hotBreakfastTomorrow;
    BOOL continentalBreakfastToday;
    BOOL continentalBreakfastTomorrow;
    BOOL brunchToday;
    BOOL brunchTomorrow;
    BOOL lunchToday;
    BOOL lunchTomorrow;
    BOOL dinnerToday;
    BOOL dinnerTomorrow;
    
    // Where in the array to switch from today's meals to tomorrow's meals, such that
    // array[switchpoint] returns today's, and array[switchpoint+1] returns tomorrow's
    int switchpoint;
    
    int continentalSwitchpoint;
    int hotSwitchpoint;
    int brunchSwitchpoint;
    int lunchSwitchpoint;
    int dinnerSwitchpoint;
    
    BOOL isToday;
    BOOL datesInverted;
    BOOL mealToday;
    BOOL mealTomorrow;
    
    NSMutableArray *entreeList;
    NSMutableArray *courseList;
    NSMutableArray *menuIDList;
    
    IBOutlet UITableView *tableView;
    
    IBOutlet UIButton *infoButton;
    
    IBOutlet UILabel *menuDiningHall;
    IBOutlet UIImageView *menuMeal;
    IBOutlet UIButton *backToMealsButton;
    
    IBOutlet UILabel *menuDate;
    
    IBOutlet UILabel *title1;
    IBOutlet UILabel *title2;
    
    NSString *actualDiningHall;
    
    // Appears in the middle of the interface when no meals either day
    IBOutlet UILabel *noMeals;
    // Appears next to the day selector when there are only meals on one day
    IBOutlet UILabel *partialNoMeals;
    
    IBOutlet UIButton *sample;
    BOOL askForSample;
    BOOL showSample;
    
    // Only enabled after receiving the whiteout kill signal
    BOOL killed;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UISegmentedControl *daySegments;
    IBOutlet UISegmentedControl *mealSegments;
    
    // mealXTime hold the same times as lblX from legacy meal selector interface
    NSString *mealOneTime;
    NSString *mealTwoTime;
    NSString *mealThreeTime;
    // The time being shown at any given moment
    NSString *mealTime;
    
    BOOL hasAnyMeals;
    
    UIButton *introButton;
    UIButton *iconButton;
    UIButton *refreshButton;
    UIButton *mealsButton;
    UIButton *menuButton;
    UIButton *closingButton;
    UIButton *gearButton;
    UIButton *swipeButton;
    
    
    IBOutlet UILabel *iCantEat;
    
    IBOutlet UILabel *peanuts;
    IBOutlet UILabel *vegetarian;
    IBOutlet UILabel *vegan;
    IBOutlet UILabel *dairy;
    IBOutlet UILabel *gluten;
    IBOutlet UILabel *eggs;
    IBOutlet UILabel *soy;
    IBOutlet UILabel *pork;
    IBOutlet UILabel *nuts;
    IBOutlet UILabel *alcohol;
    IBOutlet UILabel *shellfish;
    IBOutlet UILabel *seafood;
    
    IBOutlet UILabel *disclaimer;
    
    IBOutlet UIButton *homeFromAllergies;
    
    IBOutlet UISwitch *switchPeanut;
    IBOutlet UISwitch *switchVegetarian;
    IBOutlet UISwitch *switchVegan;
    IBOutlet UISwitch *switchDairy;
    IBOutlet UISwitch *switchGluten;
    IBOutlet UISwitch *switchEggs;
    IBOutlet UISwitch *switchSoy;
    IBOutlet UISwitch *switchPork;
    IBOutlet UISwitch *switchNuts;
    IBOutlet UISwitch *switchAlcohol;
    IBOutlet UISwitch *switchShellfish;
    IBOutlet UISwitch *switchSeafood;
    
    IBOutlet UIView *peanutView;
    IBOutlet UIView *vegetarianView;
    IBOutlet UIView *veganView;
    IBOutlet UIView *dairyView;
    IBOutlet UIView *glutenView;
    IBOutlet UIView *eggsView;
    IBOutlet UIView *soyView;
    IBOutlet UIView *porkView;
    IBOutlet UIView *nutsView;
    IBOutlet UIView *alcoholView;
    IBOutlet UIView *shellfishView;
    IBOutlet UIView *seafoodView;
    
    IBOutlet UIButton *allergiesButton;
    
    BOOL showAllergies;
    
    IBOutlet UIButton *skipTutorial;
}


@property (nonatomic, retain) IBOutlet UIImageView *bKCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *bRCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *cCCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *dCCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *bFCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *mCCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *jECrowds;
@property (nonatomic, retain) IBOutlet UIImageView *pMCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *pCCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *sYCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *sMCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *eSCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *tDCrowds;
@property (nonatomic, retain) IBOutlet UIImageView *tCCrowds;


@end

