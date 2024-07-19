//
//  JSONData.swift
//  IOSUtils
//
//  Created by itserviceimac on 19/07/24.
//

import Foundation
import SwiftyJSON


class JSONData {

    static var tableViewTypesJson = JSON(parseJSON: """
        [
          {
            "sectionTitle": "TableView",
            "data": [
              {"id": "01", "title": "UITableView via Section"},
              {"id": "02", "title": "UITableView without Section"}
            ]
          },
          {
            "sectionTitle": "Parallax",
            "data": [
              {"id": "03", "title": "Parallax Cell"}
            ]
          }
        ]

    """)



    static var historyJSON = JSON(parseJSON: """
        [
          {
            "date": "25 января, 2024",
            "dateName": "Сегодня",
            "data": [
              {
                "operationName": "Tcell",
                "operationInfo": "Мобильная связь",
                "amount": "-25 TJS",
                "ico": "history1",
                "operationStatus": "В обработке",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "В обработке"    }
                ]
              },
              {
                "operationName": "В контакте",
                "operationInfo": "Социальные сети",
                "amount": "-100,55 TJS",
                "ico": "history2",
                "operationStatus": "Успешно",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "Успешно"        }
                ]
              }
            ]
          },
          {
            "date": "24 января, 2024",
            "dateName": "Вчера",
            "data": [
              {
                "operationName": "Megafon",
                "operationInfo": "Мобильная связь",
                "amount": "-15 TJS",
                "ico": "history3",
                "operationStatus": "Ошибка",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "Ошибка"         }
                ]
              },
              {
                "operationName": "Пополнение кошелька",
                "operationInfo": "Пополнение",
                "amount": "+5000 TJS",
                "ico": "history4",
                "operationStatus": "В обработке",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "В обработке"    }
                ]
              },
              {
                "operationName": "Барк, ш. Хучанд",
                "operationInfo": "Электроэнергия",
                "amount": "-450,38 TJS",
                "ico": "history5",
                "operationStatus": "В обработке",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "В обработке"    }
                ]
              }
            ]
          },
          {
            "date": "24 января, 2024",
            "dateName": "Вчера",
            "data": [
              {
                "operationName": "Вавалон-М",
                "operationInfo": "Мобильная сеть",
                "amount": "-41 TJS",
                "ico": "history6",
                "operationStatus": "В обработке",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "В обработке"    }
                ]
              },
              {
                "operationName": "Перевод на счет Акбар...",
                "operationInfo": "Перевод",
                "amount": "-150 TJS",
                "ico": "history7",
                "operationStatus": "В обработке",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "В обработке"    }
                ]
              },
              {
                "operationName": "Барк, ш. Хучанд",
                "operationInfo": "Электроэнергия",
                "amount": "-1220 TJS",
                "ico": "history5",
                "operationStatus": "В обработке",
                "additionalInfo": [
                  {"key": "Получатель"     , "value": "1029132"        },
                  {"key": "Комиссия"       , "value": "0 TJS"          },
                  {"key": "Дата"           , "value": "25 января, 2024"},
                  {"key": "Номер операции" , "value": "238172837811"   },
                  {"key": "Статус операции", "value": "В обработке"    }
                ]
              }
            ]
          }
        ]
    """)


    static var cardsJSON = JSON(parseJSON: """
        {
          "data": [
            {
              "id"      : "01"                   ,
              "userName": "Burhonov Akmalkhon"   ,
              "cardName": "Visa Classic ****1221",
              "amount"  : "1 250 USD"            ,
              "imgName" : "visa"
            },
            {
              "id"      : "02"                ,
              "userName": "Burhonov Akmalkhon",
              "cardName": "MIR ****1221"      ,
              "amount"  : "74 500 RUB"        ,
              "imgName" : "visa"
            },
            {
              "id"      : "03"                       ,
              "userName": "Burhonov Akmalkhon"       ,
              "cardName": "Корти милли Alif ****1221",
              "amount"  : ""                         ,
              "imgName" : "visa"
            },
            {
              "id"      : "04"                          ,
              "userName": "Burhonov Akmalkhon"          ,
              "cardName": "Express Card Arvand ****2392",
              "amount"  : "520 TJS"                     ,
              "imgName" : "visa"
            },
            {
              "id"      : "05"                 ,
              "userName": "Burhonov Akmalkhon" ,
              "cardName": "4048***VISA****0221",
              "amount"  : ""                   ,
              "imgName" : "visa"
            }
          ]
        }
    """)

    
}
