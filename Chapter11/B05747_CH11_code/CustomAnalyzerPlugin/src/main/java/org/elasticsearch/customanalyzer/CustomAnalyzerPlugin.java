package org.elasticsearch.customanalyzer;


import static java.util.Collections.singletonMap;

import java.util.Map;

import org.apache.lucene.analysis.Analyzer;
import org.elasticsearch.index.analysis.AnalyzerProvider;
import org.elasticsearch.indices.analysis.AnalysisModule.AnalysisProvider;
import org.elasticsearch.plugins.AnalysisPlugin;
import org.elasticsearch.plugins.Plugin;


public class CustomAnalyzerPlugin extends Plugin implements AnalysisPlugin {
	@Override
    public Map<String, AnalysisProvider<AnalyzerProvider<? extends Analyzer>>> getAnalyzers() {
        return singletonMap("mastering_analyzer", CustomAnalyzerProvider::new);
    }
}