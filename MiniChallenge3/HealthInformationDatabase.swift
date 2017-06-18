//
//  AssistanceDatabase.swift
//  MiniChallenge3
//
//  Created by Ana Carolina Silva on 15/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit


class HealthInformationDB {
    static let healthInformations: [HealthInformationModel] = [
        //Habits informations
        HealthInformationModel.init(category: .habits, information: "Evite trocar o vício do cigarro por outros! Não desconte a vontade de cigarro em alimentos gordurosos ou em bebidas como café ou cerveja."),
        HealthInformationModel.init(category: .habits, information: "Mantenha hábitos saudáveis: pratique exercícios físicos e coma de forma regular e sem exageros, isto irá te ajudar nos momentos de fissura."),
        HealthInformationModel.init(category: .habits, information: "Mude a rotina, seus hábitos. Muito do vício pelo cigarro vem de uma rotina, de apenas um hábito. Procure fazer algo pelas manhãs como caminhar ou exercitar algum hobbie."),
        HealthInformationModel.init(category: .habits, information: "Evite comer no lugar de fumar, isto é a principal causa de muitos ex-fumantes engordarem no processo de parar de fumar."),
        HealthInformationModel.init(category: .habits, information: "Tente adiar os cigarros da manhã, fazendo isto, você vai fumar cada vez menos e terá menos dificuldade de parar depois, pois os cigarros da manhã, normalmente, são os mais difícies de parar."),
        //Health informations
        HealthInformationModel.init(category: .health, information: "Fumar pode causar inúmeras doenças além de diminuir muito do seu potencial diário em termos de cansaço, estresse, atividade, entre outros."),
        HealthInformationModel.init(category: .health, information: "Já se sentiu cansado por apenas subir uma escada? Pois é, o fumo diminui muito seu fôlego e sua capacidade respiratória."),
        HealthInformationModel.init(category: .health, information: "O alívio do estresse pelo cigarro é compensado com um estresse ainda maior, isto pode prejudicar seu desempenho na escola, faculdade, trabalho, etc."),
        HealthInformationModel.init(category: .health, information: "Se você parar de fumar agora: \n - Em 20 minutos, sua pressão arterial e a frequência do pulso voltam ao normal.\n - Em 2 horas, não haverá mais nicotina no seu sangue.\n - Em 8 horas, os níveis de monóxido de carbono no sangue chegam aos valores normais e o nível de oxigênio aumenta.\n - Em 24 horas, os pulmões já funcionam melhor e os brônquios começam a limpar os resíduos deixados pelo fumo.\n - Em 48 horas, o olfato já percebe melhor os cheiros e o paladar já degusta melhor a comida.\n - Dentro de 2 semanas a 3 meses, a circulação sanguínea melhora consideravelmente. Caminhar torna-se mais fácil e a função pulmonar melhora em até 30%.\n - Em 1 ano, o risco de doenças ligadas a males do coração, como infarto, cai pela metade.\n - Em 5 anos, diminui o risco de acidente vascular cerebral (AVC). Já o risco de infarto do miocárdio e morte por ataque cardíaco se aproxima daquele de quem nunca fumou.\n - Em 10 anos, o risco de sofrer um infarto será igual ao de quem nunca fumou. E haverá uma redução dos riscos de câncer na boca, garganta, esôfago, bexiga, rim e pâncreas.\n - Em 15 anos, o risco de desenvolver câncer de pulmão pode igualar-se ao dos não fumantes."),
         //Help informations
        HealthInformationModel.init(category: .help, information: "O SUS oferece todo um sistema de apoio de grupos tabagistas para parar de fumar consulte mais pelos seguintes contatos: \n\nAcesse o site: http://www2.inca.gov.br/wps/wcm/connect/acoes_programas/site/home/nobrasil/programa-nacional-controle-tabagismo/tratamento-do-tabagismo"),
        //Tips informations
        HealthInformationModel.init(category: .tips, information: "Busque apoio da família e de amigos. Tentar envolver pessoas que se importam com você neste momento que você está diminuindo a quantidade de cigarros e depois que realmente parar, pode tornar estas tarefas muito mais fácil."),
        HealthInformationModel.init(category: .tips, information: "O cigarro funciona como uma válvula de escape da ansiedade para a maioria dos fumantes. Por isso, é indicado procurar ajuda médica, como por exemplo uma nutricionista para ajudar a não extravasar a ansiedade em hábitos alimentares pouco saudáveis."),
        HealthInformationModel.init(category: .tips, information: ""),
        //Fissure informations
        HealthInformationModel.init(category: .fissure, information: "Procure se distrair, acima de tudo, a vontade de fumar passa rápido em média de 5 a 10 minutos a ânsia pela nicotina já acaba."),
        HealthInformationModel.init(category: .fissure, information: "Uma caminhada rápida pelo quarteirão pode ocupar esse tempo e deixar de lado essa vontade!"),
        HealthInformationModel.init(category: .fissure, information: "Exercite o músculo da boca! Muitos fumantes dizem ter passado a vontade de fumar por apenas beberem água, comerem algo leve, chuparem uma bala, entre outros. Mas lembre-se de escolher opções saudáveis!"),
        HealthInformationModel.init(category: .fissure, information: "Jogue algum joguinho no celular ou se distraía com um passatempo rápido, esse tipo de atividade ajuda a ocupar esse tempo."),
        HealthInformationModel.init(category: .fissure, information: "Respire fundo, relaxe, pense em coisas boas, uma pequena meditação interna ajuda a passar a vontade."),
        HealthInformationModel.init(category: .fissure, information: "Procure comer alguma coisa com um gosto forte, como gengibre, pois com o tempo você irá associar a vontade de fumar com uma coisa ruim.")]
    
    static func getInformation(from category: HealthInformationCategory) -> [HealthInformationModel]{
        
        var healthInformationsCategory = [HealthInformationModel]()
        //Return an array with all the informations from this category
        for information in healthInformations {
            if information.category == category {
                healthInformationsCategory.append(information)
            }
        }
        
        return healthInformationsCategory
    }
    
}
