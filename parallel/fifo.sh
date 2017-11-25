Nproc=4                        #the limit number of precesses; Nproc=3 设定同时执行的进程数上限
Pfifo="/tmp/$$.fifo"           #create a fifo type file; 新建一个后缀为fifo的FIFO文件，以PID作为文件名以避免出现重名情况
mkfifo $Pfifo                  #create a named fifo; mkfifo命令，以上面的文件名创建一个命名管道
exec 6<>$Pfifo                 #fd is 6; 以读写方式打开命名管道，并设置文件标识符为6
rm -f $Pfifo                   #删除FIFO文件，可有可无

#initilize the pipe
for((i=1; i<=Nproc; i=i+1)); do #往命名管道中写入Nproc个空行，用来模拟Nproc个令牌
	echo $i
done >&6

filelist="text.txt"
#Loop
while read line                 #从文件中读取一行数据到变量line中
do
	read -u6                    #从命名管道中读取一行，模拟领取一个令牌。由于FIFO特殊的读写机制，若没有空余的行可以读取，则进程会等待直至有可以读取的空余行
	{                           #若领取到令牌，运行核心程序段，完成后往命名管道写入一行，模拟归还令牌操作；这些操作都是在后台完成，故之后加上 & 命令
		./test.sh $line
		echo >&6
	} &
done < $filelist

wait                            # waiting for all the backgroud processes finished 等待所有后台进程完成
exec 6>&-                       #释放文件标识符
