## madShop
Кроссплатформенное приложение интернет‑магазина (Flutter)

Простое и понятное демо‑приложение по макету из Figma: главная с товарами, детали, избранное, корзина и вход.

---

### Вход в приложение  

<img width="458" height="672" alt="image" src="https://github.com/user-attachments/assets/547b6d80-e44a-4fb2-af70-808bed173bd8" />
  
### Страница входа  

<img width="466" height="678" alt="image" src="https://github.com/user-attachments/assets/5acc8c9c-eab8-48d6-af1e-71820f844cf4" />
  
### Главный экран  

<img width="485" height="796" alt="image" src="https://github.com/user-attachments/assets/8a8f2906-c70f-4ce3-bc67-230fbd5eea9f" />
  
### Избранное  

<img width="481" height="795" alt="image" src="https://github.com/user-attachments/assets/7dbe5fe9-6171-4cae-bbbc-82f1838a1643" />


### Корзина

<img width="479" height="799" alt="image" src="https://github.com/user-attachments/assets/bfe6ccb5-ff2c-405d-958e-adfd8ea551d8" />
  
---

### Возможности
- Главная: сетка товаров (`GridView.builder`, адаптивные колонки).
- Детали: изображение, описание, цена, «Добавить в корзину».
- Избранное: добавление/удаление, переход к деталям.
- Корзина: изменение количества, удаление, итоговая сумма.
- Вход: логин по email/password
- Нижнее меню: Home / Favorites / Cart.

---

### Требования
- Flutter 3.0+ / Dart 3.0+
- Android / iOS / Web / macOS

---

### Установка и запуск
```bash
flutter pub get          # зависимости
flutter run              # запуск (автовыбор устройства)
# или
flutter run -d chrome    # запуск в браузере
# релиз (пример для Android)
flutter build apk --release
```

---

### Структура проекта
```text
lib/
  main.dart            // точка входа, состояние, навигация
  models/              // модели (Product, AppUser)
  screens/             // экраны: home/product/favorites/cart/login/start
  widgets/             // общие виджеты (product_card)
  theme/               // стили: colors, text_styles
assets/
  images/              // локальные изображения (подключены в pubspec.yaml)
```

---

### Как это работает
- Состояние (корзина, избранное, вход) хранится в `MyApp` и обновляется через `setState`.
- Переходы — `Navigator.push(...)`; вкладки — `BottomNavigationBar`.
- Товары и картинки локальные (демо), из `assets/images`.
- Логин: `onSubmit(email, password)` — если email новый, создаём пользователя и входим; иначе проверяем пароль.

---

### Соответствие ТЗ (чек‑лист)
- Страницы: Home, Product, Cart, Favorites, Login/Start
- Функции: сетка, детали, корзина, сумма, навигация
- Кастомные цвета/шрифты из `theme/`
- Адаптивность и отступы
- Локальные ассеты и иконки
