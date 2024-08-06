### Bash
Bash (Bourne-again Shell) — командная оболочка/язык программирования проекта GNU. Название представляет собой отсылку к предшественнику, существовавшей некогда командной оболочке Борна (Bourne shell). 
Bash работает в большинстве UNIX-подобных операционных систем, в том числе и в GNU/Linux. 

[Источник](https://wiki.archlinux.org/title/Bash_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9))

#### Типы переменных
  - *Локальные переменные* - определены в текущей сессии;
  - *Пользовательские переменные* - определены для конкретного пользователя, загружаются при входе в систему;
  - *Системные переменные* - определены во всей системе, доступны всем пользователям.

#### Конфигурационные файлы
  - **~/.bashrc** - В bash существует 3 различных типа оболочек: оболочка входа в систему - *login shell*, обычная оболочка - *normal shell* и интерактивная оболочка - *interactive shell*. 
Оболочки входа в систему читают **~/.profile**, а интерактивные оболочки читают **~/.bashrc**; в нашей настройке **/etc/profile** является источником для  **~/.bashrc** - таким образом, все настройки, сделанные здесь, также вступят в силу в оболочке входа.

  - **~/.bash_profile (.profile)** - Этот файл читается каждый раз при запуске оболочки входа в систему. Все остальные интерактивные оболочки будут читать только .bashrc; это особенно важно для языковых настроек, см. ниже.
> [!IMPORTANT]
> Большинство приложений поддерживают несколько языков вывода. Чтобы воспользоваться этой функцией, просто раскомментируйте одну из строк ниже или добавьте свой собственный (дополнительные коды см. в /usr/share/locale/locale.alias).
> Это перезапишет системный набор по умолчанию в /etc/sysconfig/language. в переменной RC_LANG.
```
#export LANG=de_DE.UTF-8        # uncomment this line for German output
#export LANG=fr_FR.UTF-8        # uncomment this line for French output
#export LANG=es_ES.UTF-8        # uncomment this line for Spanish output
```

  - **/etc/environment** - Определяет переменные окружения на системном уровне.

  - **/etc/bashrc** - Системный *bashrc* для локальных пользователей.

  - **/etc/profile** - Системный *profile* - переменные доступны для пользователей при удалённых сеансах входов.
#### Переменные
Примеры зарезервированных переменных:
  - *$@* - Параметры скрипта, вывод в столбик;
  - *$** - Параметры скрипта - строчный вывод;
  - *$0* - Имя скрипта;
  - *$1,$2,$3,...,* - Параметры скрипта по порядку; 
  - *$#* - Количество параметров;
  - *$?* - Статус выхода последней выполненной команды; 
  - *$$* - PID оболочки;
  - *$!* - PID последней, выполненной в фоновом режиме, команды.

Объявление переменных.
```
foo="Hello!"
echo $foo
Hello!
export foo
export -p | grep foo
declare -x foo="Hello!"
```

Удаление переменных:
```
env -i
```

Запуск оболочки без переменных
```
env -i bash
```

`unset var_nanme ` - Удалит переменную окружения (в.т. системную) в текущей сессии до её окончания.

#### Специальные символы
  - `^` - Начало строки;
  - `$` - конец строки;
  - `.` - любой символ;
  - `\` - экрнирование символа;
  - `[A-Z]` - диапазоны перечисления;
  - `[xyz]` - любой из символов;
  - `[^xyz]` - исключаемые символы;
  - `*` - любое кол-во символов.

#### Bash скрипты

  - **Shebang** - указывет интерпретатор скрипта и выглядит так: `#!/bin/bash` или `#!/bin/sh` или, например, так: `#!/usr/bin/python`. 

> [!TIP]
> Найти исполняемый файла *bash* можно с помощью команды `whereis bash`.
Пример:
```
whereis bash
bash: /usr/bin/bash /bin/bash /usr/share/bash /usr/share/man/man1/bash.1.gz /usr/share/info/bash.info.gz
```
Для отладки скрипта можно вызвать его с помощью команды `bash -x script.sh` или заранее прописать в *shebang* следующим образом: `#!/bin/bash -x`.

##### Задание переменной, как результат вывода команды
Для этого можно использовать *грависы* (обратные кавычки), заключив в них команду при определении переменной, или используя конструкцию *variable=$(command)*, например: `mydir=$(pwd)`.

##### Математические операции
Пример:
```
var1=$(( 5 + 5 ))
echo $var1
10
var2=$(( $var1 * 2 ))
echo $var2
20
```
См. также [Команда let](https://linuxcookbook.ru/articles/komanda-let)

##### Сравнение строк
  - `str1 = str2` - Истина, если строки идентичны;
  - `str1 != str2` - Истина, если строки различаются;
  - `str1 < str2` - Истина, если str1 меньше, чем str2;
  - `str1 > str2` - Истина, если str1 больше, чем str2.
  - `-n str1` - истина, если длина str1 ненулевая;
  - `-z str1` - Истина, если длина str1 равна нулю.

##### Работа с файлами и каталогами
  - `-d file` - Истина, если файл существует и это директория; 
  - `-f file` - истина, если файл существует и это файл;
  - `-e file` - истина, если файл существует;
  - `-r file` - истина, если файл доступен для чтения;
  - `-w file` - истина, если файл доступен для записи;
  - `-s file` - истина, если файл пустой;
  - `-x file` - истина, если файл исполняемый;
  - `file1 -nt file2` - истина, если file1 новее file2;
  - `file1 -ot file2` - истина, если file1 старее file2;
  - `-O file1` - истина, если файл существует и текущий пользователь является владельцем
  - `-G file1` - истина, если файл существует и его идентификатор группы равен идентификатору группы текущего пользователя.
##### Вывод текстовой информации из файла на экран - cat, tac
Ключи:
  - `-b` - Пронумеровать непустые строки;
  - `-n` - пронумеровать все строки;
  - `-s` - объединить несколько идущих подряд пустых строк в одну;
  - `-T` - отобразить символы табуляции как "^|";
  - `-E` - отобразить символы конца строки как "$".

##### Вывод текстовой информации из файла на экран - head, tail
**Head** - вывод строк с начала файла.

Ключи:
  - `-n, --lines` - вывести заданное кол-во строк;
  - `-c, --bytes` - вывести заданное кол-во байт;
  - `-q, --quiet, --silent` - не выводить заголовки файлов.

**Tail** - вывод строк с конца файла.

Ключи:
  - `-n, --lines` - вывести заданное кол-во строк;
  - `-c, --bytes` - вывести заданное кол-во байт;
  - `-f, --follow` - выводить новые данные из файла по мере его увеличения.

##### wc - Подсчёт количества строк, слов и символов в тексте
Ключи:
  - `-l` - подсчёт кол-ва строк;
  - `-w` - подсчёт кол-ва слов;
  - `-c` - подсчёт кол-ва символов;
  - `-b` - подсчёт кол-ва байт.

##### paste - Объединение строк файлов

Ключи:
  - `-d` - Изменение разделителя на заданный вместо [Tab] по умолчанию;
  - `-s` - Объединение строк в файле в одну строку.

##### tr - Замена или удаление символов
Использование - *tr [OPTION]... STRING1 [STRING2]*

Ключи:
  - `-d` - вместо замены удалить символы.
