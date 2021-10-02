/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.model.rowMapper;

import cc.altius.FASP.model.SimpleCodeObject;
import cc.altius.FASP.model.SimpleObject;
import cc.altius.FASP.model.SimpleUnitAndTracerObject;
import cc.altius.FASP.model.SimpleUnitObject;
import cc.altius.FASP.model.TreeNode;
import cc.altius.FASP.model.TreeNodeData;
import cc.altius.FASP.model.TreeNodeDataFu;
import cc.altius.FASP.model.TreeNodeDataPu;
import cc.altius.FASP.model.UsagePeriod;
import cc.altius.utils.TreeUtils.Node;
import cc.altius.utils.TreeUtils.Tree;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 *
 * @author akil
 */
public class TreeNodeResultSetExtractor implements ResultSetExtractor<Tree<TreeNode>> {

    @Override
    public Tree<TreeNode> extractData(ResultSet rs) throws SQLException, DataAccessException {
        Tree<TreeNode> tree = null;
        try {
            while (rs.next()) {
                Integer parentNodeId = rs.getInt("PARENT_NODE_ID");
                if (rs.wasNull()) {
                    parentNodeId = null;
                }
                int nodeId = rs.getInt("NODE_ID");
                TreeNode tn = getNode(nodeId, parentNodeId, rs, 1);
                Node<TreeNode> n = null;
                if (tree == null) {
                    // Tree is empty so Initialize the Tree
                    n = new Node(tn.getNodeId(), null, tn, tn.getNodeId());
                    tree = new Tree<>(n);
                } else {
                    // Tree is not null so you should search if the Node already exists
                    n = tree.findNodeByPayloadId(nodeId);
                    if (n == null) {
                        // Node was not found so this is a new Node you need to create it and add to the Tree
                        n = new Node(tn.getNodeId(), parentNodeId, tn, tn.getNodeId());
                        tree.addNode(n);
                    } else {
                        // Node was found so just link tn
                        tn = n.getPayload();
                    }
                }
                // Load other data into Payload
                List<TreeNodeData> tndList = tn.getNodeDataMap().get(0);
                if (tndList == null) {
                    tndList = new LinkedList<>();
                    tn.getNodeDataMap().put(0, tndList);
                }
                tndList.add(getNodeData(rs, 1));
            }
        } catch (Exception e) {
            throw new DataAccessResourceFailureException(e.getMessage());
        }
        return tree;
    }

    /**
     * n = new Node(count, null, tn, tn.getNodeId()); tree = new Tree<>(n); }
     * else { n = tree.findNodeByPayloadId(nodeId); if (n==null) { tn =
     * n.getPayload(); } }else { tn = getNode(nodeId, parentNodeId, rs, 1); } if
     * (isFirst) {
     *
     * isFirst = false; } else if (tn == null) { Node<TreeNode> parentNode =
     * tree.findNodeByPayloadId(tn.getParentNodeId()); n = new Node<>(count,
     * parentNode.getId(), tn, tn.getNodeId()); tree.addNode(n); }
     */
    private TreeNode getNode(int nodeId, Integer parentNodeId, ResultSet rs, int count) throws SQLException {
        TreeNode tn = new TreeNode(
                nodeId,
                parentNodeId,
                new SimpleObject(rs.getInt("NODE_TYPE_ID"), new LabelRowMapper("NT_").mapRow(rs, count)),
                new SimpleCodeObject(rs.getInt("U_UNIT_ID"), new LabelRowMapper("U_").mapRow(rs, count), rs.getString("U_UNIT_CODE")),
                new LabelRowMapper().mapRow(rs, count)
        );
        tn.setBaseModel(new BaseModelRowMapper().mapRow(rs, count));
        return tn;
    }

    private TreeNodeData getNodeData(ResultSet rs, int count) throws SQLException {
        TreeNodeData tnd = new TreeNodeData();
        tnd.setNodeDataId(rs.getInt("NODE_DATA_ID"));
        tnd.setMonth(rs.getDate("MONTH"));
        tnd.setDataValue(rs.getDouble("DATA_VALUE"));
        tnd.setNotes(rs.getString("NOTES"));
        tnd.setBaseModel(new BaseModelRowMapper("ND_").mapRow(rs, 1));
        int nodeDataFuId = rs.getInt("NODE_DATA_FU_ID");
        if (!rs.wasNull()) {
            TreeNodeDataFu tndf = new TreeNodeDataFu();
            tndf.setNodeDataFuId(nodeDataFuId);
            tndf.setUsageType(new SimpleObject(rs.getInt("USAGE_TYPE_ID"), new LabelRowMapper("UT_").mapRow(rs, count)));
            tndf.setLagInMonths(rs.getInt("LAG_IN_MONTHS"));
            tndf.setForecastingUnit(new SimpleUnitAndTracerObject(new SimpleObject(rs.getInt("TRACER_CATEGORY_ID"), new LabelRowMapper("TC_").mapRow(rs, count)), new SimpleCodeObject(rs.getInt("FUU_UNIT_ID"), new LabelRowMapper("FUU_").mapRow(rs, count), rs.getString("FUU_UNIT_CODE")), rs.getInt("FORECASTING_UNIT_ID"), new LabelRowMapper("FU_").mapRow(rs, count)));
            tndf.setNoOfPersons(rs.getInt("NO_OF_PERSONS"));
            tndf.setNoOfForecastingUnitsPerPerson(rs.getInt("FORECASTING_UNITS_PER_PERSON"));
            tndf.setOneTimeUsage(rs.getBoolean("ONE_TIME_USAGE"));
            if (tndf.isOneTimeUsage() != true) {
                tndf.setUsageFrequency(rs.getDouble("USAGE_FREQUENCY"));
                tndf.setUsagePeriod(new UsagePeriod(rs.getInt("UPF_USAGE_PERIOD_ID"), new LabelRowMapper("UPF_").mapRow(rs, count), rs.getDouble("UPF_CONVERT_TO_MONTH")));
                if (tndf.getUsageType().getId() == 1) { //
                    tndf.setRepeatCount(rs.getDouble("REPEAT_COUNT"));
                    tndf.setRepeatUsagePeriod(new UsagePeriod(rs.getInt("UPR_USAGE_PERIOD_ID"), new LabelRowMapper("UPR_").mapRow(rs, count), rs.getDouble("UPR_CONVERT_TO_MONTH")));
                }
            }
            tndf.setBaseModel(new BaseModelRowMapper("NDF_").mapRow(rs, count));
        }
        int nodeDataPuId = rs.getInt("NODE_DATA_PU_ID");
        if (!rs.wasNull()) {
            TreeNodeDataPu tndp = new TreeNodeDataPu();
            tndp.setNodeDataPuId(nodeDataPuId);
            tndp.setRefillMonths(rs.getInt("REFILL_MONTHS"));
            tndp.setSharePlanningUnit(rs.getBoolean("SHARE_PLANNING_UNIT"));
            tndp.setPlanningUnit(new SimpleUnitObject(new SimpleCodeObject(rs.getInt("PUU_UNIT_ID"), new LabelRowMapper("PUU_").mapRow(rs, count), rs.getString("PUU_UNIT_CODE")), rs.getInt("PLANNING_UNIT_ID"), new LabelRowMapper("PU_").mapRow(rs, count)));
            tndp.setBaseModel(new BaseModelRowMapper("NDP_").mapRow(rs, count));
        }
        return tnd;
    }

}
