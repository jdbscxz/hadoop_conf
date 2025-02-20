## 设置 JAVA 安装目录
JAVA_HOME=/home/hadoop/jdk
 
## HADOOP 软件配置文件目录，读取 HDFS 上文件和运行 YARN 集群
HADOOP_CONF_DIR=/home/hadoop/hadoop/etc/hadoop/
YARN_CONF_DIR=/home/hadoop/hadoop/etc/hadoop/
 
## 指定 spark 老大 Master 的 IP 和提交任务的通信端口
# 告知 Spark 的 master 运行在哪个机器上
export SPARK_MASTER_HOST=hadoop01
# 告知 spark master 的通讯端口
export SPARK_MASTER_PORT=7077
# 告知 spark master 的 webui 端口
SPARK_MASTER_WEBUI_PORT=8080
 
# worker cpu 可用核数
SPARK_WORKER_CORES=1
# worker 可用内存
SPARK_WORKER_MEMORY=2g
# worker 的工作通讯地址
#SPARK_WORKER_PORT=7078
# worker 的 webui 地址
#SPARK_WORKER_WEBUI_PORT=8082
 
## 设置历史服务器
# 配置的意思是将 spark 程序运行的历史日志，存到 hdfs 的 /spark_log 文件夹中
SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=hdfs://hadoop01:9000/spark_log/ -Dspark.history.fs.cleaner.enabled=true"
 
# 如果 hadoop 集群是 HA，则需要用下面的设置。要使用则把注释去掉
#SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory=hdfs://mycluster/spark_log/ -Dspark.history.fs.cleaner.enabled=true"