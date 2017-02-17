package org.elasticsearch.customanalyzer;

import org.elasticsearch.common.inject.Inject;
import org.elasticsearch.common.inject.assistedinject.Assisted;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.env.Environment;
import org.elasticsearch.index.Index;
import org.elasticsearch.index.analysis.AbstractIndexAnalyzerProvider;
import org.elasticsearch.index.IndexSettings;

public class CustomAnalyzerProvider extends AbstractIndexAnalyzerProvider<CustomAnalyzer> {
  private final CustomAnalyzer analyzer;

  @Inject
  public CustomAnalyzerProvider(IndexSettings indexSettings, Environment env, @Assisted String name, @Assisted Settings settings) {
      super(indexSettings, name, settings);
      analyzer = new CustomAnalyzer();
  }

  @Override
  public CustomAnalyzer get() {
      return this.analyzer;
  }
}
