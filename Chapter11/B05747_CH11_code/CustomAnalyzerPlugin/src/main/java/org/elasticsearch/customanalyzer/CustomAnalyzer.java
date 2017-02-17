package org.elasticsearch.customanalyzer;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.Tokenizer;
import org.apache.lucene.analysis.core.WhitespaceTokenizer;

public class CustomAnalyzer extends Analyzer {
  public CustomAnalyzer() {
  }

  @Override
  protected TokenStreamComponents createComponents(String field) {
    final Tokenizer src = new WhitespaceTokenizer();
    return new TokenStreamComponents(src, new CustomFilter(src));
  }
}
