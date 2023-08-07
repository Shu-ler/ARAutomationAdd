//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		
#Область ПрограммныйИнтерфейс

#Область ЗаполнениеОбработчиковФормы

// Переопределяемая процедура, вызываемая из одноименного обработчика события формы.
//
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - форма, из обработчика события которой происходит вызов процедуры.
// 	Отказ - Булево -
// 	СтандартнаяОбработка - Булево - 
//
&После("ПриСозданииНаСервере")
Процедура ДКА_ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт

	ДКА_ИмяФормы = Форма.ИмяФормы;

	Если ДКА_ИмяФормы = "Справочник.Номенклатура.Форма.ФормаЭлемента" Тогда
//		ДКА_ФормыОбъектов.ПриСозданииНаСервере_НоменклатураФормаЭлемента(Форма);
	ИначеЕсли ДКА_ИмяФормы = "Справочник.Номенклатура.Форма.ФормаСписка" Тогда
		ДКА_ФормыОбъектов.ПриСозданииНаСервере_НоменклатураФормаСписка(Форма);
	ИначеЕсли ДКА_ИмяФормы = "Документ.УстановкаЦенНоменклатуры.Форма.ФормаДокумента" Тогда
		ДКА_ФормыОбъектов.ПриСозданииНаСервере_УстановкаЦенНоменклатуры(Форма);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

