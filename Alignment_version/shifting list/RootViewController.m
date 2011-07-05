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

- (void)viewDidLoad
{
    self.title = NSLocalizedString(@"Shifting List", @"elements");
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    UIDeviceOrientation orientSide = [[UIDevice currentDevice] orientation];
    if (orientSide == UIDeviceOrientationLandscapeLeft) orient = 1;
    if (orientSide == UIDeviceOrientationLandscapeRight) orient = 2;
    [self.tableView reloadData];
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *list[] = {@"The day the whole world went away",@"Life in a box",@"The vampire",@"Likability",@"Moonlight",@"A prince, not pauper",@"An aneurysm",@"Viva la vida",@"Y so serious??",@"Clocks",@"The day the whole world went away",@"Life in a box",@"The vampire",@"Likability",@"Moonlight",@"A prince, not pauper",@"An aneurysm",@"Viva la vida",@"Y so serious??",@"Clocks",@"The day the whole world went away",@"Life in a box",@"The vampire",@"Likability",@"Moonlight",@"A prince, not pauper",@"An aneurysm",@"Viva la vida",@"Y so serious??",@"Clocks"};
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    if (orient == 1)
        cell.textLabel.textAlignment = UITextAlignmentLeft; 
    if (orient == 2)
        cell.textLabel.textAlignment = UITextAlignmentRight; 
	cell.textLabel.text = list[indexPath.row];
    
    return cell;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

- (void)dealloc
{
    [super dealloc];
}

@end
