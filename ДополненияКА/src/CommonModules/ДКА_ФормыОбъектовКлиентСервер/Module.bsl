//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		

// @strict-types

#Область ПрограммныйИнтерфейс

// Возвращает набор имен реквизитов и групп для формы списка номенклатуры.
// 
// Возвращаемое значение:
//  Структура - Константы формы списка номенклатуры:
// * РеквизитПоказыватьЦеныИОстатки - Строка -
// * РеквизитВыбранныеВидыЦен - Строка -
// * РеквизитСписокЦены - Строка -
// * РеквизитВидЦены - Строка -
// * РеквизитЦена - Строка -
// * РеквизитСписокОстатки - Строка -
// * РеквизитОстаткиСклад - Строка -
// * РеквизитОстаткиСвободно - Строка -
// * РеквизитОстаткиВРезерве - Строка -
// * РеквизитОстаткиВПути - Строка -
// * РеквизитСписокЗапасы - Строка -
// * РеквизитЗапасыСклад - Строка -
// * РеквизитЗапасыMin - Строка -
// * РеквизитЗапасыMax - Строка -
// * РеквизитПрименимость - Строка -
// * РеквизитАдресКартинки - Строка -
// * ИмяГруппыЗаголовка - Строка -
// * ИмяПодменю - Строка -
// * ИмяПанели - Строка -
// * КлючОбъекта - Строка -
Функция КонстантыФормыСпискаНоменклатуры() Экспорт

	НаборКонстант = Новый Структура;

	НаборКонстант.Вставить("РеквизитПоказыватьЦеныИОстатки", "ДКА_РасширенныйПросмотр");

	НаборКонстант.Вставить("РеквизитВыбранныеВидыЦен", "ДКА_ВыбранныеВидыЦен");

	НаборКонстант.Вставить("РеквизитСписокЦены", "ДКА_Цены");
	НаборКонстант.Вставить("РеквизитВидЦены", "ВидЦены");
	НаборКонстант.Вставить("РеквизитЦена", "Цена");

	НаборКонстант.Вставить("РеквизитСписокОстатки", "ДКА_Остатки");
	НаборКонстант.Вставить("РеквизитОстаткиСклад", "Склад");
	НаборКонстант.Вставить("РеквизитОстаткиСвободно", "Свободно");
	НаборКонстант.Вставить("РеквизитОстаткиВРезерве", "ВРезерве");
	НаборКонстант.Вставить("РеквизитОстаткиВПути", "ВПути");

	НаборКонстант.Вставить("РеквизитСписокЗапасы", "ДКА_Запасы");
	НаборКонстант.Вставить("РеквизитЗапасыСклад", "ЗапасыСклад");
	НаборКонстант.Вставить("РеквизитЗапасыMin", "min");
	НаборКонстант.Вставить("РеквизитЗапасыMax", "max");

	НаборКонстант.Вставить("РеквизитПрименимость", "ДКА_Применимость");
	НаборКонстант.Вставить("РеквизитАдресКартинки", "ДКА_АдресКартинки");

	НаборКонстант.Вставить("ИмяГруппыЗаголовка", "ДКА_ПанельОстаткиЦеныЗаголовок");
	НаборКонстант.Вставить("ИмяПодменю", "ДКА_ПодменюФормыСпискаНоменклатуры");
	НаборКонстант.Вставить("ИмяПанели", "ДКА_ПанельОстаткиЦены");

	НаборКонстант.Вставить("КлючОбъекта", "ДКА_СписокНоменклатуры");

	Возврат НаборКонстант;

КонецФункции

#КонецОбласти
