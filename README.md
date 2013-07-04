FFXIV-Lodestone
===============

!!! EARLY DEVELOPMENT STAGE !!! 

FFXIV-Lodestone for iOS

Features
----------

- Search Characters
- Find Characters By Id


TODO
----------

- Retrieve a Linkshell from Lodestone
- Retrieve a Free Company from Lodestone


EXAMPLE
----------

Searching

```objective-c
    [[FFLodestone sharedInstance] searchCharacterWithName:@"Hackfrag" worldName:nil classjob:nil completionHandler:^(NSArray *characters, NSError *error) {
        NSLog(@"%@", characters);
    }];
```

Fetching

```objective-c
    [[FFLodestone sharedInstance] fetchCharacterWithId:@"1674571" completionHandler:^(FFCharacter *character, NSError *error) {
        NSLog(@"%@", character);
    }];
```
