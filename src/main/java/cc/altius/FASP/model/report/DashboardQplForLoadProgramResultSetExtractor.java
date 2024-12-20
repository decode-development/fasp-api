/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cc.altius.FASP.model.report;

import cc.altius.FASP.dao.impl.DashboardBottomData;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 *
 * @author akil
 */
public class DashboardQplForLoadProgramResultSetExtractor implements ResultSetExtractor<Integer> {

    private final DashboardForLoadProgram db;
    private final int qplType;

    public DashboardQplForLoadProgramResultSetExtractor(DashboardForLoadProgram db, int qplType) {
        this.db = db;
        this.qplType = qplType;
    }

    @Override
    public Integer extractData(ResultSet rs) throws SQLException, DataAccessException {
        int rows = 0;
        while (rs.next()) {
            int planningUnitId = rs.getInt("PLANNING_UNIT_ID");
            if (!db.getBottomPuData().containsKey(planningUnitId)) {
                db.getBottomPuData().put(planningUnitId, new DashboardBottomData());
            }

            switch (qplType) {
                case 1 -> {
                    // Forecasted Consumption
                    int requiredCount = rs.getInt("REQUIRED_COUNT");
                    int goodCount = rs.getInt("FORECAST_COUNT");
                    if (requiredCount == goodCount) {
                        db.getBottomPuData().get(planningUnitId).setForecastConsumptionQplPassed(true);
                    }
                }
                case 2 -> {
                    db.getBottomPuData().get(planningUnitId).getActualConsumptionDetails().add(new DashboardActualConsumptionDetails(rs.getDate("CONSUMPTION_DATE"), rs.getInt("ACTUAL_COUNT")));
                }
                case 3 -> {
                    // Inventory
                    int inventoryCount = rs.getInt("INVENTORY_COUNT");
                    if (inventoryCount > 0) {
                        db.getBottomPuData().get(planningUnitId).setInventoryQplPassed(true);
                    }
                }
                case 4 -> {
                    // Shipment
                    int receivedDateInPastCount = rs.getInt("RECEIVED_DATE_IN_PAST_COUNT");
                    int shouldHaveSubmittedCount = rs.getInt("SHOULD_HAVE_SUBMITTED_COUNT");
                    if (receivedDateInPastCount == 0 && shouldHaveSubmittedCount == 0) {
                        db.getBottomPuData().get(planningUnitId).setShipmentQplPassed(true);
                    }
                }
            }
            rows++;
        }
        return rows;
    }
}
