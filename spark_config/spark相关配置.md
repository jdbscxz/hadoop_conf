# Spark SQL 与Hive集成(spark-shell)

## 添加配置项

1. 把hadoop集群的core-site.xml,hdfs-site.xml和hive的配置文件hive-site.xml拷贝到spark的conf的目录下

```shell
cp /home/hadoop/hadoop/etc/hadoop/core-site.xml /home/hadoop/spark/conf
cp /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml /home/hadoop/spark/conf
cp /home/hadoop/hive/conf/hive-site.xml /home/hadoop/spark/conf
```

2. 添加hive-site.xml中metastore的url的配置

```xml
    <!-- 指定metastore服务的地址 -->
<property>
    <name>hive.metastore.uris</name>
    <value>thrift://hadoop01:9083</value>
</property>
```

3. 把hive中的MySQL的jar包上传到spark的jars目录下
4. 在spark-env.sh文件中添加hadoop的配置文件地址

```shell
HADOOP_CONF_DIR=/home/hadoop/hadoop/etc/hadoop/
YARN_CONF_DIR=/home/hadoop/hadoop/etc/hadoop/
```

## 启动hive的metastore

```shell
nohup hive --service metastore >/home/hadoop/hive/log/metastore.log 2>&1 &
```

## 测试

```shell
#启动spark-sql
bin/spark-sql
#测试sql语句
spark-sql (default)> show databases;
```

# Spark on Yarn 配置

1. 在spark-env.sh文件中添加hadoop的配置文件地址

```shell
HADOOP_CONF_DIR=/home/hadoop/hadoop/etc/hadoop/
YARN_CONF_DIR=/home/hadoop/hadoop/etc/hadoop/
```

2. yarn的capacity-scheduler.xml文件修改配置保证资源调度按照CPU + 内存模式

```xml
<property> 
    <name>yarn.scheduler.capacity.resource-calculator</name> 
    <!-- <value>org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator</value> --> 
    <value>org.apache.hadoop.yarn.util.resource.DominantResourceCalculator</value> 
</property>
```

# Spark on Yarn日志配置

1. 在yarn-site.xml开启日志功能

```xml
<property>
    <description>Whether to enable log aggregation</description>
    <name>yarn.log-aggregation-enable</name>
    <value>true</value>
</property>
<property>
    <name>yarn.log.server.url</name>
    <value>http://hadoop01:19888/jobhistory/logs</value>
</property>
```

2. 修改mapred-site.xml

```xml
<property>
    <name>mapreduce.jobhistory.address</name>
    <value>hadoop01:10020</value>
</property>
 
<property>
    <name>mapreduce.jobhistory.webapp.address</name>
    <value>hadoop01:19888</value>
</property>
```

3. 修改spakr-defaults.conf文件

```shell
spark.eventLog.dir=hdfs://hadoop01:9000/spark_log/
spark.eventLog.enabled=true
spark.yarn.historyServer.address=http://hadoop01:18018
```

4. 修改spark-evn.sh环境变量

```shell
export SPARK_HISTORY_OPTS="-Dspark.history.ui.port=18018 -Dspark.history.fs.logDirectory=hdfs://hadoop01:9000/spark_log/"
```

5. 启动Hadoop和Spark历史服务器

```shell
# mapred --daemon start historyserver
# $SPARK_HOME/sbin/start-history-server.sh
```

# 启动

```shell
#启动spark-shell
cd $SPARK_HOME/bin
./spark-shell \
--master yarn-client \
--executor-memory 1G \
--num-executors 10

#这里的–master必须使用yarn-client模式，如果指定yarn-cluster，则会报错：
#Error: Cluster deploy mode is not applicable to Spark shells.
#因为spark-shell作为一个与用户交互的命令行，必须将Driver运行在本地，而不是yarn上。
#其中的参数与提交Spark应用程序到yarn上用法一样。

#启动spark-sql
cd $SPARK_HOME/bin
./spark-sql \
--master yarn-client \
--executor-memory 1G \
--num-executors 10
```



[参考文章1][https://developer.aliyun.com/article/917008]

[参考文章2][https://www.cnblogs.com/luengmingbiao/p/12985143.html]