package org.elasticsearch.customanalyzer;

import org.apache.lucene.analysis.TokenFilter;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;

import java.io.IOException;

public class CustomFilter extends TokenFilter {
  private final CharTermAttribute termAttr = addAttribute(CharTermAttribute.class);
  
  protected CustomFilter(TokenStream input) {
    super(input);
  }

  @Override
  public boolean incrementToken() throws IOException {  
    if (input.incrementToken()) {
      char[] originalTerm = termAttr.buffer();
      if (originalTerm.length > 0) {
        StringBuilder builder = new StringBuilder(new String(originalTerm).trim()).reverse();
        termAttr.setEmpty();
        termAttr.append(builder.toString());
      }
      return true;
    } else {
      return false;
    }
  }
}
