//
//  RootViewController.h
//  Shifting_list_indent
//
//  Created by Aakash Chaudhary on 07/06/11.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController<UIAccelerometerDelegate> {
    float accelerationX;
    NSMutableArray * list;
    float gravityValue;
    float indentationValue;
    BOOL accelerometerOn;
}
- (void)toggleAccelerometer;

@property(nonatomic,retain) NSMutableArray *list;
@property(assign) float gravityValue;
@property(assign) float indentationValue;
@property(assign) float accelerationX;

@end
