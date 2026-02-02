from pyspark.context import SparkContext
from awsglue.context import GlueContext
from pyspark.sql.functions import col

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

PROCESSED = "s3://etl-ap-south-1/processed/"
CURATED = "s3://etl-ap-south-1/curated/"

df = spark.read.parquet(PROCESSED)
df = df.withColumn("total_amount", col("price") * col("quantity"))
df.write.mode("overwrite").parquet(CURATED)
