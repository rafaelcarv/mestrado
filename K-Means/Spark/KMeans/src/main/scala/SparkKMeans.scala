package main.scala

import org.apache.spark.{SparkConf, SparkContext}
// $example on$
import org.apache.spark.mllib.linalg.Vectors
// $example off$

object SparkKMeans {

  def main(args: Array[String]) {

    val conf = new SparkConf().setAppName("KMeansExample")
    val sc = new SparkContext(conf)

    // $example on$
    // Load and parse the data
    val startTime = System.currentTimeMillis()
    val data = sc.textFile(args(0))
    val parsedData = data.map(s => Vectors.dense(s.split(',').map(_.toDouble))).cache()

    // Cluster the data into two classes using KMeans
    val numClusters = args(1).toInt
    val numIterations = args(2).toInt
    val clusters = KMeans.train(parsedData, numClusters, numIterations)

    // Evaluate clustering by computing Within Set Sum of Squared Errors
    val WSSSE = clusters.computeCost(parsedData)
    println()
    val finishTime = System.currentTimeMillis() - startTime
    println("" + finishTime + ",Spark")
    sc.stop()
  }
}