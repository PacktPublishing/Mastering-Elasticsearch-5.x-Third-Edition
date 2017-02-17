package org.elasticsearch.customrest;

import java.util.Collections;
import java.util.List;
import org.elasticsearch.plugins.ActionPlugin;
import org.elasticsearch.plugins.Plugin;
import org.elasticsearch.rest.RestHandler;


public class CustomRestPlugin extends Plugin implements ActionPlugin {
      
	  @Override
	  public List<Class<? extends RestHandler>> getRestHandlers() {
		  return Collections.singletonList(CustomRestAction.class);
	  }  
}
