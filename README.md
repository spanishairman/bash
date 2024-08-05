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

##### Задание переменных, как результат вывода команды
Для этого подойдут следующие способы: **mydir=``pwd``** или **mydir=$(pwd)**.
