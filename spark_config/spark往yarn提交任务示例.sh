spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --num-executors 40 \
  --executor-memory 8g \
  --executor-cores 16 \
  spark.py
