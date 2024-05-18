//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		

// @strict-types
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Возврат при получении формы для анализа
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	// Вызов стандартной для конфигунации обработки события
	ДКА_СобытияФорм.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыполнитьЗамену(Команда)

	// Настройка поведения формы при выполнении длительной операции
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Истина;
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = Истина;
	ПараметрыОжидания.ВыводитьСообщения = Истина;
	ПараметрыОжидания.Интервал = 2;
	ПараметрыОжидания.ОповещениеПользователя.Показать = Истина;
	ПараметрыОжидания.ОповещениеПользователя.Текст = НСтр("ru= 'Переименование свойства и корректировка шаблонов завершены'");

	// Подготовка аргументов для серверного вызова
	Аргументы = Новый Структура;
	Аргументы.Вставить("Свойство", Свойство);
	Аргументы.Вставить("НовоеИмя", НовоеИмя);
	Аргументы.Вставить("УникальныйИдентификатор", УникальныйИдентификатор);
	
	// Задание методов для выполнения длительной операции
	ФоновоеЗадание = НачатьПереименованиеСвойства(Аргументы);
	МетодЗавершения = Новый ОписаниеОповещения("ЗавершитьПереименованиеСвойства", ЭтотОбъект);
	
	// Запуск выполнения
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ФоновоеЗадание, МетодЗавершения, ПараметрыОжидания);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Начать изменение шаблонов наименований.
// 
// Параметры:
//  Аргументы - см. ДКА_КорректировкаДанных.ИзменениеАртикулов
// 
// Возвращаемое значение:
//  Структура - Начать изменение шаблонов наименований:
// * Статус - Строка -
// * ИдентификаторЗадания - УникальныйИдентификатор -
// * АдресРезультата - Строка -
// * КраткоеПредставлениеОшибки - Строка -
// * ПодробноеПредставлениеОшибки - Строка -
// * Сообщения - ФиксированныйМассив из Строка -
&НаСервереБезКонтекста
Функция НачатьПереименованиеСвойства(Аргументы)

	ИмяФункции = "ДКА_КорректировкаДанных.ПереименованиеСвойства";
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияФункции(Аргументы.УникальныйИдентификатор);

	Возврат ДлительныеОперации.ВыполнитьФункцию(ПараметрыВыполнения, ИмяФункции, Аргументы.Свойство, Аргументы.НовоеИмя);

КонецФункции

// Завершить изменение шаблонов наименований.
// 
// Параметры:
//  Результат - Структура - Результат:
//  * АдресРезультата - Строка
//  ДополнительныеПараметры - Структура - Дополнительные параметры
&НаКлиенте
Процедура ЗавершитьПереименованиеСвойства(Результат, ДополнительныеПараметры) Экспорт

	Если ТипЗнч(Результат) = Тип("Структура") Тогда
	
		Нечто = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти