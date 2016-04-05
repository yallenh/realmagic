//
//  ViewController.m
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/4/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>

// models
#import "Person.h"
#import "Dog.h"

// Realm model object
@interface DemoObject : RLMObject
@property NSString *title;
@property NSDate   *date;
@end

@implementation DemoObject
// None needed
@end

static NSString * const kCellID    = @"cell";
static NSString * const kTableName = @"table";

@interface ViewController ()
@property (nonatomic, strong) RLMResults *array;
@property (nonatomic, strong) RLMNotificationToken *notification;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.array = [[DemoObject allObjects] sortedResultsUsingProperty:@"date" ascending:YES];
    [self setupUI];
    
    // Set realm notification block
    __weak typeof(self) weakSelf = self;
    self.notification = [self.array addNotificationBlock:^(RLMResults *data, NSError *error) {
        [weakSelf.tableView reloadData];
    }];



    // test
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];

    [realm transactionWithBlock:^{
        [Dog createInRealm:realm withValue:@[@"Rex", @2]];
        
        Person *john = [[Person alloc] init];
        john.name = @"John";
        [john.dogs addObjects:[Dog objectsWhere:@"name contains 'Rex'"]];
        
        Person *mary = [[Person alloc] init];
        mary.name = @"Mary";
        [mary.dogs addObjects:[Dog objectsWhere:@"name contains 'Rex'"]];
        
        [Person createInRealm:realm withValue:john];
        [Person createInRealm:realm withValue:mary];
    }];

    
    // Log all dogs and their owners using the "owners" inverse relationship
    RLMResults *allDogs = [Dog allObjects];
    for (Dog *dog in allDogs) {
        NSArray *ownerNames = [dog.owners valueForKeyPath:@"name"];
        NSLog(@"%@", dog.owners);
        NSLog(@"%@ has %lu owners (%@)", dog.name, (unsigned long)ownerNames.count, ownerNames);
    }
    /*
    Dog *myDog = [[Dog alloc] init];
    myDog.name = @"Fido";
    myDog.age = 10;
    
    Person *jim = [[Person alloc] init];
    Dog *rex = [[Dog alloc] init];
    // rex.owner = jim;
    RLMResults<Dog *> *someDogs = [Dog objectsWhere:@"name contains 'Fido'"];
    [jim.dogs addObjects:someDogs];
    [jim.dogs addObject:rex];
    
    NSLog(@"%@", jim.dogs);
    NSLog(@"%@", rex.owners);
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:kCellID];
    }
    
    DemoObject *object = self.array[indexPath.row];
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = object.date.description;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RLMRealm *realm = RLMRealm.defaultRealm;
        [realm beginWriteTransaction];
        [realm deleteObject:self.array[indexPath.row]];
        [realm commitWriteTransaction];
    }
}

#pragma mark - Actions

- (void)setupUI
{
    self.title = @"TableViewExample";
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"BG Add"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(backgroundAdd)];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(add)];
}

- (void)backgroundAdd
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // Import many items in a background thread
    dispatch_async(queue, ^{
        // Get new realm and table since we are in a new thread
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        for (NSInteger index = 0; index < 5; index++) {
            // Add row via dictionary. Order is ignored.
            [DemoObject createInRealm:realm withValue:@{@"title": [self randomString],
                                                        @"date": [self randomDate]}];
        }
        [realm commitWriteTransaction];
    });
}

- (void)add
{
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm beginWriteTransaction];
    [DemoObject createInRealm:realm withValue:@[[self randomString], [self randomDate]]];
    [realm commitWriteTransaction];
}

#pragma - Helpers

- (NSString *)randomString
{
    return [NSString stringWithFormat:@"Title %d", arc4random()];
}

- (NSDate *)randomDate
{
    return [NSDate dateWithTimeIntervalSince1970:arc4random()];
}

@end
