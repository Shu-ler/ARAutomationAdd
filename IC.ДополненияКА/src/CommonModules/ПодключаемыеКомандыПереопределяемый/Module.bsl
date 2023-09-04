//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		
#Область ПрограммныйИнтерфейс

// см. ПодключаемыеКомандыПереопределяемый.ПриОпределенииВидовПодключаемыхКоманд 
&После("ПриОпределенииВидовПодключаемыхКоманд")
Процедура ДКА_ПриОпределенииВидовПодключаемыхКоманд(ВидыПодключаемыхКоманд) Экспорт

	ДКА_Вид = ВидыПодключаемыхКоманд.Добавить();
	ДКА_Вид.Имя = "ДКА_КнопкиФормыСписка";
	ДКА_Вид.ИмяПодменю = "ДКА_ПодменюФормыСпискаНоменклатуры";
	ДКА_Вид.Заголовок = НСтр("ru = 'Остатки и цены'");
	ДКА_Вид.Картинка = БиблиотекаКартинок.РедактироватьВДиалоге;
	ДКА_Вид.Отображение = ОтображениеКнопки.Картинка;

КонецПроцедуры

// см. ПодключаемыеКомандыПереопределяемый.ПриОпределенииКомандПодключенныхКОбъекту 
&После("ПриОпределенииКомандПодключенныхКОбъекту")
Процедура ДКА_ПриОпределенииКомандПодключенныхКОбъекту(НастройкиФормы, Источники, ПодключенныеОтчетыИОбработки, Команды) Экспорт

		// Команда создания нового документа установки цен номенклатуры
		ДКА_Команда = Команды.Добавить();
		ДКА_Команда.Вид = "ДКА_КнопкиФормыСписка";
		ДКА_Команда.ТипПараметра = Новый ОписаниеТипов("СправочникСсылка.Номенклатура");
		ДКА_Команда.Назначение = "ДляСписка";
		ДКА_Команда.Обработчик = "ДКА_ПодключаемыеКомандыКлиент.УстановкаЦенНовыйДокумент";
		ДКА_Команда.Представление = НСтр("ru= 'Новый документ установки цен номенклатуры'");
		ДКА_Команда.РежимЗаписи = "НеЗаписывать";
		ДКА_Команда.ИзменяетВыбранныеОбъекты = Истина;
		ДКА_Команда.Порядок = 6;
		ДКА_Команда.Важность = "Важное";
		ДКА_Команда.МножественныйВыбор = Истина;
		ДКА_Команда.Картинка = БиблиотекаКартинок.СоздатьЭлементСписка;
		ДКА_Команда.Идентификатор = "ДКА_НовыйДокументУстановкиЦенНоменклатуры";
		ДКА_Команда.ТолькоВоВсехДействиях = Ложь;

		// Команда редактирования последнего документа установки цен номенклатуры
		ДКА_Команда = Команды.Добавить();
		ДКА_Команда.Вид = "ДКА_КнопкиФормыСписка";
		ДКА_Команда.ТипПараметра = Новый ОписаниеТипов("СправочникСсылка.Номенклатура");
		ДКА_Команда.Назначение = "ДляСписка";
		ДКА_Команда.Обработчик = "ДКА_ПодключаемыеКомандыКлиент.ИзменениеПоследнейУстановкиЦен";
		ДКА_Команда.Представление = НСтр("ru= 'Редактирование последнего документа установки цен номенклатуры'");
		ДКА_Команда.РежимЗаписи = "НеЗаписывать";
		ДКА_Команда.ИзменяетВыбранныеОбъекты = Истина;
		ДКА_Команда.Порядок = 7;
		ДКА_Команда.Важность = "Важное";
		ДКА_Команда.МножественныйВыбор = Ложь;
		ДКА_Команда.Картинка = БиблиотекаКартинок.Изменить;
		ДКА_Команда.Идентификатор = "ДКА_РедактированиеДокументаУстановкиЦенНоменклатуры";
		ДКА_Команда.ТолькоВоВсехДействиях = Ложь;

		// Команда настройки панели
		ДКА_Команда = Команды.Добавить();
		ДКА_Команда.Вид = "ДКА_КнопкиФормыСписка";
		ДКА_Команда.ТипПараметра = Новый ОписаниеТипов("СправочникСсылка.Номенклатура");
		ДКА_Команда.Назначение = "ДляСписка";
		ДКА_Команда.Обработчик = "ДКА_ПодключаемыеКомандыКлиент.Настройки";
		ДКА_Команда.Представление = НСтр("ru= 'Настройки панели расширенной информации'");
		ДКА_Команда.РежимЗаписи = "НеЗаписывать";
		ДКА_Команда.ИзменяетВыбранныеОбъекты = Ложь;
		ДКА_Команда.Порядок = 8;
		ДКА_Команда.Важность = "Важное";
		ДКА_Команда.МножественныйВыбор = Ложь;
		ДКА_Команда.Картинка = БиблиотекаКартинок.Параметры;
		ДКА_Команда.Идентификатор = "ДКА_НастройкиПанелиРасширеннойИнформации";
		ДКА_Команда.ТолькоВоВсехДействиях = Ложь;

		// Команда редактирования min-max
		ДКА_Команда = Команды.Добавить();
		ДКА_Команда.Вид = "ДКА_КнопкиФормыСписка";
		ДКА_Команда.ТипПараметра = Новый ОписаниеТипов("СправочникСсылка.Номенклатура");
		ДКА_Команда.Назначение = "ДляСписка";
		ДКА_Команда.Обработчик = "ДКА_ПодключаемыеКомандыКлиент.БыстраяУстановкаМинМакс";
		ДКА_Команда.Представление = НСтр("ru= 'Быстрая установка min-max'");
		ДКА_Команда.РежимЗаписи = "НеЗаписывать";
		ДКА_Команда.ИзменяетВыбранныеОбъекты = Ложь;
		ДКА_Команда.Порядок = 8;
		ДКА_Команда.Важность = "Важное";
		ДКА_Команда.МножественныйВыбор = Ложь;
		ДКА_Команда.Картинка = БиблиотекаКартинок.Максимум;
		ДКА_Команда.Идентификатор = "ДКА_БыстраяУстановкаМинМакс";
		ДКА_Команда.ТолькоВоВсехДействиях = Ложь;
		
КонецПроцедуры

#КонецОбласти
