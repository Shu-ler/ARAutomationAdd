//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		

// @strict-types
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)

	ОткрытьФорму("Обработка.ДКА_ЗаменаСимволовВАртикуле.Форма",
				 ,
				 ПараметрыВыполненияКоманды.Источник,
				 ПараметрыВыполненияКоманды.Уникальность,
				 ПараметрыВыполненияКоманды.Окно,
				 ПараметрыВыполненияКоманды.НавигационнаяСсылка,
				 ,
				 РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

#КонецОбласти