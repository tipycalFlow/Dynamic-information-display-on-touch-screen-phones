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

@implementation RootViewController

#define kFilteringFactor 0.05
#define methodToUse 0

@synthesize list,gravityValue,indentationValue;
@synthesize accelerationX;

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"Floating List", @"elements");
    accelerometerOn = false;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Start float" style:UIBarButtonItemStylePlain target:self action:@selector(toggleAccelerometer)];
    indentationValue=0;
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
    gravityValue=accelerationX; //Increase/decrease this to increase/decrease the sensitivity of floatation with tilt angle
#else
    gravityValue=accelerationX/2;
#endif
    [self.tableView reloadData];
} 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    int width = [[list objectAtIndex:(indexPath.row)%10] sizeWithFont:cell.textLabel.font].width ;

// Two possible ways
#if(methodToUse) // Uses setFrame: method
    indentationValue += gravityValue;
    
    // Limit indentationValue between table's bounds
    if (indentationValue > tableView.frame.size.width){
        indentationValue = tableView.frame.size.width;
        alignedLeft = false;
    }
    else if(indentationValue < 0){
        indentationValue=0;
        alignedLeft = true;
    }
    
    if(alignedLeft){
        if(indentationValue + width <= tableView.frame.size.width){
            [cell.textLabel setFrame:CGRectMake((int)indentationValue, cell.textLabel.frame.origin.y, width, cell.textLabel.frame.size.height)];
        }
        else
            [cell.textLabel setFrame:CGRectMake(tableView.frame.size.width - width, cell.textLabel.frame.origin.y, width, cell.textLabel.frame.size.height)];
    }
    else{
        if((indentationValue - width) >= 0){
            [cell.textLabel setFrame:CGRectMake((int)indentationValue - width, cell.textLabel.frame.origin.y, width, cell.textLabel.frame.size.height)];
        }
        else
            [cell.textLabel setFrame:CGRectMake(0, cell.textLabel.frame.origin.y, width, cell.textLabel.frame.size.height)];
    }
#else // Uses alignment + indentation
    if((indentationValue + gravityValue)>=0){
        indentationValue += gravityValue;
        //        NSLog(@"indentation%f",indentationValue);
        if((width + ((int)indentationValue)*16) <= (tableView.frame.size.width)+40){
            cell.indentationLevel = (int)indentationValue;
            cell.textLabel.textAlignment = UITextAlignmentLeft;
        }
        else{
            cell.textLabel.textAlignment = UITextAlignmentRight;
            indentationValue -= gravityValue;
        }
    }
#endif
    NSLog(@"indentation%f",indentationValue);
    cell.textLabel.text = [list objectAtIndex:(indexPath.row)%10];
    return cell;
}

- (void)dealloc
{
    [list release];
    [super dealloc];
}

@end
