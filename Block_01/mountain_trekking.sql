-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:8889
-- Время создания: Сен 27 2026 г., 19:06
-- Версия сервера: 8.0.44
-- Версия PHP: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `mountain trekking`
--

-- --------------------------------------------------------

--
-- Структура таблицы `HIKERS`
--

CREATE TABLE `HIKERS` (
  `H#` int NOT NULL,
  `Hfirstname` varchar(20) DEFAULT NULL,
  `Hlastname` varchar(20) DEFAULT NULL,
  `Hexperience` int DEFAULT NULL,
  `Hemail` varchar(30) DEFAULT NULL,
  `Hphone` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `HIKERS`
--

INSERT INTO `HIKERS` (`H#`, `Hfirstname`, `Hlastname`, `Hexperience`, `Hemail`, `Hphone`) VALUES
(101, 'John', 'Doe', 5, 'john@example.com', 12345678901),
(102, 'Alice', 'Smith', 2, 'alice@example.com', 98765432109);

-- --------------------------------------------------------

--
-- Структура таблицы `MOUNTAINS`
--

CREATE TABLE `MOUNTAINS` (
  `M#` int NOT NULL,
  `Mname` varchar(30) DEFAULT NULL,
  `Mheight` int DEFAULT NULL,
  `Mcountry` varchar(30) DEFAULT NULL,
  `Mdifficulty` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `MOUNTAINS`
--

INSERT INTO `MOUNTAINS` (`M#`, `Mname`, `Mheight`, `Mcountry`, `Mdifficulty`) VALUES
(1, 'Everest', 8848, 'Nepal', 'Hard'),
(2, 'Mont Blanc', 4810, 'France', 'Medium'),
(3, 'Elbrus', 5642, 'Russia', 'Medium');

-- --------------------------------------------------------

--
-- Структура таблицы `PARTICIPANTS`
--

CREATE TABLE `PARTICIPANTS` (
  `P#` int NOT NULL,
  `T#` int NOT NULL,
  `H#` int NOT NULL,
  `Pregistrationdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `PARTICIPANTS`
--

INSERT INTO `PARTICIPANTS` (`P#`, `T#`, `H#`, `Pregistrationdate`) VALUES
(1, 1001, 101, '2026-05-01');

-- --------------------------------------------------------

--
-- Структура таблицы `TRIPS`
--

CREATE TABLE `TRIPS` (
  `T#` int NOT NULL,
  `M#` int NOT NULL,
  `Ttripdate` date DEFAULT NULL,
  `Tduration` int DEFAULT NULL,
  `Torganizername` varchar(30) DEFAULT NULL,
  `Tmaxparticipants` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `TRIPS`
--

INSERT INTO `TRIPS` (`T#`, `M#`, `Ttripdate`, `Tduration`, `Torganizername`, `Tmaxparticipants`) VALUES
(1001, 1, '2026-06-15', 14, 'Alpine Club', 10);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `HIKERS`
--
ALTER TABLE `HIKERS`
  ADD PRIMARY KEY (`H#`);

--
-- Индексы таблицы `MOUNTAINS`
--
ALTER TABLE `MOUNTAINS`
  ADD PRIMARY KEY (`M#`);

--
-- Индексы таблицы `PARTICIPANTS`
--
ALTER TABLE `PARTICIPANTS`
  ADD PRIMARY KEY (`P#`),
  ADD KEY `T#` (`T#`),
  ADD KEY `H#` (`H#`);

--
-- Индексы таблицы `TRIPS`
--
ALTER TABLE `TRIPS`
  ADD PRIMARY KEY (`T#`),
  ADD KEY `M#` (`M#`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `PARTICIPANTS`
--
ALTER TABLE `PARTICIPANTS`
  ADD CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`T#`) REFERENCES `TRIPS` (`T#`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `participants_ibfk_2` FOREIGN KEY (`H#`) REFERENCES `HIKERS` (`H#`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `TRIPS`
--
ALTER TABLE `TRIPS`
  ADD CONSTRAINT `trips_ibfk_1` FOREIGN KEY (`M#`) REFERENCES `MOUNTAINS` (`M#`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
