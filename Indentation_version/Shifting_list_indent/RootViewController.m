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
    self.title = NSLocalizedString(@"Shifting List(indent)", @"elements");
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
    NSRange range1 = NSMakeRange(0,4);
    NSRange range2 = NSMakeRange(0,3);
    NSRange range3 = NSMakeRange(0,2);
    NSString *list[] = {@"The day the whole world went away",@"Life in a box",@"The vampire",@"Likability",@"Moonlight",@"A prince, not pauper",@"An aneurysm",@"Viva la vida",@"Y so serious??",@"Clocks",@"The day the whole world went away",@"Life in a box",@"The vampire",@"Likability",@"Moonlight",@"A prince, not pauper",@"An aneurysm",@"Viva la vida",@"Y so serious??",@"Clocks",@"The day the whole world went away",@"Life in a box",@"The vampire",@"Likability",@"Moonlight",@"A prince, not pauper",@"An aneurysm",@"Viva la vida",@"Y so serious??",@"Clocks"};
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (orient == 1){
        cell.textLabel.textAlignment = UITextAlignmentLeft; 
        cell.indentationLevel = 0;
    }
    if (orient == 2){
        /*Since the articles 'A', 'An' and 'The' do not convey any extra information while taking up valuable space, it would be more useful if they were kept within the scroll space provided by the indentation and were made less distinct or "black". This can be done by making these articles greyish which will "blend" with the white. I haven't provided this functionality in current application! */
        if([[list[indexPath.row] substringWithRange:range1]isEqualToString: @"The "] || [[list[indexPath.row] substringWithRange:range1]isEqualToString: @"the "])
            cell.indentationLevel = 4; 
        else if([[list[indexPath.row] substringWithRange:range2]isEqualToString: @"An "] || [[list[indexPath.row] substringWithRange:range2]isEqualToString: @"an "])
            cell.indentationLevel = 5;
        else if([[list[indexPath.row] substringWithRange:range3]isEqualToString: @"A "] || [[list[indexPath.row] substringWithRange:range3]isEqualToString: @"a "])
            cell.indentationLevel = 6;
        else cell.indentationLevel = 8;}
        cell.textLabel.text = list[indexPath.row];
    
    return cell;
}

- (void)dealloc
{
    [super dealloc];
}

@end
