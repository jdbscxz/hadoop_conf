# 启动历史服务器
cd spark/sbin/
./start-history-server.sh 
 
# 启动全部 master 和 worker
./start-all.sh 
 
# 或者可以一个个启动:
# 启动当前机器的 master
sbin/start-master.sh
# 启动当前机器的 worker
sbin/start-worker.sh
 
# 停止全部
sbin/stop-all.sh
 
# 停止当前机器的 master
sbin/stop-master.sh
 
# 停止当前机器的 worker
sbin/stop-worker.sh
 