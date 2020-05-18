# Shell 变量

变量是任何一种编程语言都必不可少的组成部分，变量用来存放各种数据。脚本语言在定义变量时通常不需要指明类型，直接赋值就可以，Shell 变量也遵循这个规则。

## 目录

* [Shell 变量](#shell-变量)
  * [目录](#目录)
  * [定义变量](#定义变量)
  * [使用变量](#使用变量)
  * [只读变量](#只读变量)
  * [删除变量](#删除变量)
  * [变量类型](#变量类型)
  * [内部变量](#内部变量)
  * [变量间接引用](#变量间接引用)
    * [$RANDOM](#random)
  * [双括号结构](#双括号结构)
* [Shell 字符串](#shell-字符串)
  * [单引号](#单引号)
  * [双引号](#双引号)
  * [拼接字符串](#拼接字符串)
  * [获取字符串长度](#获取字符串长度)
  * [提取子字符串](#提取子字符串)
  * [查找子字符串](#查找子字符串)
  * [字串移动](#字串移动)
* [Shell 数组](#shell-数组)
  * [定义数组](#定义数组)
  * [读取数组](#读取数组)
  * [获取数组的长度](#获取数组的长度)
* [特殊字符](#特殊字符)
  * [注释](#注释)
  * [多行注释](#多行注释)
  * [命令分割符](#命令分割符)
  * [结束符](#结束符)
  * [句号/圆点](#%E5%8F%A5%E5%8F%B7%E5%9C%86%E7%82%B9)
  * [命令替换](#命令替换)
  * [退出/退出状态](#%E9%80%80%E5%87%BA%E9%80%80%E5%87%BA%E7%8A%B6%E6%80%81)

--------

## 定义变量

Shell 支持以下三种定义变量的方式：

```shell
your_var=mounui.com 	# 注意：变量名和等号之间不能有空格
your_var='mounui.com'
your_var="mounui.com"
```

变量名的命名须遵循如下规则：

- 命名只能使用英文字母，数字和下划线，首个字符不能以数字开头。
- 中间不能有空格，可以使用下划线（_）。
- 不能使用标点符号。
- 不能使用bash里的关键字（可用help命令查看保留关键字）。

有效的 Shell 变量名示例如下：

```shell
MOUNUI
LD_LIBRARY_PATH
_var
var2
```

无效的变量命名：

```shell
?var=123
user*name=mounui
```

除了显式地直接赋值，还可以用语句给变量赋值，如：

```shell
for file in `ls /etc`
或
for file in $(ls /etc)
```

以上语句将 /etc 下目录的文件名循环出来。

## 使用变量

使用一个定义过的变量，只要在变量名前面加`$`符号即可，如：

```
your_var="qinjx"
echo $your_var
echo ${your_var}
```

变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界，比如下面这种情况：

```shell
for skill in Ada Coffe Action Java; do
    echo "I am good at ${skill}Script"
done
```

> 如果不给skill变量加花括号，写成echo "I am good at $skillScript"，解释器就会把$skillScript当成一个变量（其值为空），代码执行结果就不是我们期望的样子了。

推荐给所有变量加上花括号，这是个好的编程习惯。

已定义的变量，可以被重新定义，如：

```shell
your_var="tom"
echo $your_var
your_var="alibaba"
echo $your_var
```

这样写是合法的，但注意，第二次赋值的时候不能写$your_var="alibaba"，使用变量的时候才加美元符（$）。

## 只读变量

使用 readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变。

下面的例子尝试更改只读变量，结果报错：

```shell
#!/bin/bash
myUrl="http://www.google.com"
readonly myUrl
myUrl="http://www.mounui.com"
```

运行脚本，结果如下：

```shell
/bin/sh: NAME: This variable is read only.
```

## 删除变量

使用 unset 命令可以删除变量。语法：

```shell
unset variable_name		# 此处不加 $ 符号
```

变量被删除后不能再次使用。unset 命令不能删除只读变量。

**实例**

```shell
#!/bin/sh
myUrl="http://www.mounui.com"
unset myUrl
echo $myUrl
```

以上实例执行将没有任何输出。

## 变量类型

运行shell时，会同时存在三种变量：

- **1) 局部变量** 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。
- **2) 环境变量** 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。
- **3) shell变量** shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行

## 内部变量

| 内部变量          | 说明                                                         |
| ----------------- | ------------------------------------------------------------ |
| $BASH             | Bash二进制程序文件的路径                                     |
| $BASH_ENV         | 该环境变量保存一个Bash启动文件路径，当启动一个脚本程序时会去读该环境变量指定的文件。 |
| $BASH_SUBSHELL    | 一个指示子shell(subshell)等级的变量。它是Bash版本3新加入的。 |
| $BASH_VERSINFO[n] | 这个数组含有6个元素，指示了安装的Bash版本的信息。它和$BASH_VERSION相似，但它们还是有一些小小的不同。 |
| $BASH_VERSION     | 安装在系统里的Bash版本。                                     |
| $DIRSTACK         | 在目录堆栈里面最顶端的值(它受pushd和popd的控制)              |
| $EDITOR           | 由脚本调用的默认的编辑器，一般是vi或是emacs。                |
| $EUID             | 有效用户ID                                                   |
| $FUNCNAME         | 当前函数的名字                                               |
| $GLOBIGNORE       | 由通配符(globbing)扩展的一列文件名模式。                     |
| $GROUPS           | 目前用户所属的组                                             |
| $HOME             | 用户的家目录，通常是/home/username                           |
| $HOSTNAME         | 在系统启动时由一个初始化脚本中用hostname命令给系统指派一个名字。然而，gethostname()函数能设置Bash内部变量E$HOSTNAME。 |
| $HOSTTYPE         | 机器类型，像$MACHTYPE一样标识系统硬件。                      |
| $IFS              | 内部字段分隔符                                               |
| $IGNOREEOF        | 忽略EOF：在退出控制台前有多少文件结尾标识（end-of-files,control-D）会被shell忽略。 |
| $LC_COLLATE       | 它常常在.bashrc或/etc/profile文件里被设置，它控制文件名扩展和模式匹配的展开顺序。 |
| $LINENO           | 这个变量表示在本shell脚本中该变量出现时所在的行数。它只在脚本中它出现时有意义，它一般可用于调试。 |
| $MACHTYPE         | 机器类型，识别系统的硬件类型。                               |
| $OLDPWD           | 上一次工作的目录("OLD-print-working-directory",你上一次进入工作的目录) |
| $TZ               | 时区                                                         |
| $MAILCHECK        | 每隔多少秒检查是否有新的信件                                 |
| $OSTYPE           | 操作系统类型                                                 |
| $MANPATH man      | 指令的搜寻路径                                               |
| $PATH             | 可执行程序文件的搜索路径。一般有/usr/bin/, /usr/X11R6/bin/, /usr/local/bin,等等。 |
| $PIPESTATUS       | 此数组变量保存了最后执行的前台管道的退出状态。相当有趣的是，它不一定和最后执行的命令的退出状态一样。 |
| $PPID             | 一个进程的$PPID变量保存它的父进程的进程ID(pid)。用这个变量和pidof命令比较。 |
| $PROMPT_COMMAND   | 这个变量在主提示符前($PS1显示之前)执行它的值里保存的命令。   |
| $PS1              | 这是主提示符（第一提示符），它能在命令行上看见。             |
| $PS2              | 副提示符（第二提示符），它在期望有附加的输入时能看见。它显示像">"的提示。 |
| $PS3              | 第三提示符。它在一个select循环里显示 (参考例子 10-29)。      |
| $PS4              | 第四提示符，它在用-x选项调用一个脚本时的输出的每一行开头显示。它通常显示像"+"的提示。 |
| $PWD              | 工作目录(即你现在所处的目录) ，它类似于内建命令pwd。         |
| $REPLY            | 没有变量提供给read命令时的默认变量．这也适用于select命令的目录，但只是提供被选择的变量项目编号而不是变量本身的值。 |
| $SECONDS          | 脚本已运行的秒数。                                           |
| $SHELLOPTS        | 已经激活的shell选项列表，它是一个只读变量。                  |
| $SHLVL            | SHELL的嵌套级别．指示了Bash被嵌套了多深．在命令行里，$SHLVL是1，因此在一个脚本里，它是2 |
| $TMOUT            | 如果$TMOUT环境变量被设为非零值时间值time，那么经过time这么长的时间后，shell提示符会超时．这将使此shell退出登录 |
| $UID              | 用户ID号，这是当前用户的用户标识号，它在/etc/passwd文件中记录。 |

## 变量间接引用

假设一个变量的值是第二个变量的名字。这样要如何才能从第一个变量处重新获得第二个变量的值？例如，`a=letter_of_alphabet`和`letter_of_alphabet=z`，是否能由a引用得到z ? 这确实可以办到，这种技术被称为间接引用。

```shell
a=letter_of_alphabet   # 变量"a"保存着另外一个变量的名字.
letter_of_alphabet=z
# 直接引用.
echo "a = $a"          # a = letter_of_alphabet

# 间接引用.
eval a=\$$a
echo "Now a = $a"      # 现在 a = z
exit 0
```

### $RANDOM

$RANDOM是Bash的一个返回伪随机整数(范围为0 - 32767)的内部函数(而不是一个常量或变量)，它不应该用于产生加密的密钥。

```shell
# 模拟掷骰子.
SPOTS=6   # 模除 6 会产生 0 - 5 之间的值.
          # 结果增1会产生 1 - 6 之间的值.
          # 多谢Paulo Marcel Coelho Aragao的简化.
die1=0
die2=0
# 这会比仅设置SPOTS=7且不增1好?为什么会好？为什么会不好?

# 单独地掷每个骰子，然后计算出正确的机率.

    let "die1 = $RANDOM % $SPOTS +1" # 掷第一个.
    let "die2 = $RANDOM % $SPOTS +1" # 掷第二个.
    #  上面的算术式中，哪个操作符优先计算 --
    #+ 取模 (%) 还是 加法 (+)?

let "throw = $die1 + $die2"
echo "Throw of the dice = $throw"

exit 0
```

## 双括号结构

用`((...))`结构来使用C风格操作符来处理变量。

```shell
(( a = 23 ))  # 以C风格来设置一个值，在"="两边可以有空格.
echo "a (initial value) = $a"

(( a++ ))     # C风格的计算后自增.
echo "a (after a++) = $a"

(( a-- ))     # C风格的计算后自减.
echo "a (after a--) = $a"


(( ++a ))     # C风格的计算前自增.
echo "a (after ++a) = $a"

(( --a ))     # C风格的计算前自减.
echo "a (after --a) = $a"
```

------

# Shell 字符串

字符串是shell编程中最常用最有用的数据类型（除了数字和字符串，也没啥其它类型好用了），字符串可以用单引号，也可以用双引号，也可以不用引号。单双引号的区别跟PHP类似。

## 单引号

```shell
str='this is a string'
```

单引号字符串的限制：

- 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
- 单引号字串中不能出现单独一个的单引号（对单引号使用转义符后也不行），但可成对出现，作为字符串拼接使用。

## 双引号

```shell
your_var='mounui'
str="Hello, I know you are \"$your_var\"! \n"
echo -e $str
```

输出结果为：

```shell
Hello, I know you are "mounui"!
```

双引号的优点：

- 双引号里可以有变量
- 双引号里可以出现转义字符

## 拼接字符串

```shell
your_var="mounui"
# 使用双引号拼接
greeting="hello, "$your_var" !"
greeting_1="hello, ${your_var} !"
echo $greeting  $greeting_1
# 使用单引号拼接
greeting_2='hello, '$your_var' !'
greeting_3='hello, ${your_var} !'
echo $greeting_2  $greeting_3
```

输出结果为：

```shell
hello, mounui ! hello, mounui !
hello, mounui ! hello, ${your_var} !
```

## 获取字符串长度

```shell
string="abcd"
echo ${#string} #输出 4
```

## 提取子字符串

以下实例从字符串第 **2** 个字符开始截取 **4** 个字符：

```shell
string="mounui is a great site"
echo ${string:1:4} # 输出 unoo
```

`${string:position:length}` 把\$string中​\$postion个字符后面的长度为$length的字符串提取出来。

```shell
# 字串提取
String=abcABC123ABCabc
#       0123456789.....
#       以0开始计算.

echo ${String:0}                            # abcABC123ABCabc
echo ${String:1}                            # bcABC123ABCabc
echo ${String:7}                            # 23ABCabc
echo ${String:7:3}                          # 23A
                                            # 提取的字串长为3

# 有没有可能从字符串的右边结尾处提取?
    
echo ${String:-4}                           # abcABC123ABCabc
# 默认是整个字符串，就相当于${parameter:-default}.
# 然而. . .

echo ${String:(-4)}                         # Cabc 
echo ${String: -4}                          # Cabc
# 这样,它可以工作了.
# 圆括号或附加的空白字符可以转义$position参数.
```

## 查找子字符串

查找字符 **i** 或 **o** 的位置(哪个字母先出现就计算哪个)：

```shell
string="mounui is a great site"
echo `expr index "$string" io`  # 输出 4
```

**注意：** 以上脚本中**\`**是反引号，而不是单引号**'**，不要看错了哦。

## 字串移动

`${string#substring}`从$string左边开始，剥去最短匹配$substring子串。
`${string##substring}`从$string左边开始，剥去最长匹配$substring子串。
`${string%substring}` 从$string结尾开始，剥去最短匹配$substring子串。
`${string%%substring}`从$string结尾开始，剥去最长匹配$substring子串。

```shell
String=abcABC123ABCabc
#       ├----┘     ┆
#       └----------┘

echo ${String#a*C}      # 123ABCabc
# 剥去匹配'a'到'C'之间最短的字符串.

echo ${String##a*C}     # abc
# 剥去匹配'a'到'C'之间最长的字符串.


String=abcABC123ABCabc
#       ┆           ||
#       └------------┘

echo ${String%b*c}      # abcABC123ABCa
# 从$String后面尾部开始，剥去匹配'a'到'C'之间最短的字符串.

echo ${String%%b*c}     # a
# 从$String后面尾部开始，剥去匹配'a'到'C'之间最长的字符串.
```

----------

# Shell 数组

bash支持一维数组（不支持多维数组），并且没有限定数组的大小。

类似于 C 语言，数组元素的下标由 0 开始编号。获取数组中的元素要利用下标，下标可以是整数或算术表达式，其值应大于或等于 0。

## 定义数组

在 Shell 中，用括号来表示数组，数组元素用"空格"符号分割开。定义数组的一般形式为：

```shell
数组名=(值1 值2 ... 值n)
```

例如：

```shell
array_name=(value0 value1 value2 value3)
```

或者

```shell
array_name=(
value0
value1
value2
value3
)
```

还可以单独定义数组的各个分量：

```shell
array_name[0]=value0
array_name[1]=value1
array_name[n]=valuen
```

可以不使用连续的下标，而且下标的范围没有限制。

## 读取数组

读取数组元素值的一般格式是：

```shell
${数组名[下标]}
```

例如：

```shell
valuen=${array_name[n]}
```

使用 @ 符号可以获取数组中的所有元素，例如：

```shell
echo ${array_name[@]}
```

## 获取数组的长度

获取数组长度的方法与获取字符串长度的方法相同，例如：

```shell
# 取得数组元素的个数
length=${#array_name[@]}
# 或者
length=${#array_name[*]}
# 取得数组单个元素的长度
lengthn=${#array_name[n]}
```

-----------

# 特殊字符

## 注释

以 # 开头的行就是注释，会被解释器忽略。

通过每一行加一个 **#** 号设置多行注释，像这样：

```shell
#--------------------------------------------
# 这是一个注释
# author：mounui
# site：www.mounui.com
#--------------------------------------------
##### 用户配置区 开始 #####
#
#
# 这里可以添加脚本描述信息
#
#
##### 用户配置区 结束  #####
```

如果在开发过程中，遇到大段的代码需要临时注释起来，过一会儿又取消注释，怎么办呢？

每一行加个#符号太费力了，可以把这一段要注释的代码用一对花括号括起来，定义成一个函数，没有地方调用这个函数，这块代码就不会执行，达到了和注释一样的效果。

 echo命令给出的一个转义的#字符并不会开始一个注释。同样地，出现在一些参数代换结构和在数值常量表达式中的#字符也同样不会开始一个注释。 

```shell
echo "这里的 # 不会被注释"
echo '这里的 # 不会被注释'
echo 这里的 \# 不会被注释
echo 这里的 # 会被注释

echo ${PATH#*:}       # 前面的#是参数代换，不是注释.
echo $(( 2#101011 ))  # 基本转换，不是注释.
```

## 多行注释

多行注释还可以使用以下格式：

```shell
:<<EOF
注释内容...
注释内容...
注释内容...
EOF
```

EOF 也可以使用其他符号:

```shell
:<<'
注释内容...
注释内容...
注释内容...
'

:<<!
注释内容...
注释内容...
注释内容...
!
```

## 命令分割符

分号`;`命令分割符，分割符允许在同一行里有两个或更多的命令。

```shell
echo hello; echo there         # 输出 hello 和 there
filename='demo2'               # 变量
if [ -x "$filename" ]; then    # 注意："if" and "then"需要分隔符
                               # 思考一下这是为什么?
  echo "File $filename exists."; cp $filename $filename.bak
else
  echo "File $filename not found."; touch $filename
fi; echo "File test complete."
```

## 结束符

双分号`;;`，case语句分支的结束符。

```shell
read Keypress
case "$Keypress" in
  [[:lower:]]   ) echo "Lowercase letter";;
  [[:upper:]]   ) echo "Uppercase letter";;
  [0-9]         ) echo "Digit";;
  *             ) echo "Punctuation, whitespace, or other";;
esac      #  允许字符串的范围出现在[]中,
          #+ 或者POSIX风格的[[中.
exit 0
```

## 句号/圆点

作为一个文件名的组成部分`.`，当点`.`以一个文件名为前缀时，起作用使该文件变成了隐藏文件。这种隐藏文件ls一般是不会显示出来的。

作为目录名时，单个点（.）表示当前目录，两个点(..)表示上一级目录（或称为父目录）。

点(.)字符匹配。作为正则表达式的一部分,匹配字符时，单点（.）表示匹配任意一个字符。

## 命令替换

命令替换"`"，将会重新分配一个命令甚至是多个命令的输出；它会将命令的输出如实地添加到另一个上下文中。

```shell
script_name=`basename $0`
echo "The name of this script is $script_name."

textfile_listing=`ls *`
# 变量中包含了当前工作目录下所有的*文件
echo $textfile_listing
```

通过这个符号，批量删除文件

```shell
rm `cat filename`   # "filename" 包含了需要被删除的文件列表
# 可能会产生"参数列表太长"的错误
# 更好的方法是              xargs rm -- < filename 
# ( -- 同时覆盖了那些以"-"开头的文件所产生的特殊情况 )
```

## 退出/退出状态

`$?` 变量用于测试脚本中的命令执行结果非常的有用。

```shell
echo hello
echo $?    # 因为上一条命令执行成功，打印0。

lskdf      # 无效命令。
echo $?    # 因为上面的无效命令执行失败，打印一个非零的值。

exit 113   # 返回113状态码给shell。
           # 可以运行脚本结束后立即执行命令"echo $?" 检验。

#  依照惯例,命令'exit 0'表示执行成功,
#+ 当产生一个非零退出值时表示一个错误或是反常的条件。
```

下面这些退出状态码，用于保留(reserved meanings) 的含义，不应该在用户脚本使用。

| Exit Code Number | Meaning                                                    | Example            | Comments                                                     |
| ---------------- | ---------------------------------------------------------- | ------------------ | ------------------------------------------------------------ |
| 1                | Catchall for general errors                                | `let "var1 = 1/0"` | Miscellaneous errors, such as "divide by zero"               |
| 2                | Misuse of shell builtins (according to Bash documentation) | -                  | Seldom seen, usually defaults to exit code 1                 |
| 126              | Command invoked cannot execute                             | -                  | Permission problem or command is not an executable           |
| 127              | "command not found"                                        | -                  | Possible problem with $PATH or a typo                        |
| 128              | Invalid argument to exit                                   | `exit 3.14159`     | exit takes only integer args in the range 0 - 255 (see footnote) |
| 128+n            | Fatal error signal "n"                                     | `kill -9 $PPID`    | of script $? returns 137 (128 + 9)                           |
| 130              | Script terminated by Control-C                             | -                  | Control-C is fatal error signal 2, (130 = 128 + 2, see above) |
| 255*             | Exit status out of range                                   | `exit -1`          | exit takes only integer args in the range 0 - 255            |