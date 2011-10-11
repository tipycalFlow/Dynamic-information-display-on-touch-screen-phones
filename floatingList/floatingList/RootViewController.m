//
//  RootViewController.m
//  shifting list
//
//  Created by Aakash Chaudhary on 06/06/11.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "RootViewController.h"
#import "myTableCell.h"

@implementation RootViewController

#define kFilteringFactor 0.05
#define methodToUse 1

@synthesize list,gravityValue,indentationValue;
@synthesize accelerationX;

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"Floating List", @"elements");
    accelerometerOn = false;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Start float" style:UIBarButtonItemStylePlain target:self action:@selector(toggleAccelerometer)];
#if(methodToUse)
    indentationValue=5;
#else
    indentationValue=0;
#endif
    gravityValue=0;
    alignedLeft = true;
    list = [[NSMutableArray alloc] init];
    [list addObject:@"The day the whole world went away"];
    [list addObject:@"Life in a box"];
    [list addObject:@"The vampire"];
    [list addObject:@"Likability"];
    [list addObject:@"Moonlight"];
    [list addObject:@"A prince, not pauper"];
    [list addObject:@"An aneurysm"];
    [list addObject:@"Viva la vida"];
    [list addObject:@"Y so serious??"];
    [list addObject:@"Clocks"];
    [super viewDidLoad];
}

- (void) toggleAccelerometer{
    if(accelerometerOn){
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.delegate = nil;
        accelerometerOn = false;
        self.navigationItem.leftBarButtonItem.title = @"Start float";
    }
    else{
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.delegate = self;
        accelerometer.updateInterval = 0.05;
        accelerometerOn = true;
        self.navigationItem.leftBarButtonItem.title = @"Stop float";
    }
}

- (void) viewDidAppear:(BOOL)animated{
//    [self toggleAccelerometer];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3*[list count];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    // Use a basic low-pass filter to only keep the gravity in the accelerometer values for the X axis
    accelerationX = acceleration.x * kFilteringFactor + accelerationX * (1.0 - kFilteringFactor);
    
#if(methodToUse)
    gravityValue=accelerationX*10; //Increase/decrease this to increase/decrease the sensitivity of floatation with tilt angle
#else
    gravityValue=accelerationX/2;
#endif
    [self.tableView reloadData];
} 

// Two possible ways
#if(methodToUse) // Sub-classes UITableViewCell, follows physics

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";    
    float originX;
    indentationValue += gravityValue;
    
    int width = [[list objectAtIndex:(indexPath.row)%10] sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0]].width ;
    
    // Limit indentationValue between table's bounds plus a margin of 5 points
    if (indentationValue > tableView.frame.size.width - 5){
        indentationValue = tableView.frame.size.width - 5;
        alignedLeft = false;
    }
    else if(indentationValue < 5){
        indentationValue=5;
        alignedLeft = true;
    }
    
    if(alignedLeft)
        if(indentationValue + width <= tableView.frame.size.width - 5)
            originX = indentationValue;
        else
            originX = tableView.frame.size.width - width - 5;
    else
        if((indentationValue - width) >= 5)
            originX = indentationValue - width;
        else
            originX = 5;
    
    myTableCell * mCell = [[myTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier origin:originX width:width];

    mCell.textLabel.text = [list objectAtIndex:(indexPath.row)%10];
    mCell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    return mCell;
}

#else // Uses alignment + indentation without sub-classing UITableViewCell
// The physics of this method is wrong, though, because the elements are always
// left-aligned when they're in the middle of the screen

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    int width = [[list objectAtIndex:(indexPath.row)%10] sizeWithFont:cell.textLabel.font].width ;
    
    if((indentationValue + gravityValue)>=0){
        indentationValue += gravityValue;
        if((width + ((int)indentationValue)*16) <= (tableView.frame.size.width)+40){
            cell.indentationLevel = (int)indentationValue;
            cell.textLabel.textAlignment = UITextAlignmentLeft;
        }
        else{
            cell.textLabel.textAlignment = UITextAlignmentRight;
            indentationValue -= gravityValue;
        }
    }
    
    cell.textLabel.text = [list objectAtIndex:(indexPath.row)%10];
    return cell;
}

#endif

- (void)dealloc
{
    [list release];
    [super dealloc];
}

@end
