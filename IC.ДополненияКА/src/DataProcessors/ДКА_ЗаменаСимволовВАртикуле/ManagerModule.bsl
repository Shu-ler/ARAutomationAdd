//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		

// @strict-types
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Добавление команды замены символов в артикуле на панель администрирования.
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма
Процедура ДобавитьКомандуНаПанельАдминистрирования(Форма) Экспорт

	// Разыменование и константы
	Элементы = Форма.Элементы;
	ИмяЭлементаФормы = "ДКА_ЗаменаСимволовВАртикуле";
	ТекстЗаголовка = НСтр("ru = 'Замена символов в артикуле номенклатуры'");
	ТекстПодсказки = НСтр("ru = 'Пакетная замена определенного символа в артикуле на другой. К примеру, таким образом можно удалить все пробелы или все точки из артикула, заменить пробелы на подчеркивания и т.п.'");
	СсылкаКоманды = "e1cib/command/ОбщаяКоманда.ДКА_ЗаменаСимволовВАртикуле";
	
	// Получение группы размещения
	ГруппаРазмещения = Элементы.Найти("ГруппаОбработкаГрупповоеИзменениеОбъектов");

	// Добавление команды на форму
	КомандаЭлемент = Элементы.Добавить(ИмяЭлементаФормы, Тип("ДекорацияФормы"), ГруппаРазмещения);
	КомандаЭлемент.Заголовок = Новый ФорматированнаяСтрока(ТекстЗаголовка, , , , СсылкаКоманды);
	КомандаЭлемент.Подсказка = ТекстПодсказки;
	КомандаЭлемент.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСнизу;

КонецПроцедуры

#КонецОбласти

#КонецЕсли