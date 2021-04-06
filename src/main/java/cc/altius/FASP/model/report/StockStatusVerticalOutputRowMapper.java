/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.model.report;

import cc.altius.FASP.model.SimpleCodeObject;
import cc.altius.FASP.model.SimpleObject;
import cc.altius.FASP.model.rowMapper.LabelRowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 *
 * @author akil
 */
public class StockStatusVerticalOutputRowMapper implements ResultSetExtractor<List<StockStatusVerticalOutput>> {

    @Override
    public List<StockStatusVerticalOutput> extractData(ResultSet rs) throws SQLException, DataAccessException {
        List<StockStatusVerticalOutput> ssvList = new LinkedList<>();
        while (rs.next()) {
            StockStatusVerticalOutput ssv = new StockStatusVerticalOutput();
            ssv.setDt(rs.getDate("TRANS_DATE"));
            ssv.setPlanningUnit(new SimpleObject(rs.getInt("PLANNING_UNIT_ID"), new LabelRowMapper("PLANNING_UNIT_").mapRow(rs, 1)));
            int index = ssvList.indexOf(ssv);
            if (index == -1) {
                ssv.setOpeningBalance(rs.getLong("FINAL_OPENING_BALANCE"));
                ssv.setActualConsumption(rs.getBoolean("ACTUAL"));
                if (rs.wasNull()) {
                    ssv.setActualConsumption(null);
                }
                ssv.setActualConsumptionQty(rs.getLong("ACTUAL_CONSUMPTION_QTY"));
                if (rs.wasNull()) {
                    ssv.setActualConsumptionQty(null);
                }
                ssv.setForecastedConsumptionQty(rs.getLong("FORECASTED_CONSUMPTION_QTY"));
                if (rs.wasNull()) {
                    ssv.setForecastedConsumptionQty(null);
                }
                ssv.setFinalConsumptionQty(rs.getLong("FINAL_CONSUMPTION_QTY"));
                if (rs.wasNull()) {
                    ssv.setFinalConsumptionQty(null);
                }
                ssv.setShipmentQty(rs.getLong("SQTY"));
                if (rs.wasNull()) {
                    ssv.setShipmentQty(null);
                }
                ssv.setAdjustment(rs.getLong("ADJUSTMENT"));
                if (rs.wasNull()) {
                    ssv.setAdjustment(null);
                }
                ssv.setExpiredStock(rs.getLong("EXPIRED_STOCK"));
                if (rs.wasNull()) {
                    ssv.setExpiredStock(null);
                }
                ssv.setClosingBalance(rs.getLong("FINAL_CLOSING_BALANCE"));
                if (rs.wasNull()) {
                    ssv.setClosingBalance(null);
                }
                ssv.setAmc(rs.getDouble("AMC"));
                if (rs.wasNull()) {
                    ssv.setAmc(null);
                }
                ssv.setMos(rs.getDouble("MoS"));
                if (rs.wasNull()) {
                    ssv.setMos(null);
                }
                ssv.setMinMos(rs.getInt("MIN_MONTHS_OF_STOCK"));
                ssv.setMaxMos(rs.getInt("MAX_MONTHS_OF_STOCK"));
                ssv.setUnmetDemand(rs.getLong("UNMET_DEMAND"));
                if (rs.wasNull()) {
                    ssv.setUnmetDemand(null);
                }
                ssvList.add(ssv);
            } else {
                ssv = ssvList.get(index);
            }
            rs.getInt("SHIPMENT_ID");
            if (!rs.wasNull()) {
                ShipmentInfo si = new ShipmentInfo(
                        rs.getInt("SHIPMENT_ID"),
                        rs.getLong("SHIPMENT_QTY"),
                        new SimpleCodeObject(rs.getInt("FUNDING_SOURCE_ID"), new LabelRowMapper("FUNDING_SOURCE_").mapRow(rs, index), rs.getString("FUNDING_SOURCE_CODE")),
                        new SimpleCodeObject(rs.getInt("PROCUREMENT_AGENT_ID"), new LabelRowMapper("PROCUREMENT_AGENT_").mapRow(rs, index), rs.getString("PROCUREMENT_AGENT_CODE")),
                        new SimpleObject(rs.getInt("SHIPMENT_STATUS_ID"), new LabelRowMapper("SHIPMENT_STATUS_").mapRow(rs, index)),
                        rs.getString("NOTES"),
                        rs.getString("EDD"),
                        new SimpleObject(rs.getInt("DATA_SOURCE_ID"), new LabelRowMapper("DATA_SOURCE_").mapRow(rs, index))
                );
                ssv.getShipmentInfo().add(si);
            }
            rs.getInt("CONSUMPTION_ID");
            if (!rs.wasNull()) {
                ConsumptionInfo ci = new ConsumptionInfo(
                        rs.getString("CONSUMPTION_NOTES"),
                        rs.getString("CONSUMPTION_DATE"),
                        rs.getInt("CONSUMPTION_ID"),
                        new SimpleObject(rs.getInt("CONSUMPTION_DATA_SOURCE_ID"), new LabelRowMapper("CONSUMPTION_DATA_SOURCE_").mapRow(rs, index)),
                        new SimpleObject(rs.getInt("CONSUMPTION_REGION_ID"), new LabelRowMapper("CONSUMPTION_REGION_").mapRow(rs, index)),
                        rs.getBoolean("ACTUAL_FLAG")
                );
                ssv.getConsumptionInfo().add(ci);
            }
            rs.getInt("INVENTORY_ID");
            if (!rs.wasNull()) {
                InventoryInfo ii = new InventoryInfo(
                        rs.getString("INVENTORY_NOTES"),
                        rs.getString("INVENTORY_DATE"),
                        rs.getInt("INVENTORY_ID"),
                        new SimpleObject(rs.getInt("INVENTORY_DATA_SOURCE_ID"), new LabelRowMapper("INVENTORY_DATA_SOURCE_").mapRow(rs, index)),
                        new SimpleObject(rs.getInt("INVENTORY_REGION_ID"), new LabelRowMapper("INVENTORY_REGION_").mapRow(rs, index)),
                        rs.getDouble("ADJUSTMENT_QTY"),
                        rs.getDouble("ACTUAL_QTY")
                );
                ssv.getInventoryInfo().add(ii);
            }
        }
        return ssvList;
    }

}
