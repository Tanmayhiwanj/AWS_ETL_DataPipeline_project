from pyspark.context import SparkContext
from awsglue.context import GlueContext

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

RAW = "s3://etl-ap-south-1/raw/"
PROCESSED = "s3://etl-ap-south-1/processed/"

df = spark.read.option("header","true").csv(RAW)
df = df.dropna().dropDuplicates(["order_id"])
df.write.mode("overwrite").parquet(PROCESSED)
