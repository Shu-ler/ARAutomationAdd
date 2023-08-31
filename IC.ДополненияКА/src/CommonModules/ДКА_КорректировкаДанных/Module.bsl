// @strict-types
 
//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		
#Область ПрограммныйИнтерфейс

// Изменение шаблонов наименований.
// 
// Параметры:
//  Аргументы - Структура - Аргументы:
// * ИскомыйТекст - Строка - Искомый текст для замены
// * Замена - Строка - Текст замены
// * Свойство - ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения -
// * ТипНаименования - Строка -
// * УникальныйИдентификатор - УникальныйИдентификатор -
// 
// Возвращаемое значение:
//  Структура - Изменение шаблонов наименований:
// * Всего - Число - Количество обработанных элементов
// * Ошибки - Число - Количество ошибок
Функция ИзменениеШаблоновНаименований(Аргументы) Экспорт

	ВидОбъект = Справочники.ВидыНоменклатуры.ПустаяСсылка();

	Итоги = Новый Структура("Всего, Ошибки", 0, 0);
	Счетчик = 1;

	ИмяРеквизита = ?(Аргументы.ТипНаименования = "Рабочее",
					 "ШаблонРабочегоНаименованияНоменклатуры",
					 "ШаблонНаименованияДляПечатиНоменклатуры");

	Выборка = ВидыНоменклатуры();
	Итоги.Всего = Выборка.Количество();

	Пока Выборка.Следующий() Цикл

		ТекущийВидСсылка = Выборка.Ссылка;
		//@skip-check statement-type-change
		ВидОбъект = ТекущийВидСсылка.ПолучитьОбъект();
		//@skip-check invocation-parameter-type-intersect
		ВидОбъект[ИмяРеквизита] = СтрЗаменить(ВидОбъект[ИмяРеквизита], Аргументы.ИскомыйТекст, Аргументы.Замена);

		Попытка
			ВидОбъект.Записать();
			Счетчик = Счетчик + 1;
		Исключение
			Итоги.Ошибки = Итоги.Ошибки + 1;
		КонецПопытки;

		ДлительныеОперации.СообщитьПрогресс(Окр((Счетчик + Итоги.Ошибки) / Итоги.Всего, 0));

	КонецЦикла;

	Возврат Итоги;

КонецФункции

// Замена символов в артикулах номенклатуры.
// 
// Параметры:
//  Аргументы - Структура - Аргументы:
// * СтрокаПоиска - Строка - Искомый текст или символ для замены
// * СтрокаЗамены - Строка - Текст замены
// * Производитель - СправочникСсылка.Производители -
// * УникальныйИдентификатор - УникальныйИдентификатор -
// 
// Возвращаемое значение:
//  Структура - Изменение шаблонов наименований:
// * Всего - Число - Количество обработанных элементов
// * Ошибки - Число - Количество ошибок
Функция ИзменениеАртикулов(Аргументы) Экспорт

	НоменклатураОбъект = Справочники.ВидыНоменклатуры.ПустаяСсылка();

	Итоги = Новый Структура("Всего, Ошибки", 0, 0);
	Счетчик = 1;

	Выборка = НоменклатураПоПроизводителю(Аргументы.Производитель);
	Итоги.Всего = Выборка.Количество();

	Пока Выборка.Следующий() Цикл

		Если СтрНайти(Выборка.Артикул, Аргументы.СтрокаПоиска) > 0 Тогда

			НоменклатураСсылка = Выборка.Ссылка;
			//@skip-check statement-type-change
			НоменклатураОбъект = НоменклатураСсылка.ПолучитьОбъект();
			НоменклатураОбъект.Артикул = СтрЗаменить(НоменклатураОбъект.Артикул,
													 Аргументы.СтрокаПоиска,
													 Аргументы.СтрокаЗамены);

			Попытка
				НоменклатураОбъект.Записать();
			Исключение
				Итоги.Ошибки = Итоги.Ошибки + 1;
			КонецПопытки;

		КонецЕсли;

		Счетчик = Счетчик + 1;

		ДлительныеОперации.СообщитьПрогресс(Окр(Счетчик / Итоги.Всего * 100, 0));

	КонецЦикла;

	Возврат Итоги;

КонецФункции

// Переименование свойства.
// 
// Параметры:
//  Свойство - ПланВидовХарактеристикСсылка.ДополнительныеРеквизитыИСведения - Свойство
//  НовоеИмя - Строка - Новое имя
// 
// Возвращаемое значение:
//  Булево -  Успешность переименования
Функция ПереименованиеСвойства(Свойство, НовоеИмя) Экспорт

	Успешно = Истина;

	ИмяСвойства = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Свойство, "Имя");
	Сигнатура = СтрШаблон("[{ДР.%1}]", ИмяСвойства);
	Замена = СтрШаблон("[{ДР.%1}]", НовоеИмя);

	Виды = ВидыСоСвойствомВШаблоне(ИмяСвойства);

	НачатьТранзакцию();
	
	// Замена имени свойства
	СвойствоОбъект = Свойство.ПолучитьОбъект();
	СвойствоОбъект.Имя = НовоеИмя;

	Попытка
		СвойствоОбъект.Записать();
	Исключение
		ОтменитьТранзакцию();
		Успешно = Ложь;
	КонецПопытки;
	
	// Замена имени свойства в шаблонах наименования номенклатуры
	Если Успешно Тогда

		Для Каждого Вид Из Виды Цикл

			ВидОбъект = Вид.ПолучитьОбъект();
			ВидОбъект.ШаблонРабочегоНаименованияНоменклатуры = СтрЗаменить(ВидОбъект.ШаблонРабочегоНаименованияНоменклатуры,
																		   Сигнатура,
																		   Замена);
			ВидОбъект.ШаблонНаименованияДляПечатиНоменклатуры = СтрЗаменить(ВидОбъект.ШаблонНаименованияДляПечатиНоменклатуры,
																		   Сигнатура,
																		   Замена);
			Попытка
				ВидОбъект.Записать();
			Исключение
				ОтменитьТранзакцию();
				Успешно = Ложь;
			КонецПопытки;
			
		КонецЦикла;

	КонецЕсли;
	
	// Фиксация транзакции
	Если ТранзакцияАктивна() Тогда
		ЗафиксироватьТранзакцию();
	КонецЕсли;

	Возврат Успешно;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает выборку видов номенклатуры
// 
// Возвращаемое значение:
//  ВыборкаИзРезультатаЗапроса:
//		* Ссылка - СправочникСсылка.ВидыНоменклатуры - Вид номенклатуры
Функция ВидыНоменклатуры()

	ТекстЗапроса = "ВЫБРАТЬ
				   |	ВидыНоменклатуры.Ссылка КАК Ссылка
				   |ИЗ
				   |	Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
				   |ГДЕ
				   |	ВидыНоменклатуры.ПометкаУдаления = ЛОЖЬ
				   |	И ВидыНоменклатуры.ЭтоГруппа = ЛОЖЬ";
	Запрос = Новый Запрос(ТекстЗапроса);

	Выборка = Запрос.Выполнить().Выбрать();

	Возврат Выборка

КонецФункции

// Возвращает выборку номенклатуры по производителю.
// 
// Параметры:
//  Производитель - СправочникСсылка.Производители -  Производитель
// 
// Возвращаемое значение:
//  ВыборкаИзРезультатаЗапроса:
//	* Ссылка - СправочникСсылка.Номенклатура - Номенклатура
//	* Артикул - Строка - Артикул
Функция НоменклатураПоПроизводителю(Производитель)

	ТекстЗапроса = "ВЫБРАТЬ
				   |	Номенклатура.Ссылка КАК Ссылка,
				   |	Номенклатура.Артикул КАК Артикул
				   |ИЗ
				   |	Справочник.Номенклатура КАК Номенклатура
				   |ГДЕ
				   |	Номенклатура.Производитель = &Производитель
				   |	И Номенклатура.ПометкаУдаления = ЛОЖЬ";
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Производитель", Производитель);

	Выборка = Запрос.Выполнить().Выбрать();

	Возврат Выборка;

КонецФункции

// Возвращает массив видов номенклатуры с использованием свойства в рабочем наименовании или в наименовании для печати
// 
// Параметры:
//  ИмяСвойства - Строка -  Имя свойства
// 
// Возвращаемое значение:
//  Массив из СправочникСсылка.ВидыНоменклатуры -  Виды со свойством в шаблоне
Функция ВидыСоСвойствомВШаблоне(ИмяСвойства)

	Виды = Новый Массив;
	Сигнатура = СтрШаблон("[{ДР.%1}]", ИмяСвойства);

	ТекстЗапроса = "ВЫБРАТЬ
	|	ВидыНоменклатуры.Ссылка КАК Ссылка,
	|	ВидыНоменклатуры.ШаблонНаименованияДляПечатиНоменклатуры КАК ШаблонНаименованияДляПечати,
	|	ВидыНоменклатуры.ШаблонРабочегоНаименованияНоменклатуры КАК ШаблонРабочегоНаименования
	|ИЗ
	|	Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|ГДЕ
	|	ВидыНоменклатуры.ШаблонНаименованияДляПечатиНоменклатуры НЕ ПОДОБНО """"
	|	И ВидыНоменклатуры.ШаблонРабочегоНаименованияНоменклатуры НЕ ПОДОБНО """"";

	Запрос = Новый Запрос(ТекстЗапроса);

	Выборка = Запрос.Выполнить().Выбрать();
	ААА = Выборка.Количество();

	Пока Выборка.Следующий() Цикл

		Если СтрНайти(Выборка.ШаблонНаименованияДляПечати, Сигнатура) > 0
			 Или СтрНайти(Выборка.ШаблонРабочегоНаименования, Сигнатура) > 0 Тогда
			Виды.Добавить(Выборка.Ссылка);
		КонецЕсли;

	КонецЦикла;

	Возврат Виды;

КонецФункции

#КонецОбласти