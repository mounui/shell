# Shell 数组

数组中可以存放多个值。Bash Shell 只支持一维数组（不支持多维数组），初始化时不需要定义数组大小（与 PHP 类似）。

## 目录

* [Shell 数组](#shell-数组)
  * [定义数组](#定义数组)
  * [读取数组](#读取数组)
  * [获取数组中的所有元素](#获取数组中的所有元素)
  * [获取数组的长度](#获取数组的长度)

--------

## 定义数组

与大部分编程语言类似，数组元素的下标由0开始。Shell 数组用括号来表示，元素用"空格"符号分割开，语法格式如下：

```shell
array_name=(value1 ... valuen)
```

**实例**

```shell
#!/bin/bash
# author:mounui
# url:www.mounui.com

my_array=(A B "C" D 5 i)

# 使用下标来定义数组:
array_name[0]=value0
array_name[1]=value1
array_name[2]=value2
```

## 读取数组

读取数组元素值的一般格式是：

```shell
${array_name[index]} 	# index是数组元素的下标，从0开始
```

**实例**

```shell
#!/bin/bash
# author:mounui
# url:www.mounui.com

my_array=(5 i "C" D)

echo "第一个元素为: ${my_array[0]}"
echo "第二个元素为: ${my_array[1]}"
echo "第三个元素为: ${my_array[2]}"
echo "第四个元素为: ${my_array[3]}"
```

执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh
$ ./test.sh
第一个元素为: 5
第二个元素为: i
第三个元素为: C
第四个元素为: D
```

## 获取数组中的所有元素

使用`@`或`*`可以获取数组中的所有元素

```shell
#!/bin/bash
# author:mounui
# url:www.mounui.com

my_array[0]=5
my_array[1]=i
my_array[2]=C
my_array[3]=D

echo "数组的元素为: ${my_array[*]}"
echo "数组的元素为: ${my_array[@]}"
```

执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh
$ ./test.sh
数组的元素为: 5 i C D
数组的元素为: 5 i C D
```

## 获取数组的长度

获取数组长度的方法与获取字符串长度的方法相同，例如：

```
#!/bin/bash
# author:mounui
# url:www.mounui.com

my_array[0]=5
my_array[1]=i
my_array[2]=C
my_array[3]=D

echo "数组元素个数为: ${#my_array[*]}"
echo "数组元素个数为: ${#my_array[@]}"
```

执行脚本，输出结果如下所示：

```shell
$ chmod +x test.sh
$ ./test.sh
数组元素个数为: 4
数组元素个数为: 4
```
