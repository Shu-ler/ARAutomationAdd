//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		
#Область СлужебныйПрограммныйИнтерфейс

Процедура ПриСозданииНаСервере_НоменклатураФормаЭлемента(Форма) Экспорт
	Возврат;
КонецПроцедуры

Процедура ПриСозданииНаСервере_НоменклатураФормаСписка(Форма) Экспорт

	// Создание реквизитов формы
	ДобавляемыеРеквизиты = ДобавляемыеРеквизиты();
	Форма.ИзменитьРеквизиты(ДобавляемыеРеквизиты);

	// Чтение сохраненных настроек формы списка
	УстановитьВидимостьПанели(Форма);

	// Чтение настроек панели расширенного просмотра
	НастройкиПанели = НастройкиПанели();

	// Заполнение реквизита ДКА_ВыбранныеВидыЦен
	ЗаполнитьВыбранныеВидыЦен(Форма, НастройкиПанели);

	// Создание элементов формы
	СоздатьЭлементыФормы(Форма, НастройкиПанели);

КонецПроцедуры

Процедура ПриСозданииНаСервере_УстановкаЦенНоменклатуры(Форма) Экспорт

	Если Форма.Параметры.Свойство("Товары") Тогда

		Для Каждого Эл Из Форма.Параметры.Товары Цикл
			НовыйТовар = Форма.Объект.Товары.Добавить();
			НовыйТовар.Номенклатура = Эл;
		КонецЦикла;

		Форма.ИспользуетсяЦенообразование25 = Ложь;
		Форма.ВыбранныеЦеныИзменены = Истина;

	КонецЕсли;

КонецПроцедуры

Процедура ПереместитьДополнительныйРеквизит(Форма, ДополнительныйРеквизит, ЦелеваяГруппа, ТолькоПросмотр = Ложь) Экспорт

	СписокСвойств = Форма.Свойства_ОписаниеДополнительныхРеквизитов;

	ОписанияДополнительныхРеквизитов = СписокСвойств.НайтиСтроки(Новый Структура("Свойство", ДополнительныйРеквизит));

	Если ОписанияДополнительныхРеквизитов.Количество() > 0 Тогда

		ИскомыйЭлементИмя = ОписанияДополнительныхРеквизитов[0].ИмяРеквизитаЗначение;
		ИскомыйЭлемент = Форма.Элементы[ИскомыйЭлементИмя];
//		ИскомыйЭлемент.ТолькоПросмотр = ТолькоПросмотр;
		ИскомыйЭлемент.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Верх;

		Форма.Элементы.Переместить(ИскомыйЭлемент, ЦелеваяГруппа);

	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДобавляемыеРеквизиты()

	Имена = ДКА_ФормыОбъектовКлиентСервер.КонстантыФормыСпискаНоменклатуры();
	КоллекцияРеквизитов = Новый Массив;

	// ДКА_РасширенныйПросмотр (булево), флаг отображения панели
	ПоказыватьЦеныИОстатки = Новый РеквизитФормы(Имена.РеквизитПоказыватьЦеныИОстатки,
												 Новый ОписаниеТипов("Булево"),
												 ,
												 ,
												 Истина);
	// ДКА_ВыбранныеВидыЦен, список значений, выбранные виды цен
	СписокВыбранныеВидыЦен = Новый РеквизитФормы(Имена.РеквизитВыбранныеВидыЦен, Новый ОписаниеТипов("СписокЗначений")); 											
											
	// ДКА_Цены, таблица значений, виды цен и цены
	СписокЦены = Новый РеквизитФормы(Имена.РеквизитСписокЦены, Новый ОписаниеТипов("ТаблицаЗначений"));
	СписокВидЦены = Новый РеквизитФормы(Имена.РеквизитВидЦены,
										Новый ОписаниеТипов("СправочникСсылка.ВидыЦен"),
										Имена.РеквизитСписокЦены);
	СписокЦена = Новый РеквизитФормы(Имена.РеквизитЦена,
									 ОбщегоНазначения.ОписаниеТипаЧисло(15, 2),
									 Имена.РеквизитСписокЦены);
	// ДКА_Остатки, таблица значений, остатки на складах
	СписокОстатки = Новый РеквизитФормы(Имена.РеквизитСписокОстатки, Новый ОписаниеТипов("ТаблицаЗначений"));
	СписокОстаткиСклад = Новый РеквизитФормы(Имена.РеквизитОстаткиСклад,
											 Новый ОписаниеТипов("СправочникСсылка.Склады"),
											 Имена.РеквизитСписокОстатки);
	СписокОстаткиСвободно = Новый РеквизитФормы(Имена.РеквизитОстаткиСвободно,
												ОбщегоНазначения.ОписаниеТипаЧисло(15, 3),
												Имена.РеквизитСписокОстатки);
	СписокОстаткиВРезерве = Новый РеквизитФормы(Имена.РеквизитОстаткиВРезерве,
												ОбщегоНазначения.ОписаниеТипаЧисло(15, 3),
												Имена.РеквизитСписокОстатки);
	СписокОстаткиВПути = Новый РеквизитФормы(Имена.РеквизитОстаткиВПути,
											 ОбщегоНазначения.ОписаниеТипаЧисло(15, 3),
											 Имена.РеквизитСписокОстатки);
	// ДКА_Запасы, таблица значений, min/max
	СписокЗапасы = Новый РеквизитФормы(Имена.РеквизитСписокЗапасы, Новый ОписаниеТипов("ТаблицаЗначений"));
	СписокЗапасыСклад = Новый РеквизитФормы(Имена.РеквизитЗапасыСклад,
											Новый ОписаниеТипов("СправочникСсылка.Склады"),
											Имена.РеквизитСписокЗапасы);
	СписокЗапасыMin = Новый РеквизитФормы(Имена.РеквизитЗапасыMin,
										  ОбщегоНазначения.ОписаниеТипаЧисло(10, 0),
										  Имена.РеквизитСписокЗапасы);
	СписокЗапасыMax = Новый РеквизитФормы(Имена.РеквизитЗапасыMax,
										  ОбщегоНазначения.ОписаниеТипаЧисло(10, 0),
										  Имена.РеквизитСписокЗапасы);
	// ДКА_Применимость
	Применимость = Новый РеквизитФормы(Имена.РеквизитПрименимость, ОбщегоНазначения.ОписаниеТипаСтрока(1024));

	// ДКА_АдресКартинки
	АдресКартинки = Новый РеквизитФормы(Имена.РеквизитАдресКартинки, ОбщегоНазначения.ОписаниеТипаСтрока(0));
	
	// Добавление реквизитов формы
	КоллекцияРеквизитов.Добавить(ПоказыватьЦеныИОстатки);

	КоллекцияРеквизитов.Добавить(СписокВыбранныеВидыЦен);

	КоллекцияРеквизитов.Добавить(СписокЦены);
	КоллекцияРеквизитов.Добавить(СписокВидЦены);
	КоллекцияРеквизитов.Добавить(СписокЦена);

	КоллекцияРеквизитов.Добавить(СписокОстатки);
	КоллекцияРеквизитов.Добавить(СписокОстаткиСклад);
	КоллекцияРеквизитов.Добавить(СписокОстаткиСвободно);
	КоллекцияРеквизитов.Добавить(СписокОстаткиВРезерве);
	КоллекцияРеквизитов.Добавить(СписокОстаткиВПути);

	КоллекцияРеквизитов.Добавить(СписокЗапасы);
	КоллекцияРеквизитов.Добавить(СписокЗапасыСклад);
	КоллекцияРеквизитов.Добавить(СписокЗапасыMin);
	КоллекцияРеквизитов.Добавить(СписокЗапасыMax);

	КоллекцияРеквизитов.Добавить(Применимость);
	КоллекцияРеквизитов.Добавить(АдресКартинки);

	Возврат КоллекцияРеквизитов;

КонецФункции

// Устанавливает видимость панели в зависимости от значения сохраненного реквизита ДКА_РасширенныйПросмотр
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма
Процедура УстановитьВидимостьПанели(Форма)

	Имена = ДКА_ФормыОбъектовКлиентСервер.КонстантыФормыСпискаНоменклатуры();

	// Установка видимости в Истина - для первого открытия списка с панелью
	Форма[Имена.РеквизитПоказыватьЦеныИОстатки] = Истина;
	
	// Чтение настроек формы списка номенклатуры
	Настройки = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(Форма.КодФормы, "");

	// Установка видимости по результату получения настроек
	Если Настройки <> Неопределено И Настройки.Свойство(Имена.РеквизитПоказыватьЦеныИОстатки) Тогда
		Форма[Имена.РеквизитПоказыватьЦеныИОстатки] = Настройки[Имена.РеквизитПоказыватьЦеныИОстатки];
	КонецЕсли;

КонецПроцедуры

// Возвращает настройки панели.
// Если настройки не заданы - создает настройки по умолчанию.
// 
// Возвращаемое значение:
//  Произвольный, Дата, Неопределено, Структура - Настройки панели:
// * ВидыЦен - СписокЗначений Из СправочникСсылка.ВидыЦен - Выбранные ыиды цен номенклатуры
// * ПоказатьЗапасы - Булево -
// * ПоказатьПрименимость - Булево -
// * ПоказатьКартинку - Булево -
Функция НастройкиПанели()

	Имена = ДКА_ФормыОбъектовКлиентСервер.КонстантыФормыСпискаНоменклатуры();

	НастройкиПанели = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить(Имена.КлючОбъекта, "");

	Если НастройкиПанели = Неопределено Или Не НастройкиПанели.Свойство("ВидыЦен") Тогда // TODO исправить в продакшине
		НастройкиПанели = НастройкиПанелиПоУмолчанию(Имена.КлючОбъекта);
	КонецЕсли;

	Возврат НастройкиПанели

КонецФункции

// Заполнение реквизита ВыбранныеВидыЦен
// 
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - Форма
//  НастройкиПанели - см. НастройкиПанели
Процедура ЗаполнитьВыбранныеВидыЦен(Форма, НастройкиПанели)
	
	// Разыменования
	Имена = ДКА_ФормыОбъектовКлиентСервер.КонстантыФормыСпискаНоменклатуры();
	ВидыЦенФорма = Форма[Имена.РеквизитВыбранныеВидыЦен];
	ВидыЦенНастройки = НастройкиПанели.ВидыЦен;
	
	// Очистка списка
	ВидыЦенФорма.Очистить();
	
	Для Каждого Эл Из ВидыЦенНастройки Цикл
		НовыйВид = ВидыЦенФорма.Добавить();
		НовыйВид.Значение = Эл.Значение;
	КонецЦикла;
	
КонецПроцедуры

Процедура СоздатьЭлементыФормы(Форма, НастройкиПанели)

	// Разыменование и константы
	Элементы = Форма.Элементы;
	Имена = ДКА_ФормыОбъектовКлиентСервер.КонстантыФормыСпискаНоменклатуры();

	// Добавление группы (вертикальная группа без отображения на форме)
	ГруппаФормы = Элементы.Вставить(Имена.ИмяПанели,
									Тип("ГруппаФормы"),
									Элементы.ГруппаФормаТаблицы,
									Элементы.ГруппаПанельКатегорий);
	ГруппаФормы.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаФормы.ОтображатьЗаголовок = Ложь;
	ГруппаФормы.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	ГруппаФормы.Ширина = 29;

	ГруппаФормы.Видимость = Форма[Имена.РеквизитПоказыватьЦеныИОстатки];
	
	// Добавление "Командной панели"
	ГруппаЗаголовок = Элементы.Вставить(Имена.ИмяГруппыЗаголовка, Тип("ГруппаФормы"), ГруппаФормы);
	ГруппаЗаголовок.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаЗаголовок.ОтображатьЗаголовок = Ложь;
	ГруппаЗаголовок.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
//	ГруппаЗаголовок.Объединенная = Ложь;
	
	// Добавление надписи "Цены"
	ДекорацияЦены = Элементы.Добавить("ДКА_Цена", Тип("ДекорацияФормы"), ГруппаЗаголовок);
	ДекорацияЦены.Заголовок = "Цены";
	ДекорацияЦены.Ширина = 18;
	ДекорацияЦены.Шрифт = ШрифтыСтиля.ШрифтКнопкиВыполненияЗадачиОбычный;
	
	
	// Перенос командной панели
	Подменю = Элементы[Имена.ИмяПодменю];
	Элементы.Переместить(Подменю, ГруппаЗаголовок);
	Подменю.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента.Право;
	Подменю.Ширина = 20;
	Подменю.РастягиватьПоГоризонтали = Истина;

	// Удаление подменю "Еще"	
	РодительКоманд = Элементы[Имена.ИмяПодменю + "Важное"];
	Для Каждого Эл Из РодительКоманд.ПодчиненныеЭлементы Цикл
		Эл.ПоложениеВКоманднойПанели = ПоложениеКнопкиВКоманднойПанели.ВКоманднойПанели;
		Эл.Отображение = ОтображениеКнопки.Картинка;
	КонецЦикла;
	
	// Добавление таблицы формы ДКА_Цены
	ТаблицаЦены = Элементы.Добавить(Имена.РеквизитСписокЦены, Тип("ТаблицаФормы"), ГруппаФормы);
	ТаблицаЦены.ПутьКДанным = Имена.РеквизитСписокЦены;
	НастроитьТаблицуЦены(ТаблицаЦены);

	КолонкаВидЦены = Элементы.Добавить(Имена.РеквизитВидЦены, Тип("ПолеФормы"), ТаблицаЦены);
	КолонкаВидЦены.ПутьКДанным = Имена.РеквизитСписокЦены + "." + Имена.РеквизитВидЦены;
	КолонкаВидЦены.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;

	КолонкаЦена = Элементы.Добавить(Имена.РеквизитЦена, Тип("ПолеФормы"), ТаблицаЦены);
	КолонкаЦена.ПутьКДанным = Имена.РеквизитСписокЦены + "." + Имена.РеквизитЦена;
	КолонкаЦена.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;

	// Добавление таблицы формы ДКА_Остатки
	ТаблицаОстатки = Элементы.Добавить(Имена.РеквизитСписокОстатки, Тип("ТаблицаФормы"), ГруппаФормы);
	ТаблицаОстатки.ПутьКДанным = Имена.РеквизитСписокОстатки;
	НастроитьТаблицуОстатки(ТаблицаОстатки);

	КолонкаОстаткиСклад = Элементы.Добавить(Имена.РеквизитОстаткиСклад, Тип("ПолеФормы"), ТаблицаОстатки);
	КолонкаОстаткиСклад.ПутьКДанным = Имена.РеквизитСписокОстатки + "." + Имена.РеквизитОстаткиСклад;
	КолонкаОстаткиСклад.Ширина = 10;

	КолонкаОстаткиСвободно = Элементы.Добавить(Имена.РеквизитОстаткиСвободно, Тип("ПолеФормы"), ТаблицаОстатки);
	КолонкаОстаткиСвободно.ПутьКДанным = Имена.РеквизитСписокОстатки + "." + Имена.РеквизитОстаткиСвободно;
	КолонкаОстаткиСвободно.Ширина = 6;

	КолонкаОстаткиВРезерве = Элементы.Добавить(Имена.РеквизитОстаткиВРезерве, Тип("ПолеФормы"), ТаблицаОстатки);
	КолонкаОстаткиВРезерве.ПутьКДанным = Имена.РеквизитСписокОстатки + "." + Имена.РеквизитОстаткиВРезерве;
	КолонкаОстаткиВРезерве.Заголовок = НСтр("ru = 'резерв'");
	КолонкаОстаткиВРезерве.Ширина = 6;

	КолонкаОстаткиВПути = Элементы.Добавить(Имена.РеквизитОстаткиВПути, Тип("ПолеФормы"), ТаблицаОстатки);
	КолонкаОстаткиВПути.ПутьКДанным = Имена.РеквизитСписокОстатки + "." + Имена.РеквизитОстаткиВПути;
	КолонкаОстаткиВПути.Заголовок = НСтр("ru = 'в пути'");
	КолонкаОстаткиВПути.Ширина = 6;

	// Добавление таблицы формы ДКА_Запасы
	ТаблицаЗапасы = Элементы.Добавить(Имена.РеквизитСписокЗапасы, Тип("ТаблицаФормы"), ГруппаФормы);
	ТаблицаЗапасы.ПутьКДанным = Имена.РеквизитСписокЗапасы;
	НастроитьТаблицуЗапасы(ТаблицаЗапасы);

	ТаблицаЗапасы.Видимость = НастройкиПанели.ПоказатьЗапасы;

	КолонкаЗапасыСклад = Элементы.Добавить(Имена.РеквизитЗапасыСклад, Тип("ПолеФормы"), ТаблицаЗапасы);
	КолонкаЗапасыСклад.ПутьКДанным = Имена.РеквизитСписокЗапасы + "." + Имена.РеквизитЗапасыСклад;
	КолонкаЗапасыСклад.Заголовок = НСтр("ru = 'склад'");
	КолонкаЗапасыСклад.Ширина = 10;

	КолонкаЗапасыMin = Элементы.Добавить(Имена.РеквизитЗапасыMin, Тип("ПолеФормы"), ТаблицаЗапасы);
	КолонкаЗапасыMin.ПутьКДанным = Имена.РеквизитСписокЗапасы + "." + Имена.РеквизитЗапасыMin;
	КолонкаЗапасыMin.Заголовок = НСтр("ru = 'min'");
	КолонкаЗапасыMin.Ширина = 6;

	КолонкаЗапасыMax = Элементы.Добавить(Имена.РеквизитЗапасыMax, Тип("ПолеФормы"), ТаблицаЗапасы);
	КолонкаЗапасыMax.ПутьКДанным = Имена.РеквизитСписокЗапасы + "." + Имена.РеквизитЗапасыMax;
	КолонкаЗапасыMax.Заголовок = НСтр("ru = 'max'");
	КолонкаЗапасыMax.Ширина = 6;

	// Добавление многострочного поля Применимость
	ПолеПрименимость = Элементы.Добавить(Имена.РеквизитПрименимость, Тип("ПолеФормы"), ГруппаФормы);
	ПолеПрименимость.ПутьКДанным = Имена.РеквизитПрименимость;
	ПолеПрименимость.Заголовок = "Применимость";
	ПолеПрименимость.ШрифтЗаголовка = ШрифтыСтиля.ШрифтКнопкиВыполненияЗадачиОбычный;
	ПолеПрименимость.Высота = 3;

	ПолеПрименимость.Видимость = НастройкиПанели.ПоказатьПрименимость;
	
	// Добавление картинки
	ПолеКартинка = Элементы.Добавить(Имена.РеквизитАдресКартинки, Тип("ПолеФормы"), ГруппаФормы);
	ПолеКартинка.Вид = ВидПоляФормы.ПолеКартинки;
	ПолеКартинка.ПутьКДанным = Имена.РеквизитАдресКартинки;
	ПолеКартинка.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	ПолеКартинка.РазмерКартинки = РазмерКартинки.Пропорционально;
	ПолеКартинка.ТекстНевыбраннойКартинки = НСтр("ru = 'Картинка не задана'");
	ПолеКартинка.Подсказка = НСтр("ru = 'Основная картинка номенклатуры'");
	ПолеКартинка.Высота = 6;
	ПолеКартинка.Видимость = НастройкиПанели.ПоказатьКартинку;

КонецПроцедуры

// Создает, сохраняет и возвращает настройки по умолчанию
// 
// Параметры:
//  КлючОбъекта - Строка - Ключ объекта
// 
// Возвращаемое значение:
//  Структура - Настройки детально по умолчанию:
// * ВидыЦен - СписокЗначений из СправочникСсылка.ВидыЦен -
// * ПоказатьЗапасы - Булево -
// * ПоказатьПрименимость - Булево -
// * ПоказатьКартинку - Булево -
Функция НастройкиПанелиПоУмолчанию(КлючОбъекта)

	ВидыЦен = Новый СписокЗначений;
	ВидыЦен.Добавить(Справочники.ВидыЦен.НайтиПоНаименованию("Розничная"), Истина);
	ВидыЦен.Добавить(Справочники.ВидыЦен.НайтиПоНаименованию("Мелкоптовая"), Истина);
	ВидыЦен.Добавить(Справочники.ВидыЦен.НайтиПоНаименованию("Оптовая"), Истина);
	ВидыЦен.Добавить(Справочники.ВидыЦен.НайтиПоНаименованию("Крупнооптовая"), Истина);

	Настройки = Новый Структура;
	Настройки.Вставить("ВидыЦен", ВидыЦен);
	Настройки.Вставить("ПоказатьЗапасы", Ложь);
	Настройки.Вставить("ПоказатьПрименимость", Истина);
	Настройки.Вставить("ПоказатьКартинку", Истина);

	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить(КлючОбъекта, "", Настройки);

	Возврат Настройки;

КонецФункции

// Настройка таблицы ТаблицаЦены.
// 
// Параметры:
//  ТаблицаЦены - ТаблицаФормы - Таблица ТаблицаЦены
Процедура НастроитьТаблицуЦены(ТаблицаЦены)

	ТаблицаЦены.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
	ТаблицаЦены.АвтоМаксимальнаяВысота = Истина;
	ТаблицаЦены.ВысотаВСтрокахТаблицы = 6;
	ТаблицаЦены.АвтоМаксимальнаяВысотаВСтрокахТаблицы = Истина;
	ТаблицаЦены.ВертикальнаяПолосаПрокрутки = ИспользованиеПолосыПрокрутки.НеИспользовать;
	ТаблицаЦены.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Нет;
	ТаблицаЦены.ЧередованиеЦветовСтрок = Истина;
	ТаблицаЦены.Шапка = Ложь;
	ТаблицаЦены.ТолькоПросмотр = Истина;
	ТаблицаЦены.Ширина = 28;
	ТаблицаЦены.Подсказка = "Цены номенклатуры.
							|Возможно настроить виды отображаемых цен";
КонецПроцедуры

// Настройка таблицы ТаблицаОстатки.
// 
// Параметры:
//  ТаблицаОстатки - ТаблицаФормы - Таблица ТаблицаОстатки
Процедура НастроитьТаблицуОстатки(ТаблицаОстатки)

	ТаблицаОстатки.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
	ТаблицаОстатки.АвтоМаксимальнаяВысота = Истина;
	ТаблицаОстатки.ВысотаВСтрокахТаблицы = 6;
	ТаблицаОстатки.АвтоМаксимальнаяВысотаВСтрокахТаблицы = Истина;
	ТаблицаОстатки.ВертикальнаяПолосаПрокрутки = ИспользованиеПолосыПрокрутки.НеИспользовать;
	ТаблицаОстатки.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Верх;
	ТаблицаОстатки.Заголовок = НСтр("ru = 'Остатки и доступность'");
	ТаблицаОстатки.ШрифтЗаголовка = ШрифтыСтиля.ШрифтКнопкиВыполненияЗадачиОбычный;
	ТаблицаОстатки.ЧередованиеЦветовСтрок = Истина;
	ТаблицаОстатки.ТолькоПросмотр = Истина;
	ТаблицаОстатки.Ширина = 28;

КонецПроцедуры

// Настройка таблицы ТаблицаЗапасы.
// 
// Параметры:
//  ТаблицаЗапасы - ТаблицаФормы - Таблица ТаблицаЗапасы
Процедура НастроитьТаблицуЗапасы(ТаблицаЗапасы)

	ТаблицаЗапасы.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
	ТаблицаЗапасы.АвтоМаксимальнаяВысота = Истина;
	ТаблицаЗапасы.ВысотаВСтрокахТаблицы = 4;
	ТаблицаЗапасы.АвтоМаксимальнаяВысотаВСтрокахТаблицы = Истина;
	ТаблицаЗапасы.ВертикальнаяПолосаПрокрутки = ИспользованиеПолосыПрокрутки.НеИспользовать;
	ТаблицаЗапасы.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Верх;
	ТаблицаЗапасы.Заголовок = НСтр("ru = 'Поддержание запасов'");
	ТаблицаЗапасы.ШрифтЗаголовка = ШрифтыСтиля.ШрифтКнопкиВыполненияЗадачиОбычный;
	ТаблицаЗапасы.ЧередованиеЦветовСтрок = Истина;
	ТаблицаЗапасы.ТолькоПросмотр = Истина;
	ТаблицаЗапасы.Ширина = 28;

КонецПроцедуры

#КонецОбласти