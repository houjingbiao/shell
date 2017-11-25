参考网址：http://blog.csdn.net/yjn03151111/article/details/41244713
xargs: 用于执行命令，执行的命令需要有输入，强大之处在于它可以执行所执行命令的运行环境，比如是否并行等
xargs与其他命令在一起使用的例子:
find . -name "*.txt" -print0 | xargs -0 rm -rf  #查找并且输出文件.txt结尾的文件
find . -name "*.c" | xargs grep 'stdlib.h'  #查找内容包含stdlib.h的文件