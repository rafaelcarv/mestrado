package main.scala
import org.apache.spark.SparkConf
import org.apache.spark.SparkContext


object Sum1D {
  def main(args: Array[String]) {
    val conf = new SparkConf().setAppName("1D Sum").setMaster("local")
    val sc = new SparkContext(conf)
    val distFile = sc.textFile(args(0))

    for( a <- 1 to 30) {
      val t1 = System.currentTimeMillis
      val data = distFile.map(line => line.toDouble)

      val result = data.reduce(_ + _)
      val t2 = System.currentTimeMillis
      println(result + "," + (t2 - t1) + "," + "spark")
    }
  }
}