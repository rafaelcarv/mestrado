package main.scala

import org.apache.spark.sql.SparkSession


object Sum1D {
  def main(args: Array[String]) {
    val spark = SparkSession.builder.appName("1D Sum").getOrCreate()
    import spark.implicits._
    val distFile = spark.read.textFile(args(0))

    val t1 = System.currentTimeMillis
    val line :Double = 0.0
    val data = distFile.map(line => line.toDouble)

    val result = data.reduce(_ + _)
    val t2 = System.currentTimeMillis
    println(result + "," + (t2 - t1) + "," + "spark")
  }
}