/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.model.report;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author ekta
 */
public class AnnualShipmentCostOutputRowMapper implements RowMapper<AnnualShipmentCostOutput>{
      @Override
    public AnnualShipmentCostOutput mapRow(ResultSet rs, int i) throws SQLException {
        AnnualShipmentCostOutput asco=new AnnualShipmentCostOutput();
        return asco;
    }
    
}
