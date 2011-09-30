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
@synthesize list,gravityValue,indentationValue;
@synthesize accelerationX;

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"Floating List", @"elements");
    accelerometerOn = false;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(toggleAccelerometer)];
    indentationValue=0;
    gravityValue=0;
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
        self.navigationItem.rightBarButtonItem.title = @"Start";
    }
    else{
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.delegate = self;
        accelerometer.updateInterval = 0.05;
        accelerometerOn = true;
        self.navigationItem.rightBarButtonItem.title = @"Stop";
    }
}

- (void) viewDidAppear:(BOOL)animated{
    [self toggleAccelerometer];
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
    NSLog(@"accelerationX%f",accelerationX);
    
    gravityValue=accelerationX/2;
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
    
    if((indentationValue + gravityValue)>=0){
        indentationValue += gravityValue;
        if (indentationValue>20)
            indentationValue=20;
        if((width + indentationValue*16) <= (tableView.frame.size.width )+50){
            cell.indentationLevel = indentationValue;
            cell.textLabel.textAlignment = UITextAlignmentLeft;
        }
        else
            cell.textLabel.textAlignment = UITextAlignmentRight;
    }
    
    cell.textLabel.text = [list objectAtIndex:(indexPath.row)%10];
    return cell;
}

- (void)dealloc
{
    [list release];
    [super dealloc];
}

@end
