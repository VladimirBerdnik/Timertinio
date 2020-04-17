import 'package:timertinio/modules/catalogue/data/CategoryModel.dart';

class CategoriesRepository {
  static List<Category> fetchAll() {
    return [
      Category(1, "Пряники", "Собственное производство", """Приглашаем к сотрудничеству
Ищем дистрибьюторов, оптовиков
Пряник производства г Челябинск
Доставка по городу, области, в регионы
Наличный, б/н расчёт
Наличие товара в любом объёме
Регистрационный номер декларации о соответствии :
ЕАЭС N RU Д-RU.АЖ37.В.112233/19
""", [
        "assets/categories/01-00.webp",
        "assets/categories/01-01.webp",
        "assets/categories/01-02.webp",
        "assets/categories/01-03.webp"
      ]),
      Category(2, "Печенье", "Более 700 видов", """Печенье более 700 видов
Каталоги на сайте 
Пряники в Челябинске
Цены по запросу 
Номер ват сап
          """, ["assets/categories/02-01.webp", "assets/categories/02-02.webp", "assets/categories/02-03.webp"]),
      Category(3, "Конфеты", "На любой вкус", """Печенье более 700 видов, Продукты питания 
Средняя Цена от 90-130 руб
На сайте можно посмотреть ассортимент в разделе каталоги 
Пряники в Челябинске
Цены можно узнать по номеру ват сап, цены по запросу""",
          ["assets/categories/03-00.webp", "assets/categories/03-01.webp", "assets/categories/03-02.webp"])
    ];
  }
}
