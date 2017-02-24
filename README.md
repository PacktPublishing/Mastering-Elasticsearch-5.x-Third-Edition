#Mastering Elasticsearch 5.x - Third Edition
This is the code repository for [Mastering Elasticsearch 5.x - Third Edition](https://www.packtpub.com/big-data-and-business-intelligence/mastering-elasticsearch-50-third-edition?utm_source=github&utm_medium=repository&utm_campaign=9781786460189), published by [Packt](https://www.packtpub.com/?utm_source=github). It contains all the supporting project files necessary to work through the book from start to finish.
## About the Book
This book will give you a brief recap of the basics and also introduce you to the new features of Elasticsearch 5. We will guide you through the intermediate and advanced functionalities of Elasticsearch, such as querying, indexing, searching, and modifying data. We’ll also explore advanced concepts, including aggregation, index control, sharding, replication, and clustering.
##Instructions and Navigation
All of the code is organized into folders. Each folder starts with a number followed by the application name. For example, Chapter02.

Chapters 1 and 8 do not have downloadable code or support files
They contain simple commands

The code will look like the following:
```
public class CustomRestActionPlugin extends Plugin implements ActionPlugin
{
 @Override
 public List<Class<? extends RestHandler>> getRestHandlers() {
 return Collections.singletonList(CustomRestAction.class);
 }
}
```

This book was written using Elasticsearch 5.0.x, and all the examples and functions should work with it. In addition to that, you'll need a command-line tool that allows you to send HTTP requests such as curl, which are available for most operating systems. Please note that all examples in this book use the mentioned curl tool. If you want to use another tool,
please remember to format the request in an appropriate way that is understood by the tool of your choice.
In addition to that, to run examples in Chapter 11, Developing Elasticsearch Plugins, you will need a Java Development Kit (JDK) Version 1.8.0_73 and above installed and an editor that will allow you to develop your code (or a Java IDE such as Eclipse). To build the code and manage dependencies in Chapter 11, Developing Elasticsearch Plugins, we are using Apache Maven.
The last chapter of this book has been written using Elastic Stack 5.0.0, so you will need to have Logstash, Kibana, and Metricbeat, all comprising the same version.

##Related Products
* [Mastering Docker](https://www.packtpub.com/virtualization-and-cloud/mastering-docker?utm_source=github&utm_medium=repository&utm_campaign=9781785287039)

* [Elasticsearch Server - Third Edition](https://www.packtpub.com/big-data-and-business-intelligence/elasticsearch-server-third-edition?utm_source=github&utm_medium=repository&utm_campaign=9781785888816)

* [Machine Learning with Spark](https://www.packtpub.com/big-data-and-business-intelligence/machine-learning-spark?utm_source=github&utm_medium=repository&utm_campaign=9781783288519)

###Suggestions and Feedback
[Click here](https://docs.google.com/forms/d/e/1FAIpQLSe5qwunkGf6PUvzPirPDtuy1Du5Rlzew23UBp2S-P3wB-GcwQ/viewform) if you have any feedback or suggestions.

