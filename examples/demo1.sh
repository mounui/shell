#!/bin/bash

#-------------------
#
# 关系运算符
#
#-------------------
a=24
b=47

if [ "$a" -eq 24 ] && [ "$b" -eq 47 ]
then
  echo "Test #1 succeeds."
else
  echo "Test #1 fails."
fi

# 错误:   if [ "$a" -eq 24 && "$b" -eq 47 ]
#+         这会尝试执行' [ "$a" -eq 24 '
#+         然后会因没找到匹配的']'而失败.
#
#  注意:  if [[ $a -eq 24 && $b -eq 24 ]]也可以.
#  双方括号的if-test比
#+ 单方括号的结构更灵活.

if [ "$a" -eq 98 ] || [ "$b" -eq 47 ]
then
  echo "Test #2 succeeds."
else
  echo "Test #2 fails."
fi

if [ "$a" -eq 24 -a "$b" -eq 47 ]
then
  echo "Test #3 succeeds."
else
  echo "Test #3 fails."
fi


if [ "$a" -eq 98 -o "$b" -eq 47 ]
then
  echo "Test #4 succeeds."
else
  echo "Test #4 fails."
fi


a=rhino
b=crocodile
if [ "$a" = rhino ] && [ "$b" = crocodile ]
then
  echo "Test #5 succeeds."
else
  echo "Test #5 fails."
fi

exit 0

#-------------------
#
# 模拟掷骰子
#
#-------------------
SPOTS=6   # 模除 6 会产生 0 - 5 之间的值。
          # 结果增1会产生 1 - 6 之间的值。
          # 多谢Paulo Marcel Coelho Aragao的简化。
die1=0
die2=0
# 这会比仅设置SPOTS=7且不增1好?为什么会好？为什么会不好?

# 单独地掷每个骰子，然后计算出正确的机率。

    let "die1 = $RANDOM % $SPOTS +1" # 掷第一个。
    let "die2 = $RANDOM % $SPOTS +1" # 掷第二个。
    #  上面的算术式中，哪个操作符优先计算 --
    #+ 取模 (%) 还是 加法 (+)?

let "throw = $die1 + $die2"
echo "Throw of the dice = $throw"
echo "$die1 , $die2"

exit 0

#-------------------
#
# 通过 date 生成随机数
#
#-------------------
echo "The number of days since the year's beginning is `date +%j`."
# 需要在调用格式的前边加上一个 '+' 号。
# %j 给出今天是本年度的第几天。

echo "The number of seconds elapsed since 01/01/1970 is `date +%s`."
#  %s 将产生从 "UNIX 元年" 到现在为止的秒数,
# yields number of seconds since "UNIX epoch" began,
#+ 但是这东西有用么?

prefix=temp
suffix=$(date +%s)  # 'date'命令的 "+%s" 选项是 GNU-特性.
filename=$prefix.$suffix
echo $filename
#  这是一种非常好的产生 "唯一" 的临时文件的办法,
#+ 甚至比使用 $$ 都强.

# 如果想了解 'date' 命令的更多选项, 请查阅这个命令的 man 页.

exit 0

#-------------------
#
# 用((...))结构来使用C风格操作符来处理变量
#
#-------------------
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

#-------------------
#
# 用10种不同的方法计数到11
#
#-------------------
n=1; echo -n "输出1=>$n " # 输出1

let "n = $n + 1"   # let "n = n + 1"也可以
echo -n "输出2=>$n "      # 输出2


: $((n = $n + 1))
#  ":"是需要的，
#+ 否则Bash会尝试把"$((n = $n + 1))"作为命令运行
echo -n "输出3=>$n "      # 输出3

(( n = n + 1 ))
#  上面是更简单的可行的办法
echo -n "输出4=>$n "      # 输出4

n=$(($n + 1))
echo -n "输出5=>$n "      # 输出5

: $[ n = $n + 1 ]
#  ":"是需要的，
#+ 否则Bash会尝试把"$[ n = $n + 1 ]"作为命令运行。
#  即使"n"被当作字符串来初始化也能工作。
echo -n "输出6=>$n "      # 输出6

n=$[ $n + 1 ]
#  即使"n"被当作字符串来初始化也能工作。
#* 应避免这种使用这种结构,因为它是被废弃并不可移植的。
echo -n "输出7=>$n "      # 输出7

# 现在是C风格的增加操作。

let "n++"                 # let "++n"也可以。
echo -n "输出8=>$n "      # 输出8

(( n++ ))                 # (( ++n )也可以。
echo -n "输出9=>$n "      # 输出9

: $(( n++ ))              # : $(( ++n ))也可以。
echo -n "输出10=>$n "     # 输出10

: $[ n++ ]                # : $[ ++n ]]也可以。
echo -n "输出11=>$n "     # 输出11