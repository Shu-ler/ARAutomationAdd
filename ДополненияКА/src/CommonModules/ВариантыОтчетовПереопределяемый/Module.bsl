//
//	Филимонов И.В.
//		+7 913 240 81 77
//		+7 905 084 20 06 (Telegram)
//		https://github.com/Shu-ler
//		

//@skip-check doc-comment-collection-item-type
#Область ПрограммныйИнтерфейс

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов
&После("НастроитьВариантыОтчетов")
Процедура ДКА_НастроитьВариантыОтчетов(Настройки) Экспорт

	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.ДКА_Неликвиды);
	ВариантыОтчетов.НастроитьОтчетВМодулеМенеджера(Настройки, Метаданные.Отчеты.ДКА_ИзображенияНоменклатуры);

КонецПроцедуры

#КонецОбласти