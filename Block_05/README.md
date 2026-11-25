# Block 05 — Front-End Programming with React

В этой работе я повторила функциональность Block 04 с использованием React: изменение описания по нажатию кнопки и поиск гор по стране без перезагрузки страницы.

## Используемые технологии

- React 18.2.0 и ReactDOM, подключённые через CDN.
- JSX и Babel для выполнения примеров непосредственно в HTML.
- `React.useState`, обработчики `onClick` и `onChange`.
- Fetch API для получения JSON от JSP.
- Готовый backend: JSP, Tomcat 10 и PostgreSQL.

## 1. Изменение описания — dynamic.html

Компонент `App` хранит текст в состоянии `description`. При нажатии «Показать описание» вызывается `setDescription()`, после чего React обновляет отображение компонента. Прямое изменение `innerHTML` не используется.

До нажатия:

![Начальное состояние описания](images/description-before.png)

После нажатия:

![Описание походов после нажатия](images/description-after.png)

## 2. Поиск гор — ajax.html

Состояние `country` хранит страну, а `result` — текст результата. Обработчик `onChange` обновляет страну при вводе. По нажатию кнопки функция `search()` выполняет запрос:

```javascript
fetch("mountains.jsp?country=" + encodeURIComponent(country))
    .then(response => response.json())
    .then(data => setResult(JSON.stringify(data)));
```

`response.json()` преобразует JSON-ответ в JavaScript-данные. `JSON.stringify()` преобразует их в строку для показа на странице. Обновление состояния вызывает обновление интерфейса без перезагрузки страницы.

До запроса:

![Поиск до отправки запроса](images/search-before.png)

После запроса для Russia:

![Ответ сервера с горой Elbrus](images/search-after.png)

## Как связаны части системы

```text
Браузер: React-компонент App
  → нажатие «Найти горы»
  → fetch: GET mountains.jsp?country=Russia
  → Tomcat выполняет JSP
  → JDBC-запрос к PostgreSQL
  → JSON с результатами
  → setResult обновляет состояние
  → React показывает результат на странице
```

Backend `mountains.jsp` взят из предыдущего блока. Он ищет горы по подстроке страны без учёта регистра через `ILIKE` и возвращает JSON. Изменения в этой работе относятся к frontend. Пользовательская обработка ошибок запроса не добавлена.

## Структура проекта

```text
Block_05/
├── Block_05.zip          # Два frontend-файла для сдачи
├── README.md
├── images/              # Скриншоты до и после действий
└── webapp/
    ├── dynamic.html
    ├── ajax.html
    ├── mountains.jsp
    └── WEB-INF/lib/
        └── postgresql-42.7.7.jar
```

## Запуск

1. Подготовить PostgreSQL с базой `mountain_trekking` из предыдущих блоков. Параметры подключения находятся в `mountains.jsp`.
2. Скопировать содержимое `webapp` в `webapps/Block_05` установленного Tomcat.
3. Запустить Tomcat и открыть:
   - `http://localhost:8080/Block_05/dynamic.html`
   - `http://localhost:8080/Block_05/ajax.html`
4. На первой странице нажать «Показать описание», на второй — ввести страну и нажать «Найти горы».

Для загрузки React и Babel с CDN нужен интернет. AJAX-страницу следует открывать через Tomcat. Архив `Block_05.zip` содержит только `dynamic.html` и `ajax.html`, без backend, драйвера и среды разработки.

## Материалы курса

Работа основана на темах React Basics, JSX and Babel, React Function State, React Events, React Forms и React Communication из [учебника курса](https://scerbakov.com:8443/wbtmaster/courses/is8_starte.htm). Используется React 18 с `ReactDOM.createRoot()` вместо старого `ReactDOM.render()` из части примеров.
