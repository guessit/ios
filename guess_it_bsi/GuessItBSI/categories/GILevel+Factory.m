//
//  GILevel+Factory.m
//  GuessItBSI
//
//  Created by Marlon Andrade on 02/04/13.
//  Copyright (c) 2013 Marlon Andrade. All rights reserved.
//

#import "GILevel+Factory.h"

#import "GIItem.h"

@implementation GILevel (Factory)

+ (GILevel *)bancoDados {
    GILevel *bancoDados = [GILevel levelWithName:@"Banco de Dados"];
    bancoDados.guessingItems = @[
        [GIItem itemWithImageNamed:@"001" anwser:@"firebird" hints:nil],
        [GIItem itemWithImageNamed:@"002" anwser:@"mysql" hints:nil],
        [GIItem itemWithImageNamed:@"003" anwser:@"oracle" hints:nil],
        [GIItem itemWithImageNamed:@"004" anwser:@"postgresql" hints:nil],
        [GIItem itemWithImageNamed:@"005" anwser:@"sqlite" hints:nil],
        [GIItem itemWithImageNamed:@"006" anwser:@"sql server" hints:nil],
    ];

    return bancoDados;
}

+ (GILevel *)frameworks {
    GILevel *frameworks = [GILevel levelWithName:@"Frameworks"];
    frameworks.guessingItems = @[
        [GIItem itemWithImageNamed:@"007" anwser:@"drupal" hints:nil],
        [GIItem itemWithImageNamed:@"008" anwser:@"rails" hints:nil],
        [GIItem itemWithImageNamed:@"009" anwser:@"wordpress" hints:nil],
        [GIItem itemWithImageNamed:@"010" anwser:@"zend" hints:nil],
        [GIItem itemWithImageNamed:@"011" anwser:@"coffeescript" hints:nil],
        [GIItem itemWithImageNamed:@"012" anwser:@"jquery" hints:nil],
        [GIItem itemWithImageNamed:@"013" anwser:@"sinatra" hints:nil],
    ];

    return frameworks;
}

+ (GILevel *)ides {
    GILevel *ides = [GILevel levelWithName:@"IDEs & Editores de Texto"];
    ides.guessingItems = @[
        [GIItem itemWithImageNamed:@"014" anwser:@"eclipse" hints:nil],
        [GIItem itemWithImageNamed:@"015" anwser:@"mono develop" hints:nil],
        [GIItem itemWithImageNamed:@"016" anwser:@"netbeans" hints:nil],
        [GIItem itemWithImageNamed:@"017" anwser:@"visual studio" hints:nil],
        [GIItem itemWithImageNamed:@"018" anwser:@"xcode" hints:nil],
        [GIItem itemWithImageNamed:@"023" anwser:@"emacs" hints:nil],
        [GIItem itemWithImageNamed:@"024" anwser:@"sublime text" hints:nil],
        [GIItem itemWithImageNamed:@"025" anwser:@"vim" hints:nil],
    ];

    return ides;
}

+ (GILevel *)linguagensProgramacao {
    GILevel *linguagensProgramacao = [GILevel levelWithName:@"Linguagens de Programação"];
    linguagensProgramacao.guessingItems = @[
        [GIItem itemWithImageNamed:@"019" anwser:@"java" hints:nil],
        [GIItem itemWithImageNamed:@"020" anwser:@"php" hints:nil],
        [GIItem itemWithImageNamed:@"021" anwser:@"python" hints:nil],
        [GIItem itemWithImageNamed:@"022" anwser:@"ruby" hints:nil],
    ];

    return linguagensProgramacao;
}

+ (GILevel *)ferramentas {
    GILevel *ferramentas = [GILevel levelWithName:@"Ferramentas"];
    ferramentas.guessingItems = @[
        [GIItem itemWithImageNamed:@"026" anwser:@"apache" hints:nil],
        [GIItem itemWithImageNamed:@"027" anwser:@"git" hints:nil],
        [GIItem itemWithImageNamed:@"028" anwser:@"subversion" hints:nil],
        [GIItem itemWithImageNamed:@"029" anwser:@"azure" hints:nil],
        [GIItem itemWithImageNamed:@"030" anwser:@"github" hints:nil],
        [GIItem itemWithImageNamed:@"031" anwser:@"heroku" hints:nil],
    ];

    return ferramentas;
}

@end
