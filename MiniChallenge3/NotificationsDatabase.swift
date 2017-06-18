//
//  NotificationsDatabase.swift
//  MiniChallenge3
//
//  Created by Erick Borges on 14/06/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

public class NotificationsDatabase {
                                                     // -- Hábitos
    static let notifications: [NotificationModel] = [NotificationModel.init(identifier: "Habitos1", title: "Hábitos", message: "A prática de atividades físicas ajuda a conter a fissura!"),
                                                     NotificationModel.init(identifier: "Habitos2", title: "Hábitos", message: "Mude seus hábitos! A maioria dos gatilhos do cigarro estão relacionados ao seu cotidiano."),
                                                     NotificationModel.init(identifier: "Habitos3", title: "Habitos", message: "Tente adiar os cigarros da manhã, estes são os mais difíceis!"),
                                                     // -- Saúde
                                                     NotificationModel.init(identifier: "Saúde1", title: "Saúde", message: "Se parar de fumar agora, após 20 minutos sua pressão sangüínea e a pulsação voltam ao normal."),
                                                     NotificationModel.init(identifier: "Saúde2", title: "Saúde", message: "Se parar de fumar agora, após 2 horas não tem mais nicotina no seu sangue."),
                                                     NotificationModel.init(identifier: "Saúde3", title: "Saúde", message: "Se parar de fumar agora, após 8 horas o nível de oxigênio no sangue se normaliza."),
                                                     NotificationModel.init(identifier: "Saúde4", title: "Saúde", message: "Se parar de fumar agora, após 2 dias seu olfato já percebe melhor os cheiros e seu paladar já degusta a comida melhor"),
                                                     NotificationModel.init(identifier: "Saúde5", title: "Saúde", message: "Se parar de fumar agora, após 3 semanas a respiração fica mais fácil e a circulação melhora"),
                                                     NotificationModel.init(identifier: "Saúde6", title: "Saúde", message: "Se parar de fumar agora, após 5 A 10 anos o risco de sofrer infarto será igual ao de quem nunca fumou"),
                                                     NotificationModel.init(identifier: "Saúde7", title: "Saúde", message: "Fumantes correm 10 vezes mais risco de adoecer de cancer de pulmão"),
                                                     NotificationModel.init(identifier: "Saúde8", title: "Saúde", message: "Fumantes correm 5 vezes mais risco de sofrer infarto"),
                                                     NotificationModel.init(identifier: "Saúde9", title: "Saúde", message: "Fumantes correm 5 vezes mais risco de sofrer bronquite crônica e enfisema pulmonar"),
                                                     NotificationModel.init(identifier: "Saúde10", title: "Saúde", message: "Fumantes correm 2 vezes mais risco de derrame cerebral"),
                                                     // -- Ajuda
                                                     // -- Dicas
                                                     NotificationModel.init(identifier: "Dicas1", title: "Dica", message: "A fissura é uma vontade muito grande de fumar, que dura alguns minutos! Procure algo para se distrair, e logo ela passará!"),
                                                     NotificationModel.init(identifier: "Dicas2", title: "Dica", message: "Muitas pessoas passam a comer mais, e tem medo de engordar ao parar de fumar. Procure comer alimentos menos calóricos!"),
                                                     NotificationModel.init(identifier: "Dicas3", title: "Dica", message: "Evite beber durante o processo de parar de fumar! A bebida é o maior gatilho do cigarro."),
                                                     NotificationModel.init(identifier: "Dicas4", title: "Dica", message: "Evite frequentar lugares onde há muitos fumantes, isso irá te atrapalhar!"),
                                                     // -- Fissura
                                                     NotificationModel.init(identifier: "Fissura1", title: "Fissura", message: "Sentiu vontade de fumar? Tome um copo d’água!"),
                                                     NotificationModel.init(identifier: "Fissura2", title: "Fissura", message: "Procure algo para se distrair sempre que quiser fumar!"),
                                                     
                                                     
                                                     
                                                     //----------REPETINDO----------
                                                     NotificationModel.init(identifier: "Habito1", title: "Hábitos", message: "A prática de atividades físicas ajuda a conter a fissura!"),
                                                     NotificationModel.init(identifier: "Habito2", title: "Hábitos", message: "Mude seus hábitos! A maioria dos gatilhos do cigarro estão relacionados ao seu cotidiano."),
                                                     NotificationModel.init(identifier: "Habito3", title: "Habitos", message: "Tente adiar os cigarros da manhã, estes são os mais difíceis!"),
                                                     // -- Saúde
        NotificationModel.init(identifier: "Saúd1", title: "Saúde", message: "Se parar de fumar agora, após 20 minutos sua pressão sangüínea e a pulsação voltam ao normal."),
        NotificationModel.init(identifier: "Saúd2", title: "Saúde", message: "Se parar de fumar agora, após 2 horas não tem mais nicotina no seu sangue."),
        NotificationModel.init(identifier: "Saúd3", title: "Saúde", message: "Se parar de fumar agora, após 8 horas o nível de oxigênio no sangue se normaliza."),
        NotificationModel.init(identifier: "Saúd4", title: "Saúde", message: "Se parar de fumar agora, após 2 dias seu olfato já percebe melhor os cheiros e seu paladar já degusta a comida melhor"),
        NotificationModel.init(identifier: "Saúd5", title: "Saúde", message: "Se parar de fumar agora, após 3 semanas a respiração fica mais fácil e a circulação melhora"),
        NotificationModel.init(identifier: "Saúd6", title: "Saúde", message: "Se parar de fumar agora, após 5 A 10 anos o risco de sofrer infarto será igual ao de quem nunca fumou"),
        NotificationModel.init(identifier: "Saúd7", title: "Saúde", message: "Fumantes correm 10 vezes mais risco de adoecer de cancer de pulmão"),
        NotificationModel.init(identifier: "Saúd8", title: "Saúde", message: "Fumantes correm 5 vezes mais risco de sofrer infarto"),
        NotificationModel.init(identifier: "Saúd9", title: "Saúde", message: "Fumantes correm 5 vezes mais risco de sofrer bronquite crônica e enfisema pulmonar"),
        NotificationModel.init(identifier: "Saúd10", title: "Saúde", message: "Fumantes correm 2 vezes mais risco de derrame cerebral"),
        // -- Ajuda
        // -- Dicas
        NotificationModel.init(identifier: "Dica1", title: "Dica", message: "A fissura é uma vontade muito grande de fumar, que dura alguns minutos! Procure algo para se distrair, e logo ela passará!"),
        NotificationModel.init(identifier: "Dica2", title: "Dica", message: "Muitas pessoas passam a comer mais, e tem medo de engordar ao parar de fumar. Procure comer alimentos menos calóricos!"),
        NotificationModel.init(identifier: "Dica3", title: "Dica", message: "Evite beber durante o processo de parar de fumar! A bebida é o maior gatilho do cigarro."),
        NotificationModel.init(identifier: "Dica4", title: "Dica", message: "Evite frequentar lugares onde há muitos fumantes, isso irá te atrapalhar!"),
        // -- Fissura
        NotificationModel.init(identifier: "Fissur1", title: "Fissura", message: "Sentiu vontade de fumar? Tome um copo d’água!"),
        NotificationModel.init(identifier: "Fissur2", title: "Fissura", message: "Procure algo para se distrair sempre que quiser fumar!")]
    
    public static func getRandomNotification() -> [String]{
        
        //Gets a random notification
        let randNotification = notifications[Int(arc4random_uniform(UInt32(notifications.count)))]
        
        //Gets each element of the notification
        let identifier = randNotification.identifier
        let title = randNotification.title
        let message = randNotification.message
        
        //Returns notification parameters in Array
        return [identifier, title, message]
    }
    
}

















