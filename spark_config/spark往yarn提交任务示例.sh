spark-submit \
  --master yarn \
  --deploy-mode client \
  --num-executors 40 \
  --executor-memory 16g \
  --executor-cores 8 \
  --conf spark.dynamicAllocation.enabled=true \
  spark.py
