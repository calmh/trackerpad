//
//  TrackerProject.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "TrackerPerson.h"
#import "TrackerProject.h"

@implementation TrackerProject

@synthesize name;
@synthesize id;
@synthesize velocity;
@synthesize members;

- (TrackerPerson*)memberNamed:(NSString*)fullName
{
        // TODO: Memoize this, in case it turns out to be called _often_.
        for (int i = 0; i < [members count]; i++) {
                TrackerPerson *person = [members objectAtIndex:i];
                if ([fullName isEqualToString:person.name])
                        return person;
        }

        return nil;
}

@end
