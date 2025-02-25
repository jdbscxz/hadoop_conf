spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --num-executors 40 \
  --executor-memory 16g \
  --executor-cores 8 \
  spark.py
