package org.elasticsearch.customrest;

import static org.elasticsearch.rest.RestRequest.Method.GET;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.elasticsearch.action.admin.cluster.node.info.NodeInfo;
import org.elasticsearch.action.admin.cluster.node.info.NodesInfoResponse;
import org.elasticsearch.client.node.NodeClient;
import org.elasticsearch.common.inject.Inject;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.rest.BaseRestHandler;
import org.elasticsearch.rest.BytesRestResponse;
import org.elasticsearch.rest.RestController;
import org.elasticsearch.rest.RestRequest;
import org.elasticsearch.rest.RestStatus;

public class CustomRestAction extends BaseRestHandler {
	@Inject
	public CustomRestAction(Settings settings, RestController controller) {
		super(settings);
		// Register your handlers here
		controller.registerHandler(GET, "/_mastering/nodes", this);
	}

	@Override
	protected RestChannelConsumer prepareRequest(RestRequest restRequest, NodeClient client) throws IOException {
		String prefix = restRequest.param("prefix","");
		return channel -> {
			XContentBuilder builder = channel.newBuilder();
			builder.startObject();
			List<String> nodes = new ArrayList<String>();
			NodesInfoResponse response = client.admin().cluster().prepareNodesInfo().setThreadPool(true).get();
			for (NodeInfo nodeInfo : response.getNodes()) {
				String nodeName = nodeInfo.getNode().getName();
				if (prefix.isEmpty()) {
					nodes.add(nodeName);
				} else if (nodeName.startsWith(prefix)) {
					nodes.add(nodeName);
				}
			}
			builder.field("nodes", nodes);
			builder.endObject();

			channel.sendResponse(new BytesRestResponse(RestStatus.OK, builder));
		};
	}
}

