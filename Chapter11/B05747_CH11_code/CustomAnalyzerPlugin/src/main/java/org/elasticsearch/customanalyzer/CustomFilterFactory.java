package org.elasticsearch.customanalyzer;

import org.apache.lucene.analysis.TokenStream;
import org.elasticsearch.common.inject.Inject;
import org.elasticsearch.common.inject.assistedinject.Assisted;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.index.IndexSettings;
import org.elasticsearch.index.analysis.AbstractTokenFilterFactory;
import org.elasticsearch.index.analysis.TokenFilterFactory;

public class CustomFilterFactory extends AbstractTokenFilterFactory implements TokenFilterFactory {
  @Inject
  public CustomFilterFactory(IndexSettings indexSettings, @Assisted String name, @Assisted Settings settings) {
    super(indexSettings, name, settings);
  }

  @Override
  public TokenStream create(TokenStream tokenStream) {
    return new CustomFilter(tokenStream);
  }
}
