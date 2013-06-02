//
//  GIDataSource.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 01/06/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GIDataSource.h"

#import "GILevel.h"

@implementation GIDataSource

#pragma mark - Public Interface

+ (instancetype)dataSource {
    static GIDataSource *__dataSource;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __dataSource = [[GIDataSource alloc] init];
    });
    return __dataSource;
}

#warning TODO: BROWSER - chrome, ie, firefox, safari, opera, etc
#warning TODO: SISTEMAS OPERACIONAIS - windows, ubuntu, osx, ios, android, etc
#warning TODO: MARCAS - apple, google, microsoft, hp, cisco, etc
#warning TODO: PERSONALIDADES - steve jobs, bill gates, etc

- (NSArray *)loadLevels {
    return @[
        [GILevel levelWithImageNamed:@"001" anwser:@"firebird" category:@"Banco de Dados" hints:nil],
        [GILevel levelWithImageNamed:@"002" anwser:@"mysql" category:@"Banco de Dados" hints:nil],
        [GILevel levelWithImageNamed:@"003" anwser:@"oracle" category:@"Banco de Dados" hints:nil],
        [GILevel levelWithImageNamed:@"004" anwser:@"postgresql" category:@"Banco de Dados" hints:nil],
        [GILevel levelWithImageNamed:@"005" anwser:@"sqlite" category:@"Banco de Dados" hints:nil],
        [GILevel levelWithImageNamed:@"006" anwser:@"sql server" category:@"Banco de Dados" hints:nil],
        [GILevel levelWithImageNamed:@"007" anwser:@"drupal" category:@"Framework" hints:nil],
        [GILevel levelWithImageNamed:@"008" anwser:@"rails" category:@"Framework" hints:nil],
        [GILevel levelWithImageNamed:@"009" anwser:@"wordpress" category:@"Framework" hints:nil],
        [GILevel levelWithImageNamed:@"010" anwser:@"zend" category:@"Framework" hints:nil],
        [GILevel levelWithImageNamed:@"011" anwser:@"coffeescript" category:@"Framework" hints:nil],
        [GILevel levelWithImageNamed:@"012" anwser:@"jquery" category:@"Framework" hints:nil],
        [GILevel levelWithImageNamed:@"013" anwser:@"sinatra" category:@"Framework" hints:nil],
        [GILevel levelWithImageNamed:@"014" anwser:@"eclipse" category:@"IDE" hints:nil],
        [GILevel levelWithImageNamed:@"015" anwser:@"mono develop" category:@"IDE" hints:nil],
        [GILevel levelWithImageNamed:@"016" anwser:@"netbeans" category:@"IDE" hints:nil],
        [GILevel levelWithImageNamed:@"017" anwser:@"visual studio" category:@"IDE" hints:nil],
        [GILevel levelWithImageNamed:@"018" anwser:@"xcode" category:@"IDE" hints:nil],
        [GILevel levelWithImageNamed:@"019" anwser:@"java" category:@"Linguagem de Programação" hints:nil],
        [GILevel levelWithImageNamed:@"020" anwser:@"php" category:@"Linguagem de Programação" hints:nil],
        [GILevel levelWithImageNamed:@"021" anwser:@"python" category:@"Linguagem de Programação" hints:nil],
        [GILevel levelWithImageNamed:@"022" anwser:@"ruby" category:@"Linguagem de Programação" hints:nil],
        [GILevel levelWithImageNamed:@"023" anwser:@"emacs" category:@"Editor de Texto" hints:nil],
        [GILevel levelWithImageNamed:@"024" anwser:@"sublime text" category:@"Editor de Texto" hints:nil],
        [GILevel levelWithImageNamed:@"025" anwser:@"vim" category:@"Editor de Texto" hints:nil],
        [GILevel levelWithImageNamed:@"026" anwser:@"apache" category:@"Ferramenta" hints:nil],
        [GILevel levelWithImageNamed:@"027" anwser:@"git" category:@"Ferramenta" hints:nil],
        [GILevel levelWithImageNamed:@"028" anwser:@"subversion" category:@"Ferramenta" hints:nil],
        [GILevel levelWithImageNamed:@"029" anwser:@"azure" category:@"Ferramenta" hints:nil],
        [GILevel levelWithImageNamed:@"030" anwser:@"github" category:@"Ferramenta" hints:nil],
        [GILevel levelWithImageNamed:@"031" anwser:@"heroku" category:@"Ferramenta" hints:nil],
    ];
}

@end
